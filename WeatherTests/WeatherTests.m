//
//  WeatherTests.m
//  WeatherTests
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WeatherCurrentlyDataPointObject.h"

#import "WeatherHourlyDataPointObject.h"

#import "CommonUtil.h"

@interface WeatherTests : XCTestCase

@property (nonatomic, strong) NSMutableDictionary *currentlyDataPointObjectTest;

@property (nonatomic, strong) NSMutableDictionary *hourlyDataPointObjectTest;

@end

@implementation WeatherTests
@synthesize currentlyDataPointObjectTest, hourlyDataPointObjectTest;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    currentlyDataPointObjectTest = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                   @"time": @"1491074724",
                                                                                   @"summary": @"Light Rain",
                                                                                   @"icon": @"rain",
                                                                                   @"precipIntensity": @"0.0196",
                                                                                   @"precipProbability": @"0.6",
                                                                                   @"precipType": @"rain",
                                                                                   @"temperature": @"78.58",
                                                                                   @"apparentTemperature": @"78.58",
                                                                                   @"dewPoint": @"75.13",
                                                                                   @"humidity": @"0.89",
                                                                                   @"windSpeed": @"3.01",
                                                                                   @"windBearing": @"308",
                                                                                   @"visibility": @"6.21",
                                                                                   @"cloudCover": @"0.55",
                                                                                   @"pressure": @"1011.09",
                                                                                   @"ozone": @"261.25"
                                                                                   }];
  
    hourlyDataPointObjectTest = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"time": @"1491073200",
                                                                                @"summary": @"Light Rain",
                                                                                @"icon": @"rain",
                                                                                @"precipIntensity": @"0.0192",
                                                                                @"precipProbability": @"0.6",
                                                                                @"precipType": @"rain",
                                                                                @"temperature": @"78.68",
                                                                                @"apparentTemperature": @"78.68",
                                                                                @"dewPoint": @"75.41",
                                                                                @"humidity": @"0.9",
                                                                                @"windSpeed": @"1.74",
                                                                                @"windBearing": @"331",
                                                                                @"cloudCover": @"0.4",
                                                                                @"pressure": @"1011.58",
                                                                                @"ozone": @"261.36",
                                                                                @"precipAccumulation" : @"10",
                                                                                }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    currentlyDataPointObjectTest = nil;
    
    hourlyDataPointObjectTest = nil;
}

