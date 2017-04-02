//
//  WeatherDataObject.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "WeatherHourlyDataBlockObject.h"

#import "WeatherCurrentlyDataPointObject.h"

#import "CommonUtil.h"

@interface WeatherDataObject : NSObject {

    double latitude;
    
    double longitude;
    
    NSString *timezone;
    
    float timezoneOffset;
    
    WeatherCurrentlyDataPointObject *currentWeather;
    
    WeatherHourlyDataBlockObject *hourlyWeather;
}

@property (nonatomic, assign) double latitude;

@property (nonatomic, assign) double longitude;

@property (nonatomic, strong) NSString *timezone;

@property (nonatomic, assign) float timezoneOffset;

@property (nonatomic, strong) WeatherCurrentlyDataPointObject *currentWeather;

@property (nonatomic, strong) WeatherHourlyDataBlockObject *hourlyWeather;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary;

@end
