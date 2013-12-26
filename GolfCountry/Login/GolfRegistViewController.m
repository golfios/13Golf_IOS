//
//  GolfRegistViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "GolfRegistViewController.h"
#import "UICommonView.h"
#import "UITextEditView.h"
#import "RegisterModel.h"
#import "IPAddress.h"
#import <AdSupport/ASIdentifierManager.h>

#define KTagRegistButton     1001

@interface GolfRegistViewController ()
{
    UICommonView *_comView;
    RegisterModel *_model;
}

@end

@implementation GolfRegistViewController

@synthesize noticeLabel = _noticeLabel;
@synthesize accTextField = _accTextField;
@synthesize pwdTextField = _pwdTextField;
@synthesize confirmTextField = _confirmTextField;
@synthesize nicknameTextField = _nicknameTextField;
@synthesize identityTextField = _identityTextField;
@synthesize registType = _registType;
@synthesize delegate;

- (void)dealloc
{
    [_comView release];
    [_noticeLabel release];
    [_accTextField release];
    [_pwdTextField release];
    [_confirmTextField release];
    [_nicknameTextField release];
    [_identityTextField release];
    [_model release];
    
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
    [_comView setTitleText:@"注册"];
    _comView.rightButton.hidden = YES;
    self.view = _comView;
    
    [_comView setBackgroundImage:[UIImage imageNamed:@"login_bg.jpg"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int bg_y = 15 + [UICommonView getNavHeight];
    _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bg_y, 320, 20)];
    _noticeLabel.backgroundColor = [UIColor clearColor];
    _noticeLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    _noticeLabel.textColor  = [Utility hexStringToColor:@"eb2c2c"];
    _noticeLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:_noticeLabel];
    
    int bg_x = 20;
    bg_y += 20;
    int textWid = 320-bg_x*2;
    UIImageView *textBg = [[UIImageView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 180)];
    textBg.image = [UIImage imageNamed:@"regist_bg.png"];
    [self.view addSubview:textBg];
    [textBg release];
    
    UITextEditView *accountView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
    self.accTextField = accountView.textField;
    [accountView setKeyBoard];
    accountView.title.text = @"手机号码";
    accountView.maxInputCount = 11;
    [accountView setPlaceHold:@"请输入您的手机号码"];
    [self.view addSubview:accountView];
    [accountView release];
    
    bg_y += 45;
    UITextEditView *passwordView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
    self.pwdTextField = passwordView.textField;
    self.pwdTextField.secureTextEntry = YES;
    passwordView.title.text = @"账号密码";
    [passwordView setPlaceHold:@"最少六个字符"];
    [self.view addSubview:passwordView];
    [passwordView release];
    
    bg_y += 45;
    UITextEditView *confirmView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
    self.confirmTextField = confirmView.textField;
    self.confirmTextField.secureTextEntry = YES;
    confirmView.title.text = @"确认密码";
//    [confirmView setPlaceHold:@"最少六个字符"];
    [self.view addSubview:confirmView];
    [confirmView release];

    bg_y += 45;
    UITextEditView *nicknameView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
    self.nicknameTextField = nicknameView.textField;
    if (_registType == 1) {
        nicknameView.title.text = @"真实姓名";
    }
    else {
        nicknameView.title.text = @"昵称";
    }
//    [nicknameView setPlaceHold:@"最少六个字符"];
    [self.view addSubview:nicknameView];
    [nicknameView release];
    
    if (_registType == 1) {
        bg_y += 45;
        UITextEditView *identityView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
        self.identityTextField = identityView.textField;
        identityView.title.text = @"身份证";
        [self.view addSubview:identityView];
        [identityView release];
    }

    bg_y += 45+18;
    UIButton *registButton = [[UIButton alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 56)];
    registButton.tag = KTagRegistButton;
    [registButton setBackgroundImage:[UIImage imageNamed:@"regist.png"] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    [registButton release];
}

