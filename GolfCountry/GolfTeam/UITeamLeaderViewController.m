//
//  UITeamLeaderViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-25.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UITeamLeaderViewController.h"
#import "UICommonView.h"
#import "GolfTeamModel.h"
#import "UIIconColorButton.h"
#import "UITextButton.h"

@interface UITeamLeaderViewController ()
{
    UICommonView    *_comView;
    UIScrollView    *_scrollView;
    UIImageView     *_headView;
}

@end

@implementation UITeamLeaderViewController

@synthesize teamInfo;

- (void)dealloc
{
    [_comView release];
    [_scrollView release];
    
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
    [_comView setTitleText:teamInfo.name];
    _comView.rightButton.hidden = YES;
    self.view = _comView;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, rect.size.height)];
    _scrollView.backgroundColor = [Utility hexStringToColor:@"EBEFEB"];
    [self.view addSubview:_scrollView];
    
    UIImageView *topBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 114)];
    topBg.image = [UIImage imageNamed:@"golfTeam_06.jpg"];
    [_scrollView addSubview:topBg];
    [topBg release];
    
    [self initSelfInfoView];
    
    int control_x = 10;
    int control_y = 150;
    UIView *noteView = [[UIView alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 140)];
    [_scrollView addSubview:noteView];
    [noteView release];
    
    UIImageView *commonBg = [[UIImageView alloc] initWithFrame:noteView.bounds];
    commonBg.image = [UIImage imageNamed:@"golfTeam_09.png"];
    [noteView addSubview:commonBg];
    [commonBg release];
    
    UILabel *labelNote = [self createLabelNo:CGRectMake(10, 10, 80, 20) :[Utility hexStringToColor:@"6fbd23"] :[UIFont boldSystemFontOfSize:19]];
    labelNote.text = @"活动公告";
    [noteView addSubview:labelNote];
    [labelNote release];
    
    UILabel *labelNew = [self createLabelNo:CGRectMake(90, 10, 80, 20) :[UIColor redColor] :[UIFont boldSystemFontOfSize:19]];
    labelNew.text = @"NEW";
    [noteView addSubview:labelNew];
    [labelNew release];

    UIButton *buttonEditNote = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 15, 15)];
    [buttonEditNote setBackgroundImage:[UIImage imageNamed:@"golfTeam_11.png"] forState:UIControlStateNormal];
    [noteView addSubview:buttonEditNote];
    [buttonEditNote release];
    
    UILabel *labelContent = [self createLabelNo:CGRectMake(10, 40, 280, 70) :[UIColor blackColor] :[UIFont systemFontOfSize:14]];
    labelContent.text = teamInfo.purpose;
    [noteView addSubview:labelContent];
    [labelContent release];
    
    UIButton *buttonDetail = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 90, 20)];
    [buttonDetail setBackgroundImage:[UIImage imageNamed:@"golfTeam_15.png"] forState:UIControlStateNormal];
    [buttonDetail setTitle:@"点击查看详情" forState:UIControlStateNormal];
    [noteView addSubview:buttonDetail];
    buttonDetail.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    [buttonDetail release];
    
    control_y += 140 + 10;
    int buttonWidth = 95;
    UIIconColorButton *buttonMember = [[UIIconColorButton alloc] initWithFrame:CGRectMake(control_x, control_y, buttonWidth, 120) color:[Utility hexStringToColor:@"55A9ED"]];
    buttonMember.labelNum.text = [NSString stringWithFormat:@"%d", teamInfo.count];
    buttonMember.iconView.image = [UIImage imageNamed:@"golfTeam_11-19.png"];
    buttonMember.labelTitle.text = @"队员列表";
    [_scrollView addSubview:buttonMember];
    [buttonMember release];
    
    control_x += buttonWidth+8;
    UIIconColorButton *buttonHistory = [[UIIconColorButton alloc] initWithFrame:CGRectMake(control_x, control_y, buttonWidth, 120) color:[Utility hexStringToColor:@"7A73E8"]];
    buttonHistory.labelNum.hidden = NO;
    buttonHistory.iconView.image = [UIImage imageNamed:@"golfTeam_11-22.png"];
    buttonHistory.labelTitle.text = @"历史成绩";
    [_scrollView addSubview:buttonHistory];
    [buttonHistory release];
    
    control_x += buttonWidth+8;
    UIIconColorButton *buttonChat = [[UIIconColorButton alloc] initWithFrame:CGRectMake(control_x, control_y, buttonWidth, 120) color:[Utility hexStringToColor:@"FC890F"]];
    buttonChat.labelNum.hidden = NO;
    buttonChat.iconView.image = [UIImage imageNamed:@"golfTeam_11-24.png"];
    buttonChat.labelTitle.text = @"球队群聊";
    [_scrollView addSubview:buttonChat];
    [buttonChat release];
    
    control_x = 10;
    control_y += 120 +10;
    UITextButton *buttonManager = [[UITextButton alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 50)];
    [buttonManager resetLabelRect];
    [buttonManager setBackgroundImage:[UIImage imageNamed:@"createTeam_03.png"] forState:UIControlStateNormal];
    buttonManager.label1.text = @"球队申请管理";
    buttonManager.label2.text = [NSString stringWithFormat:@"有%d位球手申请加入", 0];
    [_scrollView addSubview:buttonManager];
    [buttonManager release];
    
    _scrollView.contentSize = CGSizeMake(320, control_y+100);
}

- (void)initSelfInfoView
{
    _headView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 60, 80, 80)];
    _headView.image = [UIImage imageNamed:@"head_default.png"];
    [_scrollView addSubview:_headView];
    [_headView release];
    
    int control_x = 25+80+13;
    int control_y = 92;
    UIFont *fontb15 = [UIFont boldSystemFontOfSize:15];
    UILabel *labelLeader = [self createLabelNo:CGRectMake(control_x, control_y, 40, 15) :[UIColor whiteColor] :fontb15];
    labelLeader.text = @"领队";
    [_scrollView addSubview:labelLeader];
    [labelLeader release];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(control_x+40, control_y, 1, 15)];
    lineView.image = [UIImage imageNamed:@"golfTeam_06 (2).jpg"];
    [_scrollView addSubview:lineView];
    [lineView release];
    
    UILabel *labelName = [self createLabelNo:CGRectMake(control_x+50, control_y, 100, 15) :[UIColor whiteColor] :fontb15];
    labelName.text = teamInfo.name;
    [_scrollView addSubview:labelName];
    [labelName release];
    
    control_y = 117;
    UILabel *labelPhone = [self createLabelNo:CGRectMake(control_x, control_y, 40, 15) :[Utility hexStringToColor:@"4B7617"] :fontb15];
    labelPhone.text = @"电话";
    [_scrollView addSubview:labelPhone];
    [labelPhone release];
    
    UIImageView *lineView2 = [[UIImageView alloc] initWithFrame:CGRectMake(control_x+40, control_y, 1, 15)];
    lineView2.image = [UIImage imageNamed:@"golfTeam_06 (2).jpg"];
    [_scrollView addSubview:lineView2];
    [lineView2 release];
    
    UILabel *labelMobile = [self createLabelNo:CGRectMake(control_x+50, control_y, 100, 15) :[Utility hexStringToColor:@"4B7617"] :fontb15];
    labelMobile.text = teamInfo.phone;
    [_scrollView addSubview:labelMobile];
    [labelMobile release];
}

- (UILabel*)createLabelNo:(CGRect)frame :(UIColor*)textColor :(UIFont*)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = font;
    return label;
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
