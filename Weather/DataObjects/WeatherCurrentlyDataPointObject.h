//
//  WeatherCurrentlyDataPointObject.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WeatherDataPointObject.h"

@interface WeatherCurrentlyDataPointObject : WeatherDataPointObject {
    
    double nearestStormBearing;
    
    double nearestStormDistance;
}
@property (nonatomic, assign) double nearestStormBearing;

@property (nonatomic, assign) double nearestStormDistance;

@end
