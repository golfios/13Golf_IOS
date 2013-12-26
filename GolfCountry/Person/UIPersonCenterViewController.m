//
//  UIPersonCenterViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-7.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIPersonCenterViewController.h"
#import "GolfPersonInfo.h"
#import "UITextButton.h"
#import "UIIconTextButton.h"
#import "UIIntroduceButton.h"

#define KGolfButtonHeight   41

#define KTagMyGolfTeam      1001
#define KTagMyGolfMeet      1002
#define KTagMyGolfPlay      1003
#define KTagIntroduce       1004
#define KTagModifyPwd       1005
#define KTagMsgSetting      1006
#define KTagClearCache      1007
#define KTagAboutUs         1008
#define KTagFeedback        1009

@interface UIPersonCenterViewController ()
{
    UICommonView    *_comView;
    UIScrollView    *_scrollView;
    UIView          *_numberView;
    
    UIButton        *_headButton;
    UILabel         *_nameLabel;
    UILabel         *_genderLabel;
    UIImageView     *_genderIcon;
    UILabel         *_golfAge;
    UILabel         *_golfChadian;
}

@end

@implementation UIPersonCenterViewController

- (void)dealloc
{
    [_comView release];
    [_scrollView release];
    
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
    [_comView setTitleText:@"个人中心"];
    [_comView.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [_comView.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.view = _comView;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, rect.size.height)];
    _scrollView.backgroundColor = RGBA(38, 38, 38, 1.0f);
    [self.view addSubview:_scrollView];
    
    UIImageView *topBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    topBg.image = [UIImage imageNamed:@"person_02.jpg"];
    [_scrollView addSubview:topBg];
    [topBg release];
    
    [self initSelfInfoView];
    [self initNumberView];
    [self initMyGolfView];
}

- (void)initSelfInfoView
{
    GolfPersonInfo *personInfo = [GolfPersonInfo defaultPersonInfo];
    
    _headButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 60, 80, 80)];
    [_headButton setBackgroundImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
    [_scrollView addSubview:_headButton];
    [_headButton release];
    
    int control_x = 25+80+13;
    int control_y = 67;
    _nameLabel = [self createLabel:CGRectMake(control_x, control_y, 100, 20) :[UIColor whiteColor] :[UIFont boldSystemFontOfSize:17]];
    _nameLabel.text = personInfo.userName;
    
    _genderLabel = [self createLabel:CGRectMake(control_x+100, control_y, 16, 16) :[UIColor whiteColor] :[UIFont boldSystemFontOfSize:14]];
    if (personInfo.gender == 1) {
        _genderLabel.text = @"男";
    } else if (personInfo.gender == 0) {
        _genderLabel.text = @"女";
    }
//    _genderIcon = [[UIImageView alloc] initWithFrame:CGRectMake(control_x+100, control_y, 16, 16)];
//    [_scrollView addSubview:_genderIcon];
//    [_genderIcon release];
    
    control_y = 90+7;
    _golfAge = [self createLabel:CGRectMake(control_x, control_y, 100, 20) :RGBA(130, 210, 41, 1.0f) :[UIFont boldSystemFontOfSize:14]];
    _golfAge.text = [NSString stringWithFormat:@"球龄：%d年", personInfo.playAge];
    
    control_y += 20;
    _golfChadian = [self createLabel:CGRectMake(control_x, control_y, 100, 20) :[UIColor whiteColor] :[UIFont boldSystemFontOfSize:14]];
    _golfChadian.text = [NSString stringWithFormat:@"差点：%.1f", personInfo.handicap];
}

