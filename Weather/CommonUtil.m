//
//  CommonUtil.m
//  Weather
//
//  Created by Panda on 2/4/17.
//  Copyright © 2017 Panda. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (void) displayAlert:(NSString*)title :(NSString*)message :(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:delegate
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
}

+ (BOOL) emptinessCheck:(NSMutableDictionary *) dictionary checkingKey:(NSString *) key
{
    if(!dictionary)
    {
        return NO;
    }
    
    if(key)
    {
        if(![dictionary objectForKey:key])
        {
            return NO;
        }
        
        if([[dictionary objectForKey:key] isEqual:[NSNull null]])
        {
            return NO;
        }
    }
    
    return YES;
}


+ (void) showActivityIndicator:(UIView *)view
{
    UIView *coverLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [view frame].size.width, [view frame].size.height)];
    
    [coverLayer setTag:999];
    
    [coverLayer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    [coverLayer setAutoresizesSubviews:YES];
    
    [coverLayer setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    [coverLayer setAlpha:0];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [spinner setFrame:CGRectMake([view frame].size.width/2 - [spinner frame].size.width/2 , [view frame].size.height/2 - [spinner frame].size.height/2, [spinner frame].size.width, [spinner frame].size.height)];
    
    [spinner setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin];
    
    [spinner startAnimating];
    
    [coverLayer addSubview:spinner];
    
    [view addSubview:coverLayer];
    
    
    [UIView beginAnimations: @"ActivityIndShow" context:nil];
    [UIView setAnimationDuration:0.3];
    
    [coverLayer setAlpha:1];
    
    [UIView commitAnimations];
    
    [view setUserInteractionEnabled:NO];
}

+ (void) hideActivityIndicator:(UIView *)view
{
    for(id subview in [view subviews])
    {
        if([subview tag] == 999)
        {
            [UIView beginAnimations: @"ActivityIndHide" context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelegate:subview];
            [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
            
            [subview setAlpha:0];
            
            [UIView commitAnimations];
        }
    }
    
    [view setUserInteractionEnabled:YES];
}



@end
