//
//  UIIntroduceButton.h
//  GolfCountry
//
//  Created by xijun on 13-12-11.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIIntroduceButton : UIButton
{
    UIImageView *_icon;
    UILabel     *_title;
    UILabel     *_des;
}

@property (nonatomic, retain)UIImageView *icon;
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UILabel *des;

@end
