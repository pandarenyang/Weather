//
//  AppDelegate.h
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIViewController *viewController;
    
    UIWindow *window;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet UIViewController *viewController;

@end

