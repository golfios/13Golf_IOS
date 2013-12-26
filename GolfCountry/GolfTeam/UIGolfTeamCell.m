//
//  UIGolfTeamCell.m
//  GolfCountry
//
//  Created by xijun on 13-12-21.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfTeamCell.h"

@implementation UIGolfTeamCell

@synthesize headIcon  = _headIcon;
@synthesize nameLabel = _nameLabel;
@synthesize desLabel  = _desLabel;
@synthesize joinButton = _joinButton;
@synthesize arrowView = _arrowView;

- (void)dealloc
{
    [_headIcon release];
    [_nameLabel release];
    [_desLabel release];
    [_joinButton release];
    [_arrowView release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        _headIcon.image = [UIImage imageNamed:@"head_default.png"];
        [self.contentView addSubview:_headIcon];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:MidFontSize];
        [self.contentView addSubview:_nameLabel];
        
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 230, 20)];
        _desLabel.backgroundColor = [UIColor clearColor];
        _desLabel.textColor = [UIColor grayColor];
        _desLabel.font = [UIFont boldSystemFontOfSize:SmallFontSize];
        [self.contentView addSubview:_desLabel];
        
        _joinButton = [[UIButton alloc] initWithFrame:CGRectMake(300-76, 16, 76, 28)];
        _joinButton.titleLabel.font = [UIFont systemFontOfSize:TinyFontSize];
        [_joinButton setTitle:@"申请加入" forState:UIControlStateNormal];
        [_joinButton setBackgroundImage:[UIImage imageNamed:@"myTeam_03.png"] forState:UIControlStateNormal];
        [_joinButton setBackgroundImage:[UIImage imageNamed:@"myTeam_03_high.png"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_joinButton];
        
        NSInteger arrow_y = (60-30) / 2;
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(300, arrow_y, 10, 29)];
        _arrowView.hidden = YES;
        _arrowView.image = [UIImage imageNamed:@"person_22.png"];
        [self.contentView addSubview:_arrowView];
    }
    return self;
}

- (void)setButtonText:(BOOL)isJoined
{
    if (isJoined) {
        _joinButton.enabled = NO;
        [_joinButton setBackgroundImage:[UIImage imageNamed:@"allTeam_10.png"] forState:UIControlStateNormal];
    }
    else {
        _joinButton.enabled = YES;
        [_joinButton setTitle:@"申请加入" forState:UIControlStateNormal];
        [_joinButton setBackgroundImage:[UIImage imageNamed:@"myTeam_03.png"] forState:UIControlStateNormal];
    }
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
