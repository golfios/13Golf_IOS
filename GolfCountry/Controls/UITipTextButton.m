//
//  UITipTextButton.m
//  GolfCountry
//
//  Created by xijun on 13-12-18.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UITipTextButton.h"

@implementation UITipTextButton

@synthesize tipLable = _tipLabel;
@synthesize titleLabel = _titleLabel;
@synthesize textField = _textField;
@synthesize arrow = _arrow;

- (void)dealloc
{
    [_tipLabel release];
    [_titleLabel release];
    [_textField release];
    [_arrow release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        int control_x = 10;
        int control_y = 10;
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(control_x, control_y, 70, 20)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.font = [UIFont boldSystemFontOfSize:MidFontSize];
        [self addSubview:_tipLabel];
        
        control_x += 70 + 10;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(control_x, control_y, 180, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:MidFontSize];
        [self addSubview:_titleLabel];
        
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(280, 5, 10, 29)];
        _arrow.image = [UIImage imageNamed:@"person_22.png"];
        [self addSubview:_arrow];
    }
    return self;
}

- (void)showTextFieldDate
{
    _titleLabel.hidden = YES;
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:_titleLabel.frame];
        _textField.backgroundColor = [UIColor clearColor];
//        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.enabled = NO;
        _textField.placeholder = @"点击选择日期";
        [self addSubview:_textField];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
