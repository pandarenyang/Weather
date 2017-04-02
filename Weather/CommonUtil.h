//
//  CommonUtil.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CommonUtil : NSObject

+ (void) displayAlert:(NSString*)title :(NSString*)message :(id)delegate;

+ (BOOL) emptinessCheck:(NSMutableDictionary *) dictionary checkingKey:(NSString *) key;

+ (void) showActivityIndicator:(UIView *)view;

+ (void) hideActivityIndicator:(UIView *)view;

@end
