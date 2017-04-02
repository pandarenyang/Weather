//
//  WeatherDataHandler.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "PandaURLLoader.h"

#import "CommonUtil.h"

#import "WeatherDataObject.h"

@protocol WeatherDataHandlerProtocol

- (void) datasetChanged:(WeatherDataObject *) weatherDataObject;

@end


@interface WeatherDataHandler : NSObject<PandaURLLoaderDelegate> {
    
    __weak id<WeatherDataHandlerProtocol> delegate;
    
    WeatherDataObject *lastKnownDataObject;
}

@property (nonatomic, strong) WeatherDataObject *lastKnownDataObject;

@property(nonatomic, weak) id<WeatherDataHandlerProtocol> delegate;

@end
