//
//  UIIconTextButton.h
//  GolfCountry
//
//  Created by xijun on 13-12-8.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIIconTextButton : UIButton
{
    UIImageView *_icon;
    UILabel     *_titleLabel;
    UIImageView *_arrow;
}

@property (nonatomic, retain)UIImageView *icon;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UIImageView *arrow;

- (void)resetControlRect;

@end
