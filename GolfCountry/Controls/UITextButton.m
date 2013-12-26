//
//  UITextButton.m
//  GolfCountry
//
//  Created by xijun on 13-12-10.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UITextButton.h"

@implementation UITextButton

@synthesize label1 = _label1;
@synthesize label2 = _label2;

- (void)dealloc
{
    [_label1 release];
    [_label2 release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGSize size = frame.size;
        NSInteger width = size.width;
        NSInteger height = size.height / 2;
        
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.textColor = RGBA(130, 210, 41, 1.0f);
        _label1.textAlignment = UITextAlignmentCenter;
        _label1.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_label1];
        
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, height)];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.textColor = [UIColor grayColor];
        _label2.textAlignment = UITextAlignmentCenter;
        _label2.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_label2];
    }
    return self;
}

- (void)setButtonTexts:(NSInteger)text1 :(NSString *)text2
{
    _label1.text = [NSString stringWithFormat:@"%d", text1];
    _label2.text = text2;
}

- (void)resetLabelRect
{
    _label1.frame = CGRectMake(10, 5, 200, 20);
    _label1.textColor = [UIColor greenColor];
    _label1.font = [UIFont boldSystemFontOfSize:16];
    _label1.textAlignment = UITextAlignmentLeft;
    
    _label2.frame = CGRectMake(10, 25, 200, 15);
    _label2.textColor = [UIColor redColor];
    _label2.font = [UIFont systemFontOfSize:14];
    _label2.textAlignment = UITextAlignmentLeft;
    
    int controlX = self.frame.size.width-10-10;
    int controlY = (self.frame.size.height-29) / 2;
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(controlX, controlY, 10, 29)];
    arrow.image = [UIImage imageNamed:@"person_22.png"];
    [self addSubview:arrow];
    [arrow release];
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
