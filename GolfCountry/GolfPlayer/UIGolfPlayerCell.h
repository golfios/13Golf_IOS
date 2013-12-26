//
//  UIGolfPlayerCell.h
//  GolfCountry
//
//  Created by xijun on 13-12-13.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGolfPlayerCell : UITableViewCell
{
    UIImageView *_headIcon;
    UILabel     *_nameLabel;
    UILabel     *_desLabel;
    UIImageView *_followImage;
    UILabel     *_followLabel;
}

@property (nonatomic, retain)UIImageView *headIcon;
@property (nonatomic, retain)UILabel *nameLabel, *desLabel;
@property (nonatomic, retain)UIImageView *followImage;
@property (nonatomic, retain)UILabel *followLabel;

- (void)setDesText:(NSInteger)num1 :(NSInteger)num2 :(float)num3;
- (void)setDesText:(NSInteger)count :(NSString*)city;

- (void)setFollowText:(BOOL)isFollowed;

@end
