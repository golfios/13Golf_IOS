//
//  UIIconTextButton.m
//  GolfCountry
//
//  Created by xijun on 13-12-8.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIIconTextButton.h"

@implementation UIIconTextButton

@synthesize icon = _icon;
@synthesize titleLabel = _titleLabel;
@synthesize arrow = _arrow;

- (void)dealloc
{
    [_icon release];
    [_titleLabel release];
    [_arrow release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = RGBA(54, 54, 54, 1.0f);
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(33, 6, 31, 29)];
        [self addSubview:_icon];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 6, 200, 29)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(239, 6, 10, 29)];
        _arrow.image = [UIImage imageNamed:@"person_22.png"];
        [self addSubview:_arrow];
    }
    return self;
}

- (void)resetControlRect
{
    _arrow.hidden = YES;
    
    _icon.frame = CGRectMake(100, 12, 16, 16);
    _titleLabel.frame = CGRectMake(120, 12, 100, 16);
    _titleLabel.textColor = [Utility hexStringToColor:@"ABABAB"];
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
