//
//  UIIntroduceButton.m
//  GolfCountry
//
//  Created by xijun on 13-12-11.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIIntroduceButton.h"
#import "UICommonView.h"

@implementation UIIntroduceButton

@synthesize icon = _icon;
@synthesize title = _title;
@synthesize des = _des;

- (void)dealloc
{
    [_icon release];
    [_title release];
    [_des release];
    
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
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(75, 6, 200, 29)];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont systemFontOfSize:16];
        [self addSubview:_title];
        
        _des = [[UILabel alloc] initWithFrame:CGRectMake(75, 35, 240, 20)];
        _des.backgroundColor = [UIColor clearColor];
        _des.textColor = [Utility hexStringToColor:@"ced0cb"];
        _des.font = [UIFont systemFontOfSize:15];
        [self addSubview:_des];
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
