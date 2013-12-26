//
//  GolfRegistViewController.h
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GolfRegistControllerDelegate <NSObject>

- (void)RegistSuccessful;

@end

@interface GolfRegistViewController : UIViewController<UITextFieldDelegate>
{
    UILabel         *_noticeLabel;      /** 注册提示 */
    UITextField     *_accTextField;     /** 账号 */
    UITextField     *_pwdTextField;     /** 密码 */
    UITextField     *_confirmTextField; /** 确认密码 */
    UITextField     *_nicknameTextField;/** 昵称 */
    UITextField     *_identityTextField;/** 身份证 */
    
    NSInteger       _registType;        /** 0为匿名注册，1为实名注册 */
}

@property (nonatomic, retain)UILabel *noticeLabel;
@property (nonatomic, retain)UITextField *accTextField;
@property (nonatomic, retain)UITextField *pwdTextField;
@property (nonatomic, retain)UITextField *confirmTextField;
@property (nonatomic, retain)UITextField *nicknameTextField;
@property (nonatomic, retain)UITextField *identityTextField;
@property (nonatomic, assign)NSInteger registType;
@property (nonatomic, assign)id<GolfRegistControllerDelegate> delegate;

@end
