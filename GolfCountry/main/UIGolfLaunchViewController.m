//
//  UIGolfLaunchViewController.m
//  GolfCountry
//
//  Created by xijun on 13-11-29.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfLaunchViewController.h"
#import "GolfLoginViewController.h"
#import "AppDelegate.h"

@interface UIGolfLaunchViewController ()

@end

@implementation UIGolfLaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *tempView = [[UIView alloc] initWithFrame:frame];
    self.view = tempView;
    [tempView release];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:frame];
    bgView.image = [UIImage imageNamed:@"golf_launch.png"];
    [self.view addSubview:bgView];
    [bgView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self startTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)startTimer
{
    _timer = [[NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(onTimer) userInfo:nil repeats:YES] retain];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

//定时器操作
-(void)onTimer
{
    [_timer invalidate];
    _timer = nil;
    
    GolfLoginViewController *controller = [[GolfLoginViewController alloc] initWithNibName:@"GolfLoginViewController" bundle:nil];
//    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
    [controller release];
}

@end