- (void)initNumberView
{
    GolfPersonInfo *personInfo = [GolfPersonInfo defaultPersonInfo];
    
    int control_x = 25;
    int control_y = _headButton.frame.origin.y + _headButton.frame.size.height + 17;
    _numberView = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, 270, 40)];
    [_scrollView addSubview:_numberView];
    [_numberView release];
    
    UIImageView *numberBg = [[UIImageView alloc] initWithFrame:_numberView.bounds];
    numberBg.image = [UIImage imageNamed:@"person_15.png"];
    [_numberView addSubview:numberBg];
    [numberBg release];
    
    UITextButton *fansButton = [[UITextButton alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    [fansButton setButtonTexts:personInfo.fansCount :@"粉丝"];
    [_numberView addSubview:fansButton];
    [fansButton release];
    
    UITextButton *followButton = [[UITextButton alloc] initWithFrame:CGRectMake(90, 0, 90, 40)];
    [followButton setButtonTexts:personInfo.followCount :@"关注"];
    [_numberView addSubview:followButton];
    [followButton release];
    
    UITextButton *friendButton = [[UITextButton alloc] initWithFrame:CGRectMake(180, 0, 90, 40)];
    [friendButton setButtonTexts:personInfo.friendCount :@"好友"];
    [_numberView addSubview:friendButton];
    [friendButton release];
}

- (void)initMyGolfView
{
    int control_x = 0;
    int control_y = _numberView.frame.origin.y + _numberView.frame.size.height + 17;
    UIIconTextButton *myTeamBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_19.png" :@"我的球队"];
    myTeamBtn.tag = KTagMyGolfTeam;
    [_scrollView addSubview:myTeamBtn];
    
    control_y += KGolfButtonHeight+1;
    UIIconTextButton *myMeetBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-25.png" :@"我的球会"];
    myMeetBtn.tag = KTagMyGolfMeet;
    [_scrollView addSubview:myMeetBtn];
    
    control_y += KGolfButtonHeight+1;
    UIIconTextButton *mygameBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-27.png" :@"我的比赛"];
    mygameBtn.tag = KTagMyGolfPlay;
    [_scrollView addSubview:mygameBtn];
    
    control_y += KGolfButtonHeight+15;
    UIIntroduceButton *intrBtn = [[UIIntroduceButton alloc] initWithFrame:CGRectMake(control_x, control_y, 320, 70)];
    intrBtn.tag = KTagIntroduce;
    intrBtn.icon.image = [UIImage imageNamed:@"person_22-29.png"];
    intrBtn.title.text = @"个人简介";
    NSString *desText = [GolfPersonInfo defaultPersonInfo].description;
    if (desText == nil) {
        desText = @"胜利是我的代名词！";
    }
    intrBtn.des.text = @"胜利是我的代名词！";
    [_scrollView addSubview:intrBtn];
    [intrBtn release];
    
    control_x = 75;
    control_y += 70+15;
    UILabel *settingLabel = [UICommonView createLabel:CGRectMake(control_x, control_y, 80, 20) :[Utility hexStringToColor:@"878787"] :[UIFont systemFontOfSize:16]];
    settingLabel.text = @"系统设置";
    [_scrollView addSubview:settingLabel];
    
    control_x = 0;
    control_y += 20;
    UIIconTextButton *modifyPwdBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-31.png" :@"修改密码"];
    modifyPwdBtn.tag = KTagModifyPwd;
    [_scrollView addSubview:modifyPwdBtn];
    
    control_y += KGolfButtonHeight+1;
    UIIconTextButton *msgSettingBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-33.png" :@"消息设置"];
    msgSettingBtn.tag = KTagMsgSetting;
    [_scrollView addSubview:msgSettingBtn];
    
    control_y += KGolfButtonHeight+1;
    UIIconTextButton *clearCacheBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-35.png" :@"清除缓存"];
    clearCacheBtn.tag = KTagClearCache;
    [_scrollView addSubview:clearCacheBtn];
    
    control_y += KGolfButtonHeight+15;
    UIIconTextButton *aboutBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-37.png" :@"关于我们"];
    aboutBtn.tag = KTagAboutUs;
    [_scrollView addSubview:aboutBtn];
    
    control_y += KGolfButtonHeight+1;
    UIIconTextButton *feedbackBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-39.png" :@"意见反馈"];
    feedbackBtn.tag = KTagFeedback;
    [_scrollView addSubview:feedbackBtn];
    
    control_x = 10;
    control_y += KGolfButtonHeight+20;
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 40)];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"person_logout.png"] forState:UIControlStateNormal];
    [_scrollView addSubview:logoutButton];
    [logoutButton release];
    
    _scrollView.contentSize = CGSizeMake(320, control_y+100);
}

- (UIIconTextButton*)createIconBtn:(CGRect)frame :(NSString*)image :(NSString*)title
{
    UIIconTextButton *iconButton = [[UIIconTextButton alloc] initWithFrame:frame];
    iconButton.icon.image = [UIImage imageNamed:image];
    iconButton.titleLabel.text = title;
    return [iconButton autorelease];
}

- (UILabel*)createLabel:(CGRect)frame :(UIColor*)textColor :(UIFont*)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = font;
    [_scrollView addSubview:label];
    
    return [label autorelease];
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
