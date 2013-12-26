//
//  UISettingViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-5.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UISettingViewController.h"
#import "UICommonView.h"

@interface UISettingViewController ()
{
    UICommonView    *_comView;
}

@end

@implementation UISettingViewController

- (void)dealloc
{
    [_comView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    _comView = [[UICommonView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [_comView setTitleText:@"Golf-setting"];
    _comView.leftButton.hidden = YES;
    _comView.rightButton.hidden = YES;
    self.view = _comView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
