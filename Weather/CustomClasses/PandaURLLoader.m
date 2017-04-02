//
//  PandaURLLoader.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "PandaURLLoader.h"


@implementation PandaURLLoader

@synthesize error = error_, completeData;
@synthesize userInfo;
@synthesize connection_;
@synthesize totalCompleted;
@synthesize expectedBytes;
@synthesize bytesReceived;
@synthesize post;
@synthesize postingData;
@synthesize delegate;
@synthesize multipartForm;
@synthesize postingDictionary;
@synthesize timeoutInSeconds;
@synthesize responseString;
@synthesize downloadProgressDelegate;
@synthesize numberOfRetryAttempts;
@synthesize maxNumberOfRetryAttempts;
@synthesize uploadProgressDelegate;

#pragma mark -
#pragma mark Initialization & Memory Management

+ (id) requestWithURL:(NSURL *)url
{
    return [[self alloc] initWithURL:url userInfo:nil delegate:nil];
}

- (id)initWithURL:(NSURL *)url userInfo:(NSMutableDictionary *) userInfo_ delegate:(id) delegate_
{
	NSParameterAssert( url );
	if( (self = [super init]) ) {
		connectionURL_ = [url copy];
		//actionType = tempActionType;
        userInfo = userInfo_;
        delegate = delegate_;
        
        multipartForm = NO;
        post = NO;
        
        timeoutInSeconds = 5.0;
        
        maxNumberOfRetryAttempts = 2;
        
        postingDictionary = [NSMutableDictionary dictionary];
	}
    
    
	return self;
}

- (void) setPostValue:(id <NSObject>)value forKey:(NSString *) key
{
    if(value && key)
    {
        [postingDictionary setObject:[value description] forKey:key];
    }
}


