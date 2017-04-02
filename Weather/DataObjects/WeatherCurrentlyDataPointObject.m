//
//  WeatherCurrentlyDataPointObject.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherCurrentlyDataPointObject.h"

@implementation WeatherCurrentlyDataPointObject
@synthesize nearestStormBearing, nearestStormDistance;


- (id) initWithDictionary:(NSMutableDictionary *) dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        
        nearestStormBearing = -1;
        
        nearestStormDistance = -1;
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"nearestStormBearing"])
        {
            nearestStormBearing = [[dictionary objectForKey:@"nearestStormBearing"] doubleValue];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"nearestStormDistance"])
        {
            nearestStormDistance = [[dictionary objectForKey:@"nearestStormDistance"] doubleValue];
        }
    }
    
    return self;
}

@end
