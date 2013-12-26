//
//  UIGolfPersonInfoViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-15.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfPersonInfoViewController.h"
#import "UICommonView.h"
#import "UITextButton.h"
#import "UIIconTextButton.h"
#import "UIIntroduceButton.h"
#import "GolfPlayerModel.h"

#define KGolfButtonHeight   41

#define KTagMyGolfTeam      1001
#define KTagMyGolfMeet      1002
#define KTagIntroduce       1003
#define KTagFollow          1004
#define KTagChating         1005

@interface UIGolfPersonInfoViewController ()
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
    UIButton        *_followButton;
    
    GolfPlayerModel *_playerModel;
}

@end

@implementation UIGolfPersonInfoViewController

@synthesize personInfo;

- (void)dealloc
{
    [_comView release];
    [_scrollView release];
    [_playerModel release];
    [_followButton release];
    
    self.personInfo = nil;
    
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
    [_comView setTitleText:@"球手信息"];
    _comView.rightButton.hidden = YES;
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
    UIIconTextButton *myTeamBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_19.png" :@"TA的球队"];
    myTeamBtn.tag = KTagMyGolfTeam;
    [myTeamBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:myTeamBtn];
    
    control_y += KGolfButtonHeight+1;
    UIIconTextButton *myMeetBtn = [self createIconBtn:CGRectMake(control_x, control_y, 320, KGolfButtonHeight) :@"person_22-25.png" :@"TA的球会"];
    myMeetBtn.tag = KTagMyGolfMeet;
    [myMeetBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:myMeetBtn];
    
    control_y += KGolfButtonHeight+15;
    UIIntroduceButton *intrBtn = [[UIIntroduceButton alloc] initWithFrame:CGRectMake(control_x, control_y, 320, 70)];
    intrBtn.tag = KTagIntroduce;
    intrBtn.icon.image = [UIImage imageNamed:@"person_22-29.png"];
    intrBtn.title.text = @"个人简介";
    NSString *desText = personInfo.description;
    if (desText == nil) {
        desText = @"胜利是我的代名词！";
    }
    intrBtn.des.text = @"胜利是我的代名词！";
    [_scrollView addSubview:intrBtn];
    [intrBtn release];
    
    int btnWidth = 130;
    int btnHeight = 35;
    control_x = (320 - btnWidth*2) / 3;
    control_y += 70+20;
    _followButton = [[UIButton alloc] initWithFrame:CGRectMake(control_x, control_y, btnWidth, btnHeight)];
    [self setFollowBtnText:self.personInfo.isFollowed];
    [_followButton setBackgroundImage:[UIImage imageNamed:@"member_06.png"] forState:UIControlStateNormal];
    _followButton.tag = KTagFollow;
    [_followButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_followButton];
    
    control_x += control_x + btnWidth;
    UIButton *chatButton = [[UIButton alloc] initWithFrame:CGRectMake(control_x, control_y, btnWidth, btnHeight)];
    [chatButton setTitle:@"聊天" forState:UIControlStateNormal];
    [chatButton setBackgroundImage:[UIImage imageNamed:@"member_08.png"] forState:UIControlStateNormal];
    chatButton.tag = KTagChating;
    [chatButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:chatButton];
    [chatButton release];
    
    _scrollView.contentSize = CGSizeMake(320, control_y+100);
}

- (void)setFollowBtnText:(BOOL)isFollowed
{
    if (isFollowed) {
        [_followButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    else {
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    }
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

#pragma mark - button delegate

- (void)buttonClicked:(id)sender
{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    switch (tag) {
        case KTagMyGolfTeam:
            
            break;
        case KTagMyGolfMeet:
            break;
        case KTagFollow:
        {
            [self requestPlayerFollowed:self.personInfo.isFollowed];
        }
            break;
        case KTagChating:
            break;
            
        default:
            break;
    }
}

- (void)requestPlayerFollowed:(BOOL)isFollowed
{
    if (_playerModel == nil) {
        _playerModel = [[GolfPlayerModel alloc] init];
        _playerModel.delegate = self;
        [_playerModel setDidFinishSelector:@selector(requestFinish::)];
        [_playerModel setDidFailedSelector:@selector(requestFailed::)];
    }
    NSInteger userId = personInfo.userId;
    if (isFollowed) {
        [_playerModel requestCancelFollow:userId];
        [_comView showProgessHUD:@"正在取消关注该球手，请稍候..."];
    }
    else {
        [_playerModel requestFollowUser:userId];
        [_comView showProgessHUD:@"正在关注该球手，请稍候..."];
    }
}

- (void)requestFinish:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        if ([method isEqualToString:KMethodFollow]) {
            self.personInfo.isFollowed = YES;
            [self setFollowBtnText:YES];
        }
        else if ([method isEqualToString:KMethodUnFollow]) {
            self.personInfo.isFollowed = NO;
            [self setFollowBtnText:NO];
        }
        [_comView showAlertMessage:msg];
    }
    else {
        [_comView showAlertMessage:msg];
    }
}

- (void)requestFailed:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    NSString *msg = [dictionary objectForKey:@"retText"];
    [_comView showAlertMessage:msg];
}

@end
