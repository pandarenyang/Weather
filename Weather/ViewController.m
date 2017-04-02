//
//  ViewController.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dataHandler, hourlyScrollView, currentWeatherView, hourlyInfoLabel;
@synthesize leftButton, rightButton;
@synthesize locationHandler;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dataHandler = [[WeatherDataHandler alloc] init];
    
    [dataHandler setDelegate:self];
    
    locationHandler = [[WeatherLocationHandler alloc] init];
    
    [locationHandler setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startProcess) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self startProcess];
}

- (void) startProcess
{
    [CommonUtil showActivityIndicator:self.view];
    
    [locationHandler startMonitoringLocation];
}

- (void) locationReceived:(CLLocation *) myCurrentLocation
{
    [locationHandler stopMonitoringLocation];
    
    [SharedServiceFacade getForecast:dataHandler latitude:myCurrentLocation.coordinate.latitude longitude:myCurrentLocation.coordinate.longitude];
}

- (void) datasetChanged:(WeatherDataObject *) weatherDataObject
{
    [CommonUtil hideActivityIndicator:self.view];
    
    [currentWeatherView refreshViewsWithData:[weatherDataObject currentWeather] mode:@"Current"];
    
    if([weatherDataObject hourlyWeather])
    {
        [self repopulateHourlyContainer:[[weatherDataObject hourlyWeather] data]];
    
        UIColor *titleBorderColor = [UIColor clearColor];
        
        NSString *hourlyInfoTitleString = [[weatherDataObject hourlyWeather] summary];
        
        if([[weatherDataObject hourlyWeather] icon])
        {
            if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"clear-day"])
            {
                titleBorderColor = [UIColor yellowColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"clear-night"])
            {
                titleBorderColor = [UIColor blackColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"rain"])
            {
                titleBorderColor = [UIColor blueColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"snow"])
            {
                titleBorderColor = [UIColor cyanColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"sleet"])
            {
                titleBorderColor = [UIColor magentaColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"wind"])
            {
                titleBorderColor = [UIColor greenColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"fog"])
            {
                titleBorderColor = [UIColor lightGrayColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"cloudy"])
            {
                titleBorderColor = [UIColor orangeColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"partly-cloudy-day"])
            {
                titleBorderColor = [UIColor purpleColor];
            }
            else if([[[[weatherDataObject hourlyWeather] icon] lowercaseString] isEqualToString:@"partly-cloudy-night"])
            {
                titleBorderColor = [UIColor darkGrayColor];
            }
        }

        [hourlyInfoLabel.layer setBorderColor:titleBorderColor.CGColor];
        
        [hourlyInfoLabel.layer setBorderWidth:2];
        
        [hourlyInfoLabel setText:[NSString stringWithFormat:@"Forecast - %@",hourlyInfoTitleString]];
        
        [hourlyInfoLabel setHidden:NO];
    }
    else
    {
        [self repopulateHourlyContainer:nil];
        
        [hourlyInfoLabel setText:@""];
        
        [hourlyInfoLabel setHidden:YES];
    }
    
    [self refreshScrollButtons];
}

- (void) repopulateHourlyContainer:(NSMutableArray<WeatherDataPointObject *> *) hourlyData
{
    for(id subview in [hourlyScrollView subviews])
    {
        [subview removeFromSuperview];
    }
    
    if(hourlyData)
    {
        for(int i=0;i<[hourlyData count];i++)
        {
            WeatherView *hourlyWeatherView = [[WeatherView alloc] initWithFrame:CGRectMake(i * [hourlyScrollView frame].size.width, 0, [hourlyScrollView frame].size.width, [hourlyScrollView frame].size.height)];
            
            [hourlyWeatherView refreshViewsWithData:[hourlyData objectAtIndex:i] mode:@"Hourly"];
            
            [hourlyScrollView addSubview:hourlyWeatherView];
        }
        
        [hourlyScrollView setContentSize:CGSizeMake([hourlyData count] * [hourlyScrollView frame].size.width, [hourlyScrollView frame].size.height)];
    }
}

- (void) refreshScrollButtons
{
    if(dataHandler)
    {
        if([dataHandler lastKnownDataObject])
        {
            CGFloat pageWidth = [hourlyScrollView frame].size.width;
            
            int page = floor((hourlyScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            
            if(page <= 0)
            {
                [leftButton setHidden:YES];
                
                [rightButton setHidden:NO];
            }
            else if(page >= [[[[dataHandler lastKnownDataObject] hourlyWeather] data] count] - 1)
            {
                [leftButton setHidden:NO];
                
                [rightButton setHidden:YES];
            }
            else if([[[[dataHandler lastKnownDataObject] hourlyWeather] data] count] <= 1)
            {
                [leftButton setHidden:YES];
                
                [rightButton setHidden:YES];
            }
            else
            {
                [leftButton setHidden:NO];
                
                [rightButton setHidden:NO];
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [self refreshScrollButtons];
}

- (IBAction) onLeftButtonPressed:(id)sender
{
    if(dataHandler)
    {
        if([dataHandler lastKnownDataObject])
        {
            CGFloat pageWidth = [hourlyScrollView frame].size.width;
            
            int page = floor((hourlyScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
            CGRect frame = hourlyScrollView.frame;
            frame.origin.x = pageWidth * (page - 1);
            frame.origin.y = 0;
            
            [UIView beginAnimations: @"Scroll" context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [hourlyScrollView setContentOffset:CGPointMake(frame.origin.x, 0)];
            
            [UIView commitAnimations];
        }
    }
}

- (IBAction) onRightButtonPressed:(id)sender
{
    if(dataHandler)
    {
        if([dataHandler lastKnownDataObject])
        {
            CGFloat pageWidth = [hourlyScrollView frame].size.width;
            
            int page = floor((hourlyScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            
            CGRect frame = hourlyScrollView.frame;
            frame.origin.x = pageWidth * (page + 1);
            frame.origin.y = 0;
            
            [UIView beginAnimations: @"Scroll" context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [hourlyScrollView setContentOffset:CGPointMake(frame.origin.x, 0)];
            
            [UIView commitAnimations];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
