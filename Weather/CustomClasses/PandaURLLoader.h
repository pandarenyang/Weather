//
//  PandaURLLoader.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PandaURLLoaderDelegate

// response

@optional
- (void)onDidReceiveData:(float)totalCompleted_ expectedBytes:(long long)expectedBytes_ totalBytesReceived:(long long)totalBytesReceived_ userInfo:(NSMutableDictionary *)userInfo_;

- (void) requestFinished:(id)request;

- (void)requestFailed:(id)request;

// request

- (void) onDidSendData:(NSInteger) totalBytesWritten totalData:(NSInteger) totalBytesExpectedToWrite;

@end

@interface PandaURLLoader : NSOperation <NSURLConnectionDataDelegate>{
    // New Properties
	NSError*  error_;
    
    NSURL*    connectionURL_;
	NSURLConnection*  connection_;
	NSMutableData*    data_;
	NSMutableData*		completeData;
	//int			actionType;
	
    NSMutableDictionary *userInfo;
    
    NSMutableDictionary *postingDictionary;
    
    NSString *responseString;
    
	long long bytesReceived;
	long long expectedBytes;
	
	float totalCompleted;
    
    float timeoutInSeconds;
	
    BOOL multipartForm;
	BOOL post;
	NSMutableData *postingData;
    __weak id<PandaURLLoaderDelegate> delegate;
    
    BOOL      executing_;
	BOOL      finished_;
	BOOL	  progressUpdated;
    
    UIProgressView *downloadProgressDelegate;
    
    UIProgressView *uploadProgressDelegate;
    
    int numberOfRetryAttempts;
    
    int maxNumberOfRetryAttempts;
}

@property (nonatomic, strong) UIProgressView *uploadProgressDelegate;

@property (nonatomic, assign) int maxNumberOfRetryAttempts;

@property (nonatomic, assign) int numberOfRetryAttempts;

@property (nonatomic, strong) UIProgressView *downloadProgressDelegate;

@property (nonatomic, strong) NSString *responseString;

@property(nonatomic,assign) float timeoutInSeconds;

@property(nonatomic,strong) NSError* error;
@property (nonatomic,strong) NSMutableData* completeData;
//@property (nonatomic, assign) int actionType;
@property (nonatomic,strong) NSMutableDictionary *userInfo;
@property (nonatomic,strong) NSMutableDictionary *postingDictionary;
@property (nonatomic,strong) NSMutableData *postingData;
@property (nonatomic, assign) BOOL multipartForm;
@property (nonatomic, assign) BOOL post;
@property (nonatomic, strong) NSURLConnection*  connection_;
@property (nonatomic, weak) id<PandaURLLoaderDelegate> delegate;
@property (nonatomic,assign) float totalCompleted;
@property (nonatomic,assign) long long bytesReceived;
@property (nonatomic,assign) long long expectedBytes;


+ (id) requestWithURL:(NSURL *)url;

- (void) setPostValue:(id <NSObject>)value forKey:(NSString *) key;

- (id)initWithURL:(NSURL *)url userInfo:(NSMutableDictionary *) userInfo_ delegate:(id) delegate_;

@end
