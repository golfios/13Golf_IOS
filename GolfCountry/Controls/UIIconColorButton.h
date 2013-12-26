//
//  UIIconColorButton.h
//  GolfCountry
//
//  Created by xijun on 13-12-26.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIIconColorButton : UIButton
{
    UILabel     *_labelNum;
    UIImageView *_iconView;
    UILabel     *_labelTitle;
}

@property (nonatomic, retain)UILabel *labelNum;
@property (nonatomic, retain)UILabel *labelTitle;
@property (nonatomic, retain)UIImageView *iconView;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color;

@end
