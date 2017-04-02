//
//  SharedServiceFacade.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "PandaURLLoader.h"

#import "AppDelegate.h"

#define SERVER_URL @"https://api.forecast.io"

#define API_KEY @"69a5f978bf0d9498b802bfbbdaaee695"

@interface SharedServiceFacade : NSObject {
    
}

+ (void) getForecast:(id)delegate latitude:(double) latitude longitude:(double) longitude;

@end
