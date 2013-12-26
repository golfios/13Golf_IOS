//
//  UIIconColorButton.m
//  GolfCountry
//
//  Created by xijun on 13-12-26.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIIconColorButton.h"

@implementation UIIconColorButton

@synthesize labelNum = _labelNum;
@synthesize labelTitle = _labelTitle;
@synthesize iconView = _iconView;

- (void)dealloc
{
    [_labelNum release];
    [_labelTitle release];
    [_iconView release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        int width = frame.size.width;
        int height = frame.size.height;
        
        [self setBackgroundImage:[UIImage imageNamed:@"golfTeam_12.png"] forState:UIControlStateNormal];
        
        _labelNum = [[UILabel alloc] initWithFrame:CGRectMake(width-60, 10, 50, 15)];
        _labelNum.backgroundColor = [UIColor clearColor];
        _labelNum.textColor = color;
        _labelNum.font = [UIFont systemFontOfSize:14];
        [self addSubview:_labelNum];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake((width-64)/2, 30, 64, 43)];
        [self addSubview:_iconView];
        
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, height-25, width-20, 20)];
        _labelTitle.backgroundColor = [UIColor clearColor];
        _labelTitle.textColor = color;
        _labelTitle.font = [UIFont systemFontOfSize:16];
        _labelTitle.textAlignment = UITextAlignmentCenter;
        [self addSubview:_labelTitle];
    }
    return self;
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
