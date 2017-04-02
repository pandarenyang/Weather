//
//  WeatherDataHandler.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherDataHandler.h"

@implementation WeatherDataHandler
@synthesize delegate, lastKnownDataObject;

- (void)requestFinished:(PandaURLLoader *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *userInfo = [request userInfo];
    NSString* requestId = [userInfo objectForKey: @"requestId"];
    
    if(responseString)
    {
        NSMutableDictionary *response = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        if([CommonUtil emptinessCheck:response checkingKey:nil])
        {
            if([requestId isEqualToString:@"getForecast"])
            {
                lastKnownDataObject = [[WeatherDataObject alloc] initWithDictionary:response];
                
                if(delegate)
                {
                    if([(id)delegate respondsToSelector:@selector(datasetChanged:)])
                    {
                        [delegate datasetChanged:lastKnownDataObject];
                    }
                }
            }
        }
        else
        {
            [CommonUtil displayAlert: @"Error" :@"General Problem encountered." :nil];
        }
    }
    else
    {
        [CommonUtil displayAlert: @"Error" :@"General Problem encountered." :nil];
    }
}

- (void)requestFailed:(PandaURLLoader *)request
{
    NSError *error = [request error];
    
    if ([[error localizedDescription] isEqual: @"The request timed out"])  {
        [CommonUtil displayAlert: @"Error" :@"Request time out. Please try again shortly." :nil];
    }
    else if([[error localizedDescription] isEqual: @"A connection failure occurred"])
    {
        [CommonUtil displayAlert: @"Error" :@"A connection problem occured. Please check your network." :nil];
    }
    else {
        
        [CommonUtil displayAlert: @"Error" :@"General Problem encountered." :nil];
    }
    
    return;
    
}

@end