- (NSMutableData *) formulatePostingData:(NSDictionary *)dataDictionary
{
    NSMutableData *bodyData = [NSMutableData data];
    
    NSString *boundary = @"---------------------------Boundary Line---------------------------";
    
    // operation
    for(int i=0; i<[[dataDictionary allKeys] count];i++)
    {
        if(![[[dataDictionary allKeys] objectAtIndex:i] containsString:@"uploadItem"])
        {
            [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[[dataDictionary allKeys] objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"%@",[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else {
            
            [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]] objectForKey:@"key"],[[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]] objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
            
            if([[[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]] objectForKey:@"filename"] rangeOfString:@".pdf"].location != NSNotFound)
            {
                [bodyData appendData:[@"Content-Type: application/pdf\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else if([[[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]] objectForKey:@"filename"] rangeOfString:@".png"].location != NSNotFound)
            {
                [bodyData appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else if([[[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]] objectForKey:@"filename"] rangeOfString:@".jpg"].location != NSNotFound)
            {
                [bodyData appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                [bodyData appendData:[@"Content-Type: text/plain\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            [bodyData appendData:[[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]] objectForKey:@"data"]];
        }
    }
    
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return bodyData;
}



- (NSMutableData *) formulatePostingData2:(NSDictionary *) dataDictionary
{
    NSString *resultString = @"";
    
    for(int i=0;i<[[dataDictionary allKeys] count];i++)
    {
        if(i!=0)
        {
            resultString = [resultString stringByAppendingFormat:@"&"];
        }
        
        resultString = [resultString stringByAppendingFormat:@"%@=%@",[[dataDictionary allKeys] objectAtIndex:i],[self encodeURL:[dataDictionary objectForKey:[[dataDictionary allKeys] objectAtIndex:i]]]];
    }
    
    NSMutableData *bodyData = [NSMutableData data];
    
    [bodyData appendData:[[NSString stringWithFormat:@"%@",resultString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return bodyData;
}

- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@":?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"]];
    
	if (newString) {
		return newString;
	}
	return @"";
}


- (void)dealloc
{
	if( connection_ ) { [connection_ cancel]; connection_ = nil;}
}

#pragma mark -
#pragma mark Start & Utility Methods

// This method is just for convenience. It cancels the URL connection if it
// still exists and finishes up the operation.
- (void)done
{
	if( connection_ ) {
		[connection_ cancel];
		connection_ = nil;
	}
	
	// If we have data, try and make a completeData
	if( data_ ) {
		if(completeData)
		{
			completeData = nil;
		}
		completeData = [[NSMutableData alloc] initWithData:data_];
		
		// Set error if no completeData was created
		
		//[data_ autorelease];
		data_ = nil;
	}
    
	// Alert anyone that we are finished
    [self willChangeValueForKey:@"isExecuting"];
	executing_ = NO;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self willChangeValueForKey:@"isFinished"];
	finished_  = YES;
    [self didChangeValueForKey:@"isFinished"];
	
    responseString = [[NSString alloc] initWithData:completeData encoding:NSASCIIStringEncoding];
    
    if(!responseString)
    {
        responseString = [[NSString alloc] initWithData:completeData encoding:NSUTF8StringEncoding];
    }
    
    
    //[delegate onDataDownloadCompleted:completeData identifier:actionType];
    
    if(completeData)
    {
        if(delegate)
        {
            if([(id)delegate respondsToSelector:@selector(requestFinished:)])
            {
                [delegate requestFinished:self];
            }
        }
    }
    else
    {
        if(delegate)
        {
            if([(id)delegate respondsToSelector:@selector(requestFailed:)])
            {
                [delegate requestFailed:self];
            }
        }
    }
}

- (void)start
{
	if(![NSThread isMainThread])
	{
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
		return;
	}
    
    if(post && !multipartForm)
    {
        postingData = [self formulatePostingData2:postingDictionary];
	}
    else if(post)
    {
        postingData = [self formulatePostingData:postingDictionary];
    }
    
	// Ensure this operation is not being restarted and that it has not been cancelled
	if( finished_ || [self isCancelled] ) { [self done]; return; }
    
	// From this point on, the operation is officially executing--remember, isExecuting
	// needs to be KVO compliant!
    
    [self willChangeValueForKey:@"isExecuting"];
	executing_  = YES;
    [self didChangeValueForKey:@"isExecuting"];
	
	// Create the NSURLConnection--this could have been done in init, but we delayed
	// until no in case the operation was never enqueued or was cancelled before starting
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:connectionURL_ cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:timeoutInSeconds ];
	
	if(post && !multipartForm)
	{
		[request setHTTPMethod:@"POST"];
		[request setValue:[NSString stringWithFormat:@"%llu",(long long)[postingData length]] forHTTPHeaderField:@"Content-Length"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		//[request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:postingData];
	}
    
    if(post && multipartForm)
    {
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------Boundary Line---------------------------";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        [request setHTTPBody:postingData];
        [request setValue:[NSString stringWithFormat:@"%llu",(long long)[postingData length]] forHTTPHeaderField:@"Content-Length"];
    }
    
	connection_ = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    [connection_ scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [connection_ start];
    
}


#pragma mark -
#pragma mark Overrides

- (BOOL)isConcurrent
{
	return YES;
}

- (BOOL)isExecuting
{
	return executing_;
}

- (BOOL)isFinished
{
	return finished_;
}

- (void)cancel
{
	[super cancel];
	[self done];
}

#pragma mark -
#pragma mark Delegate Methods for NSURLConnection

// For this example, we only handle the standard delegate call-backs

- (void) connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if(delegate)
    {
        if([(id)delegate respondsToSelector:@selector(onDidSendData:totalData:)])
        {
            [delegate onDidSendData:totalBytesWritten totalData:totalBytesExpectedToWrite];
        }
    }
    
    if(uploadProgressDelegate)
    {
        totalCompleted = (float) ((double) totalBytesWritten / (double) totalBytesExpectedToWrite);
        
        [uploadProgressDelegate setProgress:totalCompleted];
    }
}


// The connection failed
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
	//[data_ autorelease];
	data_ = nil;
	error_ = error;
    
    if(maxNumberOfRetryAttempts !=0)
    {
        if(numberOfRetryAttempts >= maxNumberOfRetryAttempts)
        {
            [self done];
        }
        else
        {
            numberOfRetryAttempts++;
            
            if(completeData)
            {
                completeData = nil;
            }
            
            if( connection_ ) {
                [connection_ cancel];
                connection_ = nil;
            }
            
            [self willChangeValueForKey:@"isExecuting"];
            executing_ = NO;
            [self didChangeValueForKey:@"isExecuting"];
            
            [self start];
        }
    }
    else
    {
        [self done];
    }
}

// The connection received more data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[data_ appendData:data];
	NSInteger receivedLength = [data length];
	bytesReceived = bytesReceived + receivedLength;
	
	totalCompleted = (float)((double)bytesReceived / (double)expectedBytes);
	
    if(delegate)
    {
        if([(id)delegate respondsToSelector:@selector(onDidReceiveData:expectedBytes:totalBytesReceived:userInfo:)])
        {
            [delegate onDidReceiveData:totalCompleted expectedBytes:expectedBytes totalBytesReceived:bytesReceived userInfo:userInfo];
        }
    }
    
    if(downloadProgressDelegate)
    {
        [downloadProgressDelegate setProgress:totalCompleted];
    }
    
}

// Initial response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    expectedBytes = [response expectedContentLength];
    bytesReceived = 0;
	totalCompleted =0;
	data_ = [NSMutableData alloc];
	[data_ setLength:0];
}	



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self done];
}



@end
