//
//  GolfLoginViewController.h
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GolfRegistViewController.h"

@class LoginModel;

@protocol GolfLoginControllerDelegate <NSObject>

- (void)LoginSuccessful;

@end

@interface GolfLoginViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate, GolfRegistControllerDelegate>
{
    UILabel         *_noticeLabel;
    UITextField     *_accTextField;
    UITextField     *_pwdTextField;
    
    LoginModel      *_loginModel;
}

@property (nonatomic, retain)UILabel *noticeLabel;
@property (nonatomic, retain)UITextField *accTextField;
@property (nonatomic, retain)UITextField *pwdTextField;
@property (nonatomic, assign)id<GolfLoginControllerDelegate> delegate;

@end
