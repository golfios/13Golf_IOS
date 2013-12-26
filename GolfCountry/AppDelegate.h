//
//  AppDelegate.h
//  GolfCountry
//
//  Created by xijun on 13-11-28.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *_navigation;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) UINavigationController *navigation;
@property (nonatomic,assign) NetworkStatus netStatus;

+ (AppDelegate*)shareAppDelegate;

-(void)startNetworkReachability;
-(void)networkChanged:(id)sender;

//搜索视图
-(UIViewController*)viewController:(Class)className;

@end
