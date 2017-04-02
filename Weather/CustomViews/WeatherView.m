//
//  WeatherView.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "WeatherView.h"

@interface WeatherView ()

@end

@implementation WeatherView
@synthesize containerView;
@synthesize titleLabel, precipIntensityLabel, precipProbabilityLabel, precipTypeLabel, temperatureLabel, apparentTemperatureLabel, dewPointLabel, humidityLabel, windBearingLabel, windSpeedLabel, visibilityLabel, cloudCoverLabel, pressureLabel, ozoneLabel;
@synthesize nearestStormBearingLabel, nearestStormDistanceLabel, precipAccumulationLabel;

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        NSString * nibName = NSStringFromClass([self class]);
        
        [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
        
        [self addSubview:self.containerView];
        
        [self initialization];
    }
    
    // template init code
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        
        if(![[self restorationIdentifier] isEqualToString:@"WeatherRestorationID"])
        {
            NSString * nibName = NSStringFromClass([self class]);
            
            [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
            
            [self addSubview:self.containerView];
            
            [self initialization];
        }
    }
    
    // template init code
    
    return self;
}

- (void) initialization
{
    [titleLabel setAlpha:0];
    
    [titleLabel.layer setBorderWidth:2];
    
    [titleLabel.layer setCornerRadius:[titleLabel frame].size.height / 2];

    for(UIView *subview in [containerView subviews])
    {
        if(subview != titleLabel)
        {
            [subview setAlpha:0];
            
            [subview.layer setBorderWidth:1];
            
            [subview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        }
    }
}

- (void) refreshViewsWithData:(WeatherDataPointObject *) data mode:(NSString *)modeString
{
    NSString *titleString = @"";
    
    UIColor *titleBorderColor = [UIColor clearColor];
    
    NSString *precipIntensityString = @"";
    
    NSString *precipProbabilityString = @"";
    
    NSString *precipTypeString = @"";
    
    NSString *temperatureString = @"";
    
    NSString *apparentTemperatureString = @"";
    
    NSString *dewPointString = @"";
    
    NSString *humidityString = @"";
    
    NSString *windBearingString = @"";
    
    NSString *windSpeedString = @"";
    
    NSString *visibilityString = @"";
    
    NSString *cloudCoverString = @"";
    
    NSString *pressureString = @"";
    
    NSString *ozoneString = @"";
    
    // currently
    
    NSString *nearestStormBearingString = @"";
    
    NSString *nearestStormDistanceString = @"";
    
    // hourly
    
    NSString *precipAccumulationString = @"";
    
    if(data)
    {
        if([data time])
        {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"dd LLL, h:mm a"];
            
            titleString = [NSString stringWithFormat:@"%@", [df stringFromDate:[data time]]];
            
            if([data summary])
            {
                titleString = [titleString stringByAppendingFormat:@" - %@", [data summary]];
            }
            
            if(modeString)
            {
                titleString = [titleString stringByAppendingFormat:@" (%@)",modeString];
            }
            
            if([data icon])
            {
                if([[[data icon] lowercaseString] isEqualToString:@"clear-day"])
                {
                    titleBorderColor = [UIColor yellowColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"clear-night"])
                {
                    titleBorderColor = [UIColor blackColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"rain"])
                {
                    titleBorderColor = [UIColor blueColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"snow"])
                {
                    titleBorderColor = [UIColor cyanColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"sleet"])
                {
                    titleBorderColor = [UIColor magentaColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"wind"])
                {
                    titleBorderColor = [UIColor greenColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"fog"])
                {
                    titleBorderColor = [UIColor lightGrayColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"cloudy"])
                {
                    titleBorderColor = [UIColor orangeColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"partly-cloudy-day"])
                {
                    titleBorderColor = [UIColor purpleColor];
                }
                else if([[[data icon] lowercaseString] isEqualToString:@"partly-cloudy-night"])
                {
                    titleBorderColor = [UIColor darkGrayColor];
                }
            }
            
            if([data precipIntensity] != -1)
            {
                precipIntensityString = [NSString stringWithFormat:@"%.2lf inch/hr", [data precipIntensity]];
            }
            
            if([data precipProbability] != -1)
            {
                precipProbabilityString = [NSString stringWithFormat:@"%.2lf", [data precipProbability]];
            }
            
            if([data precipType])
            {
                precipTypeString = [NSString stringWithFormat:@"%@", [data precipType]];
            }
            
            if([data temperature] != -1)
            {
                temperatureString = [NSString stringWithFormat:@"%.2lf °F", [data temperature]];
            }
            
            if([data apparentTemperature] != -1)
            {
                apparentTemperatureString = [NSString stringWithFormat:@"%.2lf °F", [data apparentTemperature]];
            }
            
            if([data dewPoint] != -1)
            {
                dewPointString = [NSString stringWithFormat:@"%.2lf °F", [data dewPoint]];
            }
            
            if([data humidity] != -1)
            {
                humidityString = [NSString stringWithFormat:@"%.2lf%%", [data humidity] * 100];
            }
            
            if([data windBearing] != -1)
            {
                windBearingString = [NSString stringWithFormat:@"%.2lf °", [data windBearing]];
            }
            
            if([data windSpeed] != -1)
            {
                windSpeedString = [NSString stringWithFormat:@"%.2lf miles/hr", [data windSpeed]];
            }
            
            if([data visibility] != -1)
            {
                visibilityString = [NSString stringWithFormat:@"%.2lf miles", [data visibility]];
            }
            
            if([data cloudCover] != -1)
            {
                cloudCoverString = [NSString stringWithFormat:@"%.2lf%%", [data cloudCover] * 100];
            }
            
            if([data pressure] != -1)
            {
                pressureString = [NSString stringWithFormat:@"%.2lf mbars", [data pressure]];
            }
            
            if([data ozone] != -1)
            {
                ozoneString = [NSString stringWithFormat:@"%.2lf DU", [data ozone]];
            }
            
            if([data isKindOfClass:[WeatherHourlyDataPointObject class]])
            {
                // hourly
                
                if([(WeatherHourlyDataPointObject *)data precipAccumulation] != -1)
                {
                    precipAccumulationString = [NSString stringWithFormat:@"%.2lf inch", [(WeatherHourlyDataPointObject *)data precipAccumulation]];
                }
            }
            else if([data isKindOfClass:[WeatherCurrentlyDataPointObject class]])
            {
                // currently
                
                if([(WeatherCurrentlyDataPointObject *)data nearestStormBearing] != -1)
                {
                    nearestStormBearingString = [NSString stringWithFormat:@"%.2lf °", [(WeatherCurrentlyDataPointObject *)data nearestStormBearing]];
                }
                
                if([(WeatherCurrentlyDataPointObject *)data nearestStormDistance] != -1)
                {
                    nearestStormDistanceString = [NSString stringWithFormat:@"%.2lf miles", [(WeatherCurrentlyDataPointObject *)data nearestStormDistance]];
                }
            }
        }
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    
    [titleLabel setAlpha:1];
    
    [titleLabel setText:titleString];
    
    [titleLabel.layer setBorderColor:titleBorderColor.CGColor];
    
    [UIView commitAnimations];
    
    float contentOffsetX = 10;
    
    float contentOffsetY = 30;
    
    if([self refreshLabel:precipIntensityLabel stringValue:precipIntensityString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    
    if([self refreshLabel:precipProbabilityLabel stringValue:precipProbabilityString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    

    
    if([self refreshLabel:precipTypeLabel stringValue:precipTypeString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    
    if([self refreshLabel:precipAccumulationLabel stringValue:precipAccumulationString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:temperatureLabel stringValue:temperatureString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:apparentTemperatureLabel stringValue:apparentTemperatureString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:dewPointLabel stringValue:dewPointString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:humidityLabel stringValue:humidityString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:windBearingLabel stringValue:windBearingString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:windSpeedLabel stringValue:windSpeedString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:visibilityLabel stringValue:visibilityString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:cloudCoverLabel stringValue:cloudCoverString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:pressureLabel stringValue:pressureString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:ozoneLabel stringValue:ozoneString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:nearestStormBearingLabel stringValue:nearestStormBearingString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    if([self refreshLabel:nearestStormDistanceLabel stringValue:nearestStormDistanceString contentOffsetX:contentOffsetX contentOffsetY:contentOffsetY])
    {
        if(contentOffsetX == 10)
        {
            contentOffsetX = 160;
        }
        else
        {
            contentOffsetY = contentOffsetY + 30;
            
            contentOffsetX = 10;
        }
    }
    
    contentOffsetY = contentOffsetY + 50;
    
    [self setContentSize:CGSizeMake([self frame].size.width, contentOffsetY)];
}

- (BOOL) refreshLabel:(UILabel *) valueLabel stringValue:(NSString *) stringValue contentOffsetX:(float) contentOffsetX contentOffsetY:(float) contentOffsetY
{
    if(!valueLabel)
    {
        return NO;
    }
    
    if(![stringValue isEqualToString:@""])
    {
        [[valueLabel superview] setFrame:CGRectMake(contentOffsetX, contentOffsetY, [[valueLabel superview] frame].size.width, [[valueLabel superview] frame].size.height)];
        
        [valueLabel setText:stringValue];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        [[valueLabel superview] setAlpha:1];
        
        [UIView commitAnimations];
        
        return YES;
    }
    else
    {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        [[valueLabel superview] setAlpha:0];
        
        [UIView commitAnimations];
        
        return NO;
    }
}

@end
