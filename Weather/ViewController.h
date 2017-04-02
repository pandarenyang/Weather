//
//  ViewController.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedServiceFacade.h"
#import "WeatherDataHandler.h"
#import "WeatherView.h"
#import "WeatherLocationHandler.h"

@interface ViewController : UIViewController<WeatherDataHandlerProtocol, WeatherLocationHandlerProtocol, UIScrollViewDelegate>
{
    WeatherDataHandler *dataHandler;
    
    WeatherLocationHandler *locationHandler;
    
    UIScrollView *hourlyScrollView;
    
    WeatherView *currentWeatherView;
    
    UILabel *hourlyInfoLabel;
    
    UIButton *leftButton;
    
    UIButton *rightButton;
}

@property (nonatomic, strong) WeatherLocationHandler *locationHandler;

@property (nonatomic, strong) WeatherDataHandler *dataHandler;

@property (nonatomic, strong) IBOutlet UIScrollView *hourlyScrollView;

@property (nonatomic, strong) IBOutlet WeatherView *currentWeatherView;

@property (nonatomic, strong) IBOutlet UILabel *hourlyInfoLabel;

@property (nonatomic, strong) IBOutlet UIButton *rightButton;

@property (nonatomic, strong) IBOutlet UIButton *leftButton;


@end
