//
//  WeatherDataPointObject.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherDataPointObject.h"

@implementation WeatherDataPointObject
@synthesize time, summary, icon, precipIntensity, precipProbability, precipType, temperature, apparentTemperature, dewPoint, humidity, windSpeed, windBearing, visibility, cloudCover, pressure, ozone;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary
{
    if ((self = [super init])) {
        
        // initialization
        
        time = nil;
        
        summary = nil;
        
        icon = nil;
        
        precipIntensity = -1;
        
        precipProbability = -1;
        
        precipType = nil;
        
        temperature = -1;
        
        apparentTemperature = -1;
        
        dewPoint = -1;
        
        humidity = -1;
        
        windSpeed = -1;
        
        windBearing = -1;
        
        visibility = -1;
        
        cloudCover = -1;
        
        pressure = -1;
        
        ozone = -1;
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"time"])
        {
            time = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:@"time"] doubleValue]];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"summary"])
        {
            summary = [dictionary objectForKey:@"summary"];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"icon"])
        {
            icon = [dictionary objectForKey:@"icon"];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"precipIntensity"])
        {
            precipIntensity = [[dictionary objectForKey:@"precipIntensity"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"precipProbability"])
        {
            precipProbability = [[dictionary objectForKey:@"precipProbability"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"precipType"])
        {
            precipType = [dictionary objectForKey:@"precipType"];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"temperature"])
        {
            temperature = [[dictionary objectForKey:@"temperature"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"apparentTemperature"])
        {
            apparentTemperature = [[dictionary objectForKey:@"apparentTemperature"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"dewPoint"])
        {
            dewPoint = [[dictionary objectForKey:@"dewPoint"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"humidity"])
        {
            humidity = [[dictionary objectForKey:@"humidity"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"windSpeed"])
        {
            windSpeed = [[dictionary objectForKey:@"windSpeed"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"windBearing"])
        {
            windBearing = [[dictionary objectForKey:@"windBearing"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"visibility"])
        {
            visibility = [[dictionary objectForKey:@"visibility"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"cloudCover"])
        {
            cloudCover = [[dictionary objectForKey:@"cloudCover"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"pressure"])
        {
            pressure = [[dictionary objectForKey:@"pressure"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"ozone"])
        {
            ozone = [[dictionary objectForKey:@"ozone"] doubleValue];
        }
    }
    
    return self;
}



@end
