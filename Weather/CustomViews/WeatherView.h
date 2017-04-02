//
//  WeatherView.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeatherCurrentlyDataPointObject.h"

#import "WeatherHourlyDataPointObject.h"

@interface WeatherView : UIScrollView
{
    UIScrollView *containerView;
    
    UILabel *titleLabel;
    
    UILabel *precipIntensityLabel;
    
    UILabel *precipProbabilityLabel;
    
    UILabel *precipTypeLabel;
    
    UILabel *temperatureLabel;
    
    UILabel *apparentTemperatureLabel;
    
    UILabel *dewPointLabel;
    
    UILabel *humidityLabel;
    
    UILabel *windBearingLabel;
    
    UILabel *windSpeedLabel;
    
    UILabel *visibilityLabel;
    
    UILabel *cloudCoverLabel;
    
    UILabel *pressureLabel;
    
    UILabel *ozoneLabel;
    
    // currently
    
    UILabel *nearestStormBearingLabel;
    
    UILabel *nearestStormDistanceLabel;
    
    // hourly
    
    UILabel *precipAccumulationLabel;
}

@property (nonatomic, strong) IBOutlet UIScrollView *containerView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) IBOutlet UILabel *precipIntensityLabel;

@property (nonatomic, strong) IBOutlet UILabel *precipProbabilityLabel;

@property (nonatomic, strong) IBOutlet UILabel *precipTypeLabel;

@property (nonatomic, strong) IBOutlet UILabel *temperatureLabel;

@property (nonatomic, strong) IBOutlet UILabel *apparentTemperatureLabel;

@property (nonatomic, strong) IBOutlet UILabel *dewPointLabel;

@property (nonatomic, strong) IBOutlet UILabel *humidityLabel;

@property (nonatomic, strong) IBOutlet UILabel *windBearingLabel;

@property (nonatomic, strong) IBOutlet UILabel *windSpeedLabel;

@property (nonatomic, strong) IBOutlet UILabel *visibilityLabel;

@property (nonatomic, strong) IBOutlet UILabel *cloudCoverLabel;

@property (nonatomic, strong) IBOutlet UILabel *pressureLabel;

@property (nonatomic, strong) IBOutlet UILabel *ozoneLabel;

// currently

@property (nonatomic, strong) IBOutlet UILabel *nearestStormBearingLabel;

@property (nonatomic, strong) IBOutlet UILabel *nearestStormDistanceLabel;

// hourly

@property (nonatomic, strong) IBOutlet UILabel *precipAccumulationLabel;

- (void) refreshViewsWithData:(WeatherDataPointObject *) data mode:(NSString *)modeString;

@end
