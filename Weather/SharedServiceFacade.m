//
//  SharedServiceFacade.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "SharedServiceFacade.h"

#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]

@implementation SharedServiceFacade

+ (void) getForecast:(id)delegate latitude:(double) latitude longitude:(double) longitude
{
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@/%@/%@",SERVER_URL, @"forecast", API_KEY, [NSString stringWithFormat:@"%lf,%lf",latitude, longitude]]];
    
    PandaURLLoader *request = [PandaURLLoader requestWithURL:url];
    
    [request setMaxNumberOfRetryAttempts:3];
    
    [request setTimeoutInSeconds:30];
    
    [request setDelegate:delegate];
    
    [request setUserInfo: [NSMutableDictionary dictionaryWithObjectsAndKeys:@"getForecast",@"requestId",nil]];
    
    [[NSOperationQueue mainQueue] addOperation:request];
}


@end
