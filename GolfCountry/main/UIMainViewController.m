//
//  UIMainViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-8.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIMainViewController.h"
#import "UICommonView.h"

@interface UIMainViewController ()
{
    UICommonView *_comView;
}

@end

@implementation UIMainViewController

@synthesize tabBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 为tabBarController做一些额外的初始化工作
    self.tabBarController.selectedIndex = 0;
    // 让tabBarController正好充满父视图。
    CGRect rc = self.tabBarController.view.frame;
    rc.size.height = self.view.frame.size.height;
    self.tabBarController.view.frame = rc;
    [self.view addSubview:self.tabBarController.view];
    // 根据当前选择的tab来设置标题
//    [self setTitle];
    // 设置navBar颜色
//    self.navigationController.navigationBar.tintColor = CP_THEME_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 5.0) {
        static UIViewController *lastTabController = nil;
        
        //若上个view不为空
        if (lastTabController != nil)
        {
            //若该实例实现了viewWillDisappear方法，则调用
            if ([lastTabController respondsToSelector:@selector(viewWillDisappear:)])
            {
                [lastTabController viewWillDisappear:YES];
            }
        }
        
        //将当前要显示的view设置为lastController，在下次view切换调用本方法时，会执行viewWillDisappear
        lastTabController = viewController;
        
        [viewController viewWillAppear:YES];
    }
    // 根据当前选择的tab来设置标题
//    [self setTitle];
//    if (self.tabBarController.selectedIndex==1 && [viewController isKindOfClass:[ProductCenterViewController class]]) {
//        ProductCenterViewController *view = (ProductCenterViewController *)viewController;
//        [view loadProductList];
//    }
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if ([viewController isKindOfClass:[IndexViewController class]]) {
//        [[HomeViewController shareApplication].homeScrollView setScrollEnabled:YES];
//    }else{
//        [[HomeViewController shareApplication].homeScrollView setScrollEnabled:NO];
//    }
    if (version < 5.0) {
        //每次当navigation中的界面切换，设为空。本次赋值只在程序初始化时执行一次
        static UIViewController *lastController = nil;
        
        //若上个view不为空
        if (lastController != nil)
        {
            //若该实例实现了viewWillDisappear方法，则调用
            if ([lastController respondsToSelector:@selector(viewWillDisappear:)])
            {
                [lastController viewWillDisappear:animated];
            }
        }
        
        //将当前要显示的view设置为lastController，在下次view切换调用本方法时，会执行viewWillDisappear
        lastController = viewController;
        
        [viewController viewWillAppear:animated];
    }
}

@end
