//
//  WeatherHourlyDataPointObject.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WeatherDataPointObject.h"

@interface WeatherHourlyDataPointObject : WeatherDataPointObject {
    
    double precipAccumulation;
}

@property (nonatomic, assign) double precipAccumulation;
    
@end
