//
//  UIGolfPlayerCell.m
//  GolfCountry
//
//  Created by xijun on 13-12-13.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfPlayerCell.h"

@implementation UIGolfPlayerCell

@synthesize headIcon  = _headIcon;
@synthesize nameLabel = _nameLabel;
@synthesize desLabel  = _desLabel;
@synthesize followImage = _followImage;
@synthesize followLabel = _followLabel;

- (void)dealloc
{
    [_headIcon release];
    [_nameLabel release];
    [_desLabel release];
    [_followImage release];
    [_followLabel release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        _headIcon.image = [UIImage imageNamed:@"teamLogo_default.png"];
        [self.contentView addSubview:_headIcon];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:MidFontSize];
        [self.contentView addSubview:_nameLabel];
        
        _followImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 10, 36, 18)];
        _followImage.image = [UIImage imageNamed:@"fans_btn.png"];
        [self.contentView addSubview:_followImage];
        
        _followLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36, 18)];
        _followLabel.backgroundColor = [UIColor clearColor];
        _followLabel.textColor = [UIColor whiteColor];
        _followLabel.font = [UIFont systemFontOfSize:TinyFontSize];
        _followLabel.text = @"关注";
        _followLabel.textAlignment = UITextAlignmentCenter;
        [_followImage addSubview:_followLabel];
        
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 230, 20)];
        _desLabel.backgroundColor = [UIColor clearColor];
        _desLabel.textColor = [UIColor grayColor];
        _desLabel.font = [UIFont boldSystemFontOfSize:SmallFontSize];
        [self.contentView addSubview:_desLabel];
        
        NSInteger arrow_y = (60-30) / 2;
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(300, arrow_y, 10, 29)];
        arrowView.image = [UIImage imageNamed:@"person_22.png"];
        [self.contentView addSubview:arrowView];
        [arrowView release];
    }
    return self;
}

- (void)setFollowText:(BOOL)isFollowed
{
    if (isFollowed) {
        _followImage.image = [UIImage imageNamed:@"followed_btn.png"];
        _followLabel.text = @"已关注";
        _followLabel.textColor = RGBA(103, 103, 103, 1.0f);
    }
    else {
        _followImage.image = [UIImage imageNamed:@"fans_btn.png"];
        _followLabel.text = @"关注";
        _followLabel.textColor = [UIColor whiteColor];
    }
}

- (void)setDesText:(NSInteger)num1 :(NSInteger)num2 :(float)num3
{
    _desLabel.text = [NSString stringWithFormat:@"球龄：%d年  粉丝：%d  差点：%.1f", num1, num2, num3];
}

- (void)setDesText:(NSInteger)count :(NSString *)city
{
    _desLabel.text = [NSString stringWithFormat:@"%d名队员    %@", count, city];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
