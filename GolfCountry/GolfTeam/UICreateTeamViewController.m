//
//  UICreateTeamViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-16.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UICreateTeamViewController.h"
#import "UICommonView.h"
#import "UITipTextButton.h"
#import "CPDatePicker.h"
#import "CPDatePickerView.h"
#import "GolfTeamModel.h"

#define KTagTeamName        1001
#define KTagTeamCity        1002
#define KTagCreateDate      1003
#define KTagTeamPurpose     1004
#define KTagTeamIntro       1005
#define KTagTeamLeader      1006
#define KTagContactPhone    1007

#define KButtonWidth        300
#define KButtonHeight       40

@interface UICreateTeamViewController ()
{
    UICommonView    *_comView;
    UIScrollView    *_scrollView;

    UIButton        *_logoButton;
    
    UITipTextButton *_teamNameBtn;
    UITipTextButton *_teamCityBtn;
    UITipTextButton *_createDateBtn;
    UITipTextButton *_teamPurposeBtn;
    UITipTextButton *_teamIntroBtn;
    UITipTextButton *_teamLeaderBtn;
    UITipTextButton *_contactPhoneBtn;
    
    NSInteger       selectedTag;
    
    GolfTeamModel   *_teamModel;
}

@end

@implementation UICreateTeamViewController

