//
//  UITeamInfoViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-21.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UITeamInfoViewController.h"
#import "UICommonView.h"
#import "UITipTextButton.h"
#import "GolfTeamModel.h"

#define KButtonWidth        300
#define KButtonHeight       40

@interface UITeamInfoViewController ()
{
    UICommonView    *_comView;
    UIScrollView    *_scrollView;
    
    UIButton        *_joinButton;
}

@end

@implementation UITeamInfoViewController

@synthesize teamInfo;

- (void)dealloc
{
    [_comView release];
    [_scrollView release];
    
    [_joinButton release];
    
    self.teamInfo = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CGRect rect = [UIScreen mainScreen].applicationFrame;
    _comView = [[UICommonView alloc] initWithFrame:rect];
    [_comView setBackgroundImage:nil];
    _comView.backgroundColor = [Utility hexStringToColor:@"EBEFEB"];
    [_comView setTitleText:self.title];
    _comView.rightButton.hidden = YES;
    self.view = _comView;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, rect.size.height)];
    [self.view addSubview:_scrollView];
    
    int control_x = 10;
    int control_y = 15;
    UIImageView *viewBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 100)];
    viewBg1.image = [UIImage imageNamed:@"createTeam_01.png"];
    [_scrollView addSubview:viewBg1];
    [viewBg1 release];
    
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(control_x+15, control_y+10, 80, 80)];
    logoImg.image = [UIImage imageNamed:@"head_default.png"];
    [_scrollView addSubview:logoImg];
    [logoImg release];
    
    UILabel *tipLabel = [UICommonView createLabel:CGRectMake(control_x+110, control_y+15, 100, 15) :[UIColor grayColor] :[UIFont systemFontOfSize:SmallFontSize]];
    tipLabel.text = @"领队";
    [_scrollView addSubview:tipLabel];
    
    UILabel *nameLabel = [UICommonView createLabel:CGRectMake(control_x+110, control_y+40, 100, 15) :[UIColor blackColor] :[UIFont systemFontOfSize:MidFontSize]];
    nameLabel.text = teamInfo.contacts;
    [_scrollView addSubview:nameLabel];
    
    UILabel *phoneTipLabel = [UICommonView createLabel:CGRectMake(control_x+110, control_y+65, 40, 15) :[UIColor blackColor] :[UIFont systemFontOfSize:SmallFontSize]];
    phoneTipLabel.text = @"电话";
    [_scrollView addSubview:phoneTipLabel];
    
    UILabel *phoneLabel = [UICommonView createLabel:CGRectMake(control_x+150, control_y+65, 150, 15) :[UIColor blackColor] :[UIFont systemFontOfSize:SmallFontSize]];
    phoneLabel.text = teamInfo.phone;
    [_scrollView addSubview:phoneLabel];
    
    control_y += 100 +15;
    UIImageView *viewBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 200)];
    viewBg2.image = [UIImage imageNamed:@"teamInfo_06.png"];
    [_scrollView addSubview:viewBg2];
    [viewBg2 release];
    
    UITipTextButton *teamCityBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    teamCityBtn.tipLable.text = @"所属地区";
    teamCityBtn.titleLabel.text = teamInfo.city;
    teamCityBtn.arrow.hidden = YES;
    [_scrollView addSubview:teamCityBtn];
    
    control_y += KButtonHeight;
    UITipTextButton *teamMemberBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    teamMemberBtn.tipLable.text = @"球队成员";
    teamMemberBtn.titleLabel.text = [NSString stringWithFormat:@"%d人", teamInfo.count];
    teamMemberBtn.arrow.hidden = YES;
    [_scrollView addSubview:teamMemberBtn];
    
    control_y += KButtonHeight;
    UITipTextButton *createDateBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    createDateBtn.tipLable.text = @"成立日期";
    createDateBtn.titleLabel.text = teamInfo.createdDate;
    createDateBtn.arrow.hidden = YES;
    [_scrollView addSubview:createDateBtn];
    
    control_y += KButtonHeight;
    UITipTextButton *teamPurposeBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    teamPurposeBtn.tipLable.text = @"球队宗旨";
    teamPurposeBtn.titleLabel.text = teamInfo.purpose;
    [_scrollView addSubview:teamPurposeBtn];
    
    control_y += KButtonHeight;
    UITipTextButton *teamIntroBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    teamIntroBtn.tipLable.text = @"球队简介";
    teamIntroBtn.titleLabel.text = teamInfo.description;
    [_scrollView addSubview:teamIntroBtn];
    
    control_y += KButtonHeight*3/2;
    _joinButton = [[UIButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    [_joinButton setBackgroundImage:[UIImage imageNamed:@"teamInfo_08.png"] forState:UIControlStateNormal];
    [_joinButton setTitle:@"申请加入" forState:UIControlStateNormal];
    [_scrollView addSubview:_joinButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
