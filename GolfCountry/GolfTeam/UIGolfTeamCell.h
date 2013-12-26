//
//  UIGolfTeamCell.h
//  GolfCountry
//
//  Created by xijun on 13-12-21.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGolfTeamCell : UITableViewCell
{
    UIImageView *_headIcon;
    UILabel     *_nameLabel;
    UILabel     *_desLabel;
    UIButton    *_joinButton;
    UIImageView *_arrowView;
}

@property (nonatomic, retain)UIImageView *headIcon;
@property (nonatomic, retain)UILabel *nameLabel, *desLabel;
@property (nonatomic, retain)UIButton *joinButton;
@property (nonatomic, retain)UIImageView *arrowView;

- (void)setDesText:(NSInteger)count :(NSString*)city;

- (void)setButtonText:(BOOL)isJoined;


@end
