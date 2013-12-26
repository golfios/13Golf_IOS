//
//  UICreateTeamViewController.h
//  GolfCountry
//
//  Created by xijun on 13-12-16.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIEditViewController.h"
#import "UICitySelectController.h"
#import "UIChooseImgViewController.h"

@interface UICreateTeamViewController : UIViewController<UIEditViewControllerDelegate, UICitySelectControllerDelegate, UIChooseImgControllerDelegate>

@end
