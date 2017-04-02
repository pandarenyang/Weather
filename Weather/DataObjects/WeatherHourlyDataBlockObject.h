//
//  WeatherHourlyDataBlockObject.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "WeatherHourlyDataPointObject.h"

@interface WeatherHourlyDataBlockObject : NSObject {

    NSString *summary;
    
    NSString *icon;
    
    NSMutableArray<WeatherDataPointObject *> *data;
}

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSMutableArray<WeatherDataPointObject *> *data;

- (id) initWithDictionary:(NSMutableDictionary *) dictionary;

@end
