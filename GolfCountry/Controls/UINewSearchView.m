//
//  UINewSearchView.m
//  GolfCountry
//
//  Created by xijun on 13-12-5.
//  Copyright (c) 2013年 Pica. All rights reserved.
//

#import "UINewSearchView.h"

@implementation UINewSearchView

@synthesize searchTextField = _searchTextField;

- (void)dealloc
{
    [_searchTextField release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImage.image = [UIImage imageNamed:@"search_button.png"];
        _bgImage.userInteractionEnabled = YES;
        [self addSubview:_bgImage];
        [_bgImage release];
        
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 5, frame.size.width-50, frame.size.height-10)];
        _searchTextField.placeholder = @"搜索";
        _searchTextField.font = [UIFont systemFontOfSize:SmallFontSize];
        _searchTextField.backgroundColor =[UIColor clearColor];
        
        _searchTextField.keyboardType = UIKeyboardTypeDefault;
        [_searchTextField setReturnKeyType:UIReturnKeySearch];
        [_searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_searchTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self addSubview:_searchTextField];
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
