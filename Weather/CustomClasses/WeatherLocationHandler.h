//
//  WeatherLocationHandler.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@protocol WeatherLocationHandlerProtocol

- (void) locationReceived:(CLLocation *) myCurrentLocation;

@end

@interface WeatherLocationHandler : NSObject<CLLocationManagerDelegate> {
    
    __weak id<WeatherLocationHandlerProtocol> delegate;
    
    CLLocation *lastKnownLocation;
    
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *lastKnownLocation;

@property(nonatomic, weak) id<WeatherLocationHandlerProtocol> delegate;

- (void) startMonitoringLocation;

- (void) stopMonitoringLocation;

@end
