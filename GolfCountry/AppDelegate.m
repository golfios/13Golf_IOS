//
//  AppDelegate.m
//  GolfCountry
//
//  Created by xijun on 13-11-28.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "AppDelegate.h"
#import "EGOCache.h"
#import "UIGolfLaunchViewController.h"
#import "UIMainViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize netStatus = _netStatus;
@synthesize navigation = _navigation;

- (void)dealloc
{
    [_window release];
    [_navigation release];
    
    [super dealloc];
}

+ (AppDelegate*)shareAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    UIGolfMainViewController *mainViewController = [[UIGolfMainViewController alloc] initWithNibName:@"UIGolfMainViewController" bundle:nil];
//    [_window addSubview:_navigation.view];
    
    UIMainViewController *controller = [[UIMainViewController alloc] initWithNibName:@"UIMainViewController" bundle:nil];
    _navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    _navigation.navigationBarHidden = YES;
    [_window addSubview:_navigation.view];
    
    [_window makeKeyAndVisible];
    
    [[EGOCache currentCache] clearCache]; //清理cache中的图片
    
    // Override point for customization after application launch.

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)startNetworkReachability
{
    Reachability *internetReach = [[Reachability reachabilityForInternetConnection] retain];
    [internetReach startNotifier];
    _netStatus = [internetReach currentReachabilityStatus];
    
    [internetReach release];
    // 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name: kReachabilityChangedNotification object: nil];
}

-(void)networkChanged:(NSNotification*)note
{
    Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	
	NSLog(@"curReach currentReachabilityStatus ＝ %d",[curReach currentReachabilityStatus]);
	
	if ([curReach currentReachabilityStatus]== NotReachable)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"网络连接中断，请重新连接网络"
                                                       delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
	}
}

//搜索视图
-(UIViewController*)viewController:(Class)className
{
    NSArray *controllers = [_navigation viewControllers];
    for (UIViewController *vc in controllers) {
        if ([vc isKindOfClass:className]) {
            
            return vc;
        }
    }
    return nil;
}

@end
