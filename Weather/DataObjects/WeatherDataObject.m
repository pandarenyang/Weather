//
//  WeatherDataObject.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherDataObject.h"

@implementation WeatherDataObject
@synthesize latitude, longitude, timezone, timezoneOffset, currentWeather, hourlyWeather;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary
{
    if ((self = [super init])) {
    
        latitude = -1;
        
        longitude = -1;
        
        timezone = nil;
        
        timezoneOffset = -1;
        
        currentWeather = nil;
        
        hourlyWeather = nil;
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"latitude"])
        {
            latitude = [[dictionary objectForKey:@"latitude"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"longitude"])
        {
            longitude = [[dictionary objectForKey:@"longitude"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"timezone"])
        {
            timezone = [dictionary objectForKey:@"timezone"];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"offset"])
        {
            timezoneOffset = [[dictionary objectForKey:@"offset"] floatValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"currently"])
        {
            currentWeather = [[WeatherCurrentlyDataPointObject alloc] initWithDictionary:[dictionary objectForKey:@"currently"]];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"hourly"])
        {
            hourlyWeather = [[WeatherHourlyDataBlockObject alloc] initWithDictionary:[dictionary objectForKey:@"hourly"]];
        }
    }
    
    return self;
}

@end
