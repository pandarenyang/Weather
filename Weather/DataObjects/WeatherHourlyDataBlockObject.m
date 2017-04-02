//
//  WeatherHourlyDataBlockObject.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherHourlyDataBlockObject.h"

@implementation WeatherHourlyDataBlockObject
@synthesize summary, icon, data;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary
{
    if ((self = [super init])) {
        
        summary = nil;
        
        icon = nil;
        
        data = nil;
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"summary"])
        {
            summary = [dictionary objectForKey:@"summary"];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"icon"])
        {
            icon = [dictionary objectForKey:@"icon"];
        }
        
        if([CommonUtil emptinessCheck:dictionary checkingKey:@"data"])
        {
            NSMutableArray *array = [NSMutableArray array];
            
            for(int i=0;i<[[dictionary objectForKey:@"data"] count];i++)
            {
                NSMutableDictionary *initDictionary = [[dictionary objectForKey:@"data"] objectAtIndex:i];
                
                WeatherHourlyDataPointObject *weatherPoint = [[WeatherHourlyDataPointObject alloc] initWithDictionary:initDictionary];
                
                [array addObject:weatherPoint];
            }
            
            data = array;
        }
    }
    
    return self;
}



@end
