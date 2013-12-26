//
//  UIGolfLaunchViewController.h
//  GolfCountry
//
//  Created by xijun on 13-11-29.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGolfLaunchViewController : UIViewController
{
    NSTimer*      _timer;
}


-(void)startTimer;

//定时器操作
-(void)onTimer;


@end