- (void)dealloc
{
    [_comView release];
    [_scrollView release];
    
    [_logoButton release];
    [_teamNameBtn release];
    [_teamCityBtn release];
    [_createDateBtn release];
    [_teamPurposeBtn release];
    [_teamIntroBtn release];
    [_teamLeaderBtn release];
    [_contactPhoneBtn release];
    
    [_teamModel release];
    
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
    _comView = [[UICommonView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [_comView setBackgroundImage:nil];
    _comView.backgroundColor = [Utility hexStringToColor:@"EBEFEB"];
    [_comView setTitleText:@"创建球队"];
    [_comView setRightText:@"完成"];
    [_comView.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view = _comView;
    
    CGRect frame = self.view.bounds;
    frame.origin.y += [UICommonView getNavHeight];
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:_scrollView];
    
    int control_x = 10;
    int control_y = 15;
    UIImageView *viewBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 100)];
    viewBg1.image = [UIImage imageNamed:@"createTeam_01.png"];
    [_scrollView addSubview:viewBg1];
    [viewBg1 release];
    
    UILabel *logoLabel = [UICommonView createLabel:CGRectMake(control_x+10, control_y+10, 100, 20) :[UIColor grayColor] :[UIFont systemFontOfSize:MidFontSize]];
    logoLabel.text = @"球队头像";
    [_scrollView addSubview:logoLabel];
    
    _logoButton = [[UIButton alloc] initWithFrame:CGRectMake(200, control_y+10, 80, 80)];
    [_logoButton setBackgroundImage:[UIImage imageNamed:@"createTeam_+.png"] forState:UIControlStateNormal];
    [_logoButton addTarget:self action:@selector(logoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_logoButton];
    
    control_y += 100 +15;
    UIImageView *viewBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 200)];
    viewBg2.image = [UIImage imageNamed:@"teamInfo_06.png"];
    [_scrollView addSubview:viewBg2];
    [viewBg2 release];
    
    _teamNameBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _teamNameBtn.tag = KTagTeamName;
    _teamNameBtn.tipLable.text = @"球队名称";
    _teamNameBtn.titleLabel.text = @"为球队起个好听的名字吧！";
    [_teamNameBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_teamNameBtn];
    
    control_y += KButtonHeight;
    _teamCityBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _teamCityBtn.tag = KTagTeamCity;
    _teamCityBtn.tipLable.text = @"所属地区";
    _teamCityBtn.titleLabel.text = @"点击选择城市";
    [_teamCityBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_teamCityBtn];
    
    control_y += KButtonHeight;
    _createDateBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _createDateBtn.tag = KTagCreateDate;
    _createDateBtn.tipLable.text = @"成立日期";
    [_createDateBtn showTextFieldDate];
    [_createDateBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_createDateBtn];
    
    control_y += KButtonHeight;
    _teamPurposeBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _teamPurposeBtn.tag = KTagTeamPurpose;
    _teamPurposeBtn.tipLable.text = @"球队宗旨";
    _teamPurposeBtn.titleLabel.text = @"点击编写";
    [_teamPurposeBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_teamPurposeBtn];
    
    control_y += KButtonHeight;
    _teamIntroBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _teamIntroBtn.tag = KTagTeamIntro;
    _teamIntroBtn.tipLable.text = @"球队简介";
    _teamIntroBtn.titleLabel.text = @"点击编写";
    [_teamIntroBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_teamIntroBtn];
    
    control_y += KButtonHeight + 15;
    UIImageView *viewBg3 = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, 300, 80)];
    viewBg3.image = [UIImage imageNamed:@"createTeam_02.png"];
    [_scrollView addSubview:viewBg3];
    [viewBg3 release];
    
    _teamLeaderBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _teamLeaderBtn.tag = KTagTeamLeader;
    _teamLeaderBtn.tipLable.text = @"球队领队";
    _teamLeaderBtn.titleLabel.text = @"球队领队姓名";
    [_teamLeaderBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_teamLeaderBtn];
    
    control_y += KButtonHeight;
    _contactPhoneBtn = [[UITipTextButton alloc] initWithFrame:CGRectMake(control_x, control_y, KButtonWidth, KButtonHeight)];
    _contactPhoneBtn.tag = KTagContactPhone;
    _contactPhoneBtn.tipLable.text = @"联系电话";
    _contactPhoneBtn.titleLabel.text = @"请输入电话";
    [_contactPhoneBtn addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_contactPhoneBtn];
    
    _scrollView.contentSize = CGSizeMake(320, control_y+100);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _teamModel = [[GolfTeamModel alloc] init];
    _teamModel.delegate = self;
    [_teamModel setDidFinishSelector:@selector(requestFinish::)];
    [_teamModel setDidFailedSelector:@selector(requestFailed::)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFinish:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        if ([method isEqualToString:KTeamUploadLogo]) {
            [_comView showAlertMessage:msg];
        }
        else if ([method isEqualToString:KMethodCreateTeam]) {
            [_comView showAlertMessage:msg];
        }
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

#pragma mark - button delegate

- (void)rightButtonClicked:(id)sender
{
    createTeamStruct *ctStruct = [[createTeamStruct alloc] init];
    ctStruct.teamName = _teamNameBtn.titleLabel.text;
    ctStruct.city = _teamCityBtn.titleLabel.text;
    ctStruct.logoUrl = @"http://img.jpg";
    ctStruct.contacts = _teamLeaderBtn.titleLabel.text;
    ctStruct.phone = _contactPhoneBtn.titleLabel.text;
    ctStruct.purpose = _teamPurposeBtn.titleLabel.text;
    ctStruct.description = _teamIntroBtn.titleLabel.text;
    ctStruct.createdDate = _createDateBtn.textField.text;
    
//    NSDate *today = [NSDate date];
//    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
//    [nsdf setDateFormat:@"yyyy-MM-dd"];
//    ctStruct.createdDate = [nsdf stringFromDate:today];
//    [nsdf release];
    
    [_teamModel requestCreateTeam:ctStruct];
    [_comView showProgessHUD:@"正在创建球队，请稍候..."];
}

- (void)logoButtonClicked:(id)sender
{
    UIChooseImgViewController *controller = [[UIChooseImgViewController alloc] init];
    controller.delegate = self;
    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
    [controller release];
}

- (void)tipButtonClicked:(id)sender
{
    UITipTextButton *button = sender;
    NSInteger tag = button.tag;
    selectedTag = tag;
    switch (tag) {
        case KTagTeamName:
        {
            UIEditViewController *controller = [[UIEditViewController alloc] init];
            controller.delegate = self;
            controller.title = @"球队名称";
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagTeamCity:
        {
            UICitySelectController *controller = [[UICitySelectController alloc] init];
            controller.delegate = self;
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagCreateDate:
        {
            //日期选择框
//            [self performSelector:@selector(scrollBack:) withObject:button];
            CPDatePickerView *datepv = [[[CPDatePickerView alloc] init] autorelease];
            NSDateFormatter *nsdf = [[[NSDateFormatter alloc] init] autorelease];
            [nsdf setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [button.textField.text isEqualToString:@""] ? [NSDate date] : [nsdf dateFromString:button.textField.text];
            [datepv initComponent:date activedField:button.textField delegate:self didFinishSelect:@selector(didFinishSelect:dictionary:)];
            [datepv setMinAndMaxDate:[NSDate date] maxDate:nil];
            [self.view addSubview:datepv];
        }
            break;
        case KTagTeamPurpose:
        {
            UIEditViewController *controller = [[UIEditViewController alloc] init];
            controller.delegate = self;
            controller.title = @"球队宗旨";
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagTeamIntro:
        {
            UIEditViewController *controller = [[UIEditViewController alloc] init];
            controller.delegate = self;
            controller.title = @"球队简介";
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagTeamLeader:
        {
            UIEditViewController *controller = [[UIEditViewController alloc] init];
            controller.delegate = self;
            controller.title = @"球队领队";
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagContactPhone:
        {
            UIEditViewController *controller = [[UIEditViewController alloc] init];
            controller.delegate = self;
            controller.title = @"联系电话";
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
            
        default:
            break;
    }
}

- (void)finishEditView:(UITextView *)textView
{
    UITipTextButton *tipBtn = (UITipTextButton*)[_scrollView viewWithTag:selectedTag];
    tipBtn.titleLabel.text = textView.text;
    tipBtn.titleLabel.textColor = [UIColor blackColor];
}

- (BOOL)citySelectController:(UICitySelectController *)citySelectController selectCity:(CityInfo *)selectedCityInfo
{
    UITipTextButton *tipBtn = (UITipTextButton*)[_scrollView viewWithTag:selectedTag];
    tipBtn.titleLabel.text = selectedCityInfo.strCityNameCN;
    tipBtn.titleLabel.textColor = [UIColor blackColor];
    return YES;
}

- (void)chooseImageFinish:(UIImage *)image byPath:(NSString *)imagePath
{
    [_logoButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [_teamModel requestUploadTeamLogo:imagePath];
}

// pickerView 选择完成后,回调
- (void)didFinishSelect:(UITextField *)textField dictionary:(NSDictionary *)dic
{
//    [self performSelector:@selector(scrollBack:) withObject:textField];
//    if (textField == self.cityField) {
//        self.citySelectedDic = dic;
//        [self handleLicNo];
//    }
}

- (void)scrollBack:(UIButton *)button
{
    CGRect frame = button.frame;
    float keyboardHeight = 250.0; // 英文键盘高216，中文键盘要再高一些。
    int offset = frame.origin.y + 32 - (_scrollView.frame.size.height - keyboardHeight);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(offset > 0)
    {
        _scrollView.contentOffset = CGPointMake(0, offset);
    }
    [UIView commitAnimations];
}

@end
