//
//  WeatherHourlyDataPointObject.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherHourlyDataPointObject.h"

@implementation WeatherHourlyDataPointObject
@synthesize precipAccumulation;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        
        precipAccumulation = -1;
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"precipAccumulation"])
        {
            precipAccumulation = [[dictionary objectForKey:@"precipAccumulation"] doubleValue];
        }
    }
    
    return self;
}


@end
