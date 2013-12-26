//
//  UICommonView.h
//  GolfCountry
//
//  Created by xijun on 13-11-28.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class MBProgressHUD;

@protocol UICommonViewDeleate <NSObject>

@optional

- (void)goBack;

@end

@interface UICommonView : UIView
{
    UIButton* _leftButton;
    UIButton* _rightButton;
    UILabel*  _topTitle;
    
    UIImageView* _backgroundImageView;
    
    UIView* _navBarView;
    
    UITextField *_textField;
}

@property(nonatomic,retain)UIView   *navBarView;
@property(nonatomic,retain)UIButton *leftButton,*rightButton;
@property(nonatomic,retain)UILabel* topTitle;
@property(nonatomic,retain)UITextField *textField;

@property(nonatomic,retain)UIImage* backgroundImage;

@property (nonatomic, assign) id<UICommonViewDeleate> comDeleate;

@property (retain, nonatomic) MBProgressHUD *HUD;

+ (NSInteger)getNavHeight;

-(UILabel *)getNeedTipsInputLabel; //显示必填项的星号
+(UILabel *)getNeedTipsInputLabel; //显示必填项的星号
+(UILabel *)getPlsSelectedLabel; //显示请选择
+(void)removePlsSelectedLabel:(UIView *)view; //移除请选择
+(UILabel *)getNoDataLabel:(CGFloat)yLocation; //显示没有相关数据
+(UILabel *)createLabel:(CGRect)frame :(UIColor*)textColor :(UIFont*)font;

- (void)showTextField;

-(void)setBackButtonImage;
-(void)setTitleText:(NSString*)strTitle;
- (void)setLeftText:(NSString*)text;
- (void)setRightText:(NSString*)text;

- (void)setLeftIcon:(UIImage *)icon selected:(UIImage *)selIcon;
- (void)setRightIcon:(UIImage *)icon selected:(UIImage *)selIcon;
- (void)setRightIcon:(UIImage*)icon andText:(NSString*)text;

-(void)closeController;

-(void)showAlertMessage:(NSString*)strMessage;
-(void)showAlertMessage:(NSString*)strMessage delegate:(id)delegate;
+(void)showAlertMessage:(NSString*)strMessage;

- (void)showProgessHUD:(NSString*)text;
- (void)hideProgessHUD;

@end
