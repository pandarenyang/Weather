//
//  WeatherDataPointObject.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CommonUtil.h"

@interface WeatherDataPointObject : NSObject {

    // mandatory
    
    NSDate *time;
    
    // non-mandatory but similar
    
    NSString *summary;
    
    NSString *icon;
    
    double precipIntensity;
    
    double precipProbability;
    
    NSString *precipType;
    
    double temperature;
    
    double apparentTemperature;
    
    double dewPoint;
    
    double humidity;
    
    double windSpeed;
    
    double windBearing;
    
    double visibility;
    
    double cloudCover;
    
    double pressure;
    
    double ozone;
}

@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, assign) double precipIntensity;

@property (nonatomic, assign) double precipProbability;

@property (nonatomic, strong) NSString *precipType;

@property (nonatomic, assign) double temperature;

@property (nonatomic, assign) double apparentTemperature;

@property (nonatomic, assign) double dewPoint;

@property (nonatomic, assign) double humidity;

@property (nonatomic, assign) double windSpeed;

@property (nonatomic, assign) double windBearing;

@property (nonatomic, assign) double visibility;

@property (nonatomic, assign) double cloudCover;

@property (nonatomic, assign) double pressure;

@property (nonatomic, assign) double ozone;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary;

@end