- (void) testCurrentlyDataPoint
{
    WeatherCurrentlyDataPointObject *currentlyDataPointObject = [[WeatherCurrentlyDataPointObject alloc] initWithDictionary:currentlyDataPointObjectTest];
    
    NSDate *expectedTime = [NSDate dateWithTimeIntervalSince1970:[[currentlyDataPointObjectTest objectForKey:@"time"] doubleValue]];
    
    XCTAssertEqual([expectedTime timeIntervalSince1970], [[currentlyDataPointObject time] timeIntervalSince1970], @"Time Failed");
    
    NSString *expectedSummary = [currentlyDataPointObjectTest objectForKey:@"summary"];
    
    XCTAssertEqual(expectedSummary, [currentlyDataPointObject summary], @"Summary Failed");
    
    NSString *expectedIcon = [currentlyDataPointObjectTest objectForKey:@"icon"];
    
    XCTAssertEqual(expectedIcon, [currentlyDataPointObject icon], @"Icon Failed");
    
    
    double expectedPrecipIntensity = [[currentlyDataPointObjectTest objectForKey:@"precipIntensity"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPrecipIntensity, [currentlyDataPointObject precipIntensity], 2, @"PrecipIntensity Failed");
    
    double expectedPrecipProbability = [[currentlyDataPointObjectTest objectForKey:@"precipProbability"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPrecipProbability, [currentlyDataPointObject precipProbability], 2, @"PrecipProbability Failed");
    
    NSString *expectedPrecipType = [currentlyDataPointObjectTest objectForKey:@"precipType"];
    
    XCTAssertEqual(expectedPrecipType, [currentlyDataPointObject precipType], @"PrecipType Failed");
    
    
    double expectedTemperature = [[currentlyDataPointObjectTest objectForKey:@"temperature"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedTemperature, [currentlyDataPointObject temperature], 2, @"Temperature Failed");
    
    double expectedApparentTemperature = [[currentlyDataPointObjectTest objectForKey:@"apparentTemperature"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedApparentTemperature, [currentlyDataPointObject apparentTemperature], 2, @"ApparentTemperature Failed");
    
    
    double expectedDewPoint = [[currentlyDataPointObjectTest objectForKey:@"dewPoint"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedDewPoint, [currentlyDataPointObject dewPoint], 2, @"DewPoint Failed");
    
    
    double expectedHumidity = [[currentlyDataPointObjectTest objectForKey:@"humidity"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedHumidity, [currentlyDataPointObject humidity], 2, @"Humidity Failed");
    
    
    double expectedWindSpeed = [[currentlyDataPointObjectTest objectForKey:@"windSpeed"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedWindSpeed, [currentlyDataPointObject windSpeed], 2, @"WindSpeed Failed");
    
    
    double expectedWindBearing = [[currentlyDataPointObjectTest objectForKey:@"windBearing"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedWindBearing, [currentlyDataPointObject windBearing], 2, @"WindBearing Failed");
    
    double expectedVisibility = [[currentlyDataPointObjectTest objectForKey:@"visibility"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedVisibility, [currentlyDataPointObject visibility], 2, @"Visibility Failed");
    
    double expectedCloudCover = [[currentlyDataPointObjectTest objectForKey:@"cloudCover"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedCloudCover, [currentlyDataPointObject cloudCover], 2, @"CloudCover Failed");
    
    
    double expectedPressure = [[currentlyDataPointObjectTest objectForKey:@"pressure"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPressure, [currentlyDataPointObject pressure], 2, @"Pressure Failed");
    
    
    double expectedOzone = [[currentlyDataPointObjectTest objectForKey:@"ozone"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedOzone, [currentlyDataPointObject ozone], 2, @"Ozone Failed");
    
    
    XCTAssertEqualWithAccuracy(-1, [currentlyDataPointObject nearestStormBearing], 2, @"NearestStormBearing Failed");
    
    
    XCTAssertEqualWithAccuracy(-1, [currentlyDataPointObject nearestStormDistance], 2, @"NearestStormDistance Failed");
    
    
}

- (void) testHourlyDataPoint
{
    WeatherHourlyDataPointObject *hourlyDataPointObject = [[WeatherHourlyDataPointObject alloc] initWithDictionary:hourlyDataPointObjectTest];
    
    NSDate *expectedTime = [NSDate dateWithTimeIntervalSince1970:[[hourlyDataPointObjectTest objectForKey:@"time"] doubleValue]];
    
    XCTAssertEqual([expectedTime timeIntervalSince1970], [[hourlyDataPointObject time] timeIntervalSince1970], @"Time Failed");
    
    NSString *expectedSummary = [currentlyDataPointObjectTest objectForKey:@"summary"];
    
    XCTAssertEqual(expectedSummary, [hourlyDataPointObject summary], @"Summary Failed");
    
    NSString *expectedIcon = [currentlyDataPointObjectTest objectForKey:@"icon"];
    
    XCTAssertEqual(expectedIcon, [hourlyDataPointObject icon], @"Icon Failed");
    
    
    double expectedPrecipIntensity = [[hourlyDataPointObjectTest objectForKey:@"precipIntensity"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPrecipIntensity, [hourlyDataPointObject precipIntensity], 2, @"PrecipIntensity Failed");
    
    double expectedPrecipProbability = [[hourlyDataPointObjectTest objectForKey:@"precipProbability"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPrecipProbability, [hourlyDataPointObject precipProbability], 2, @"PrecipProbability Failed");
    
    NSString *expectedPrecipType = [hourlyDataPointObjectTest objectForKey:@"precipType"];
    
    XCTAssertEqual(expectedPrecipType, [hourlyDataPointObject precipType], @"PrecipType Failed");
    
    
    double expectedTemperature = [[hourlyDataPointObjectTest objectForKey:@"temperature"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedTemperature, [hourlyDataPointObject temperature], 2, @"Temperature Failed");
    
    double expectedApparentTemperature = [[hourlyDataPointObjectTest objectForKey:@"apparentTemperature"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedApparentTemperature, [hourlyDataPointObject apparentTemperature], 2, @"ApparentTemperature Failed");
    
    
    double expectedDewPoint = [[hourlyDataPointObjectTest objectForKey:@"dewPoint"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedDewPoint, [hourlyDataPointObject dewPoint], 2, @"DewPoint Failed");
    
    
    double expectedHumidity = [[hourlyDataPointObjectTest objectForKey:@"humidity"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedHumidity, [hourlyDataPointObject humidity], 2, @"Humidity Failed");
    
    
    double expectedWindSpeed = [[hourlyDataPointObjectTest objectForKey:@"windSpeed"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedWindSpeed, [hourlyDataPointObject windSpeed], 2, @"WindSpeed Failed");
    
    
    double expectedWindBearing = [[hourlyDataPointObjectTest objectForKey:@"windBearing"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedWindBearing, [hourlyDataPointObject windBearing], 2, @"WindBearing Failed");
    
    
    double expectedCloudCover = [[hourlyDataPointObjectTest objectForKey:@"cloudCover"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedCloudCover, [hourlyDataPointObject cloudCover], 2, @"CloudCover Failed");
    
    
    double expectedPressure = [[hourlyDataPointObjectTest objectForKey:@"pressure"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPressure, [hourlyDataPointObject pressure], 2, @"Pressure Failed");
    
    
    double expectedOzone = [[hourlyDataPointObjectTest objectForKey:@"ozone"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedOzone, [hourlyDataPointObject ozone], 2, @"Ozone Failed");
    
    double expectedPrecipAccumulation = [[hourlyDataPointObjectTest objectForKey:@"precipAccumulation"] doubleValue];
    
    XCTAssertEqualWithAccuracy(expectedPrecipAccumulation, [hourlyDataPointObject precipAccumulation], 2, @"PrecipAccumulation Failed");
    
    XCTAssertEqualWithAccuracy(-1, [hourlyDataPointObject visibility], 2, @"Visibility Failed");
    
}

- (void) testEmptinessCheck
{
    XCTAssertEqual(NO, [CommonUtil emptinessCheck:nil checkingKey:nil], @"Emptiness Case 1 Failed");
    
    XCTAssertEqual(NO, [CommonUtil emptinessCheck:nil checkingKey:@"key"], @"Emptiness Case 2 Failed");
    
    XCTAssertEqual(YES, [CommonUtil emptinessCheck:[NSMutableDictionary dictionary] checkingKey:nil], @"Emptiness Case 3 Failed");
    
    XCTAssertEqual(YES, [CommonUtil emptinessCheck:currentlyDataPointObjectTest checkingKey:@"summary"], @"Emptiness Case 4 Failed");
    
    XCTAssertEqual(YES, [CommonUtil emptinessCheck:currentlyDataPointObjectTest checkingKey:@"pressure"], @"Emptiness Case 5 Failed");
    
    XCTAssertEqual(NO, [CommonUtil emptinessCheck:currentlyDataPointObjectTest checkingKey:@"nearestStormBearing"], @"Emptiness Case 6 Failed");
}



@end
