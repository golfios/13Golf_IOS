//
//  UITipTextButton.h
//  GolfCountry
//
//  Created by xijun on 13-12-18.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITipTextButton : UIButton
{
    UILabel     *_tipLabel;
    UILabel     *_titleLabel;
    UITextField *_textField;
    UIImageView *_arrow;
}

@property (nonatomic, retain) UILabel *tipLable;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIImageView *arrow;

- (void)showTextFieldDate;

@end
