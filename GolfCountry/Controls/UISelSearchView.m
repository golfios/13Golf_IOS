//
//  UISelSearchView.m
//  GolfCountry
//
//  Created by xijun on 13-12-12.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UISelSearchView.h"

@implementation UISelSearchView

@synthesize bgView = _bgView;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize textField = _textField;

- (void)dealloc
{
    [_bgView release];
    [_leftButton release];
    [_rightButton release];
    [_textField release];
    [_textFieldBg release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 29)];
        _bgView.image = [UIImage imageNamed:@"player_1.png"];
        [self addSubview:_bgView];
        
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 150, 29)];
        [_leftButton setTitle:@"选择地区：北京" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
        [self addSubview:_leftButton];
        
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 5, 150, 29)];
        [_rightButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_rightButton setTitleColor:RGBA(55, 113, 15, 1.0f) forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
        [self addSubview:_rightButton];
    }
    return self;
}

- (void)setLeftText:(NSString *)text
{
    [_leftButton setTitle:text forState:UIControlStateNormal];
}

- (void)setRightText:(NSString *)text
{
    [_rightButton setTitle:text forState:UIControlStateNormal];
}

- (void)showTextFieldHidden:(BOOL)isHidden
{
    if (_textField == nil) {
        _textFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 29)];
        _textFieldBg.image = [UIImage imageNamed:@"search_button.png"];
        [self addSubview:_textFieldBg];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 250, 28)];
        [_textField setReturnKeyType:UIReturnKeySearch];
        [_textField setFont:[UIFont systemFontOfSize:SmallFontSize]];
        [_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self addSubview:_textField];
    }
    
    _textFieldBg.hidden = isHidden;
    _textField.hidden = isHidden;
    _leftButton.hidden = !isHidden;
    _rightButton.hidden = !isHidden;
    
    if (isHidden == NO) {
        _bgView.image = [UIImage imageNamed:@"player_2.png"];
        [_leftButton setTitleColor:RGBA(55, 113, 15, 1.0f) forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)showButtonFocus
{
    _textField.hidden = YES;
    _leftButton.hidden = NO;
    _rightButton.hidden = NO;
    _bgView.image = [UIImage imageNamed:@"player_1.png"];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:RGBA(55, 113, 15, 1.0f) forState:UIControlStateNormal];
}

- (void)showRightBtnFocus
{
    _textField.hidden = YES;
    _leftButton.hidden = NO;
    _rightButton.hidden = NO;
    _bgView.image = [UIImage imageNamed:@"player_2.png"];
    [_leftButton setTitleColor:RGBA(55, 113, 15, 1.0f) forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
