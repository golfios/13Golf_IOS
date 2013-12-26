//
//  UISelSearchView.h
//  GolfCountry
//
//  Created by xijun on 13-12-12.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISelSearchView : UIView
{
    UIImageView *_bgView;
    UIButton    *_leftButton;
    UIButton    *_rightButton;
    UITextField *_textField;
    UIImageView *_textFieldBg;
}

@property (nonatomic, retain)UIImageView    *bgView;
@property (nonatomic, retain)UIButton       *leftButton;
@property (nonatomic, retain)UIButton       *rightButton;
@property (nonatomic, retain)UITextField    *textField;

- (void)showTextFieldHidden:(BOOL)isHidden;
- (void)showButtonFocus;
- (void)showRightBtnFocus;
- (void)setLeftText:(NSString*)text;
- (void)setRightText:(NSString*)text;

@end
