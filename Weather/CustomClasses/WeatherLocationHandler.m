//
//  WeatherLocationHandler.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherLocationHandler.h"

@implementation WeatherLocationHandler
@synthesize delegate, lastKnownLocation, locationManager;

- (id) init
{
    if ((self = [super init])) {
        
        [self setupLocationManager];
    }
    
    return self;
}

- (void) setupLocationManager
{
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        [locationManager performSelector:@selector(requestWhenInUseAuthorization)];
    }
}

- (void) startMonitoringLocation
{
    [locationManager startUpdatingLocation];
}

- (void) stopMonitoringLocation
{
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //newer devices
    
    CLLocation *newLocation = [locations objectAtIndex:0];
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    // stale location
    if (locationAge > 300.0) {
        
        return;
    }
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) {
        
        return;
    }
    
    lastKnownLocation = newLocation;
    
    if(delegate)
    {
        if([(id) delegate respondsToSelector:@selector(locationReceived:)])
        {
            [delegate locationReceived:lastKnownLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // older devices
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    // stale location
    if (locationAge > 300.0) {
        
        return;
    }
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) {
        
        return;
    }
    lastKnownLocation = newLocation;
    
    if(delegate)
    {
        if([(id) delegate respondsToSelector:@selector(locationReceived:)])
        {
            [delegate locationReceived:lastKnownLocation];
        }
    }
}



@end