- (void)buttonClicked:(id)sender
{
    NSString *telRegex = @"(^[1][3][0-9]{9}$)|(^[1][5][0-9]{9}$)|(^[1][8][0-9]{9}$)|(^[0][1-9]{1}[0-9]{9}$)|(^[1][4][0-9]{9}$)";
    
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    
    NSString *accText = _accTextField.text;
    NSString *pwdText = _pwdTextField.text;
    NSString *conText = _confirmTextField.text;
    NSString *nicText = _nicknameTextField.text;
    NSString *identity = _identityTextField.text;
    
    if ([accText isEqualToString:@""]) {
        [_comView showAlertMessage:@"请输入您的手机号!"];
        return;
    } else if ([pwdText isEqualToString:@""]) {
        [_comView showAlertMessage:@"请输入您的密码"];
        return;
    } else if ([conText isEqualToString:@""]) {
        [_comView showAlertMessage:@"请输入确认密码"];
        return;
    } else if ([nicText isEqualToString:@""]) {
        if (_registType == 1) {
            [_comView showAlertMessage:@"请输入您的真实姓名"];
        } else {
            [_comView showAlertMessage:@"请输入您的昵称"];
        }
        return;
    } else if (_registType==1 && [identity isEqualToString:@""]) {
        [_comView showAlertMessage:@"请输入您的身份证号"];
        return;
    }
    
    if (![telTest evaluateWithObject:accText]) {
        [_comView showAlertMessage:@"您的手机号输入不正确!"];
        return;
    } else if (pwdText.length < 6) {
        [_comView showAlertMessage:@"密码必须大于等于六位!"];
        return;
    } else if (![pwdText isEqualToString:conText]) {
        [_comView showAlertMessage:@"密码与确认密码不相同"];
        return;
    }
    
    if (_model == nil) {
        _model = [[RegisterModel alloc] init];
        _model.delegate = self;
        [_model setDidFinishSelector:@selector(requestFinish:)];
        [_model setDidFailedSelector:@selector(requestFailed:)];
    }
    RegisterStruct *rStruct = [[RegisterStruct alloc] init];
    rStruct.phone = accText;
    rStruct.userName = nicText;
    rStruct.pwd = pwdText;
    //在iOS6之后，苹果禁用了禁用了UIDevice的uniqueIdentifier方法，所以获取设备唯一标识的方法采用了获取Mac地址然后MD5加密，但是，在iOS7中发现，该方法统一返回02:00:00:00:00:00,所以用做设备的标识符已经没有意义。经过调研、查阅资料和各种方案对比分析，采用了ADID
    NSString *adId = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    rStruct.device = adId;
//    rStruct.device = [IPAddress getMacAddress];
    if (_registType == 1) {
        rStruct.realName = nicText;
        rStruct.sfzId = identity;
    }
    [_model requestRegister:rStruct];
    [_comView showProgessHUD:@"正在注册，请稍候..."];
}

- (void)requestFinish:(NSDictionary *)dictionary
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        if ([msg length] <= 0) {
            msg = @"注册成功！";
        }
        [_comView showAlertMessage:msg delegate:self];
    }
    else {
        if ([msg length] <= 0) {
            msg = @"注册失败！";
        }
        [_comView showAlertMessage:msg];
    }
}

- (void)requestFailed:(NSDictionary *)dictionary
{
    [_comView hideProgessHUD];
    
    NSString *retText = [dictionary objectForKey:@"retText"];
    [_comView showAlertMessage:retText];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [delegate RegistSuccessful];
    [[AppDelegate shareAppDelegate].navigation popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    if(_username.textField == textField)
    //    {
    //        [_scrollView setContentOffset:CGPointMake(0, _password.textField.tag) animated:YES];
    //        [_password.textField becomeFirstResponder];
    //    }
    //    else
    //    {
    //        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //        [textField resignFirstResponder];
    //    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    [_scrollView setContentOffset:CGPointMake(0, textField.tag) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
}

@end
