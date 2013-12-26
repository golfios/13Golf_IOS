//
//  GolfLoginViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "GolfLoginViewController.h"
#import "UICommonView.h"
#import "UITextEditView.h"
#import "GolfRegistViewController.h"
#import "LoginModel.h"

#define KTagLoginButton         1001
#define KTagRegisterRealBtn     1002
#define KTagRegisterBtn         1003
#define KTagFindPwdBtn          1004

@interface GolfLoginViewController ()
{
    UICommonView *_comView;
}

@end

@implementation GolfLoginViewController

@synthesize noticeLabel = _noticeLabel;
@synthesize accTextField = _accTextField;
@synthesize pwdTextField = _pwdTextField;
@synthesize delegate;

- (void)dealloc
{
    [_comView release];
    [_noticeLabel release];
    [_accTextField release];
    [_pwdTextField release];
    
    [_loginModel release];
    
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
    [_comView setTitleText:@"登录"];
    [_comView setRightText:@"找回密码"];
    self.view = _comView;
    
    [_comView setBackgroundImage:[UIImage imageNamed:@"login_bg.jpg"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int bg_y = 15 + [UICommonView getNavHeight];
    _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 20)];
    _noticeLabel.backgroundColor = [UIColor clearColor];
    _noticeLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    _noticeLabel.textColor  = [Utility hexStringToColor:@"eb2c2c"];
    _noticeLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:_noticeLabel];
    
    int bg_x = 20;
    bg_y += 20;
    int textWid = 320-bg_x*2;
    UIImageView *textBg = [[UIImageView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 90)];
    textBg.image = [UIImage imageNamed:@"login_text__bg.png"];
    [self.view addSubview:textBg];
    [textBg release];
    
    UITextEditView *accountView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
    [accountView resetControlFrame];
    accountView.noteIcon.hidden = YES;
    self.accTextField = accountView.textField;
    [self.accTextField setKeyboardType:UIKeyboardTypePhonePad];
    [accountView setKeyBoard];
    accountView.title.text = @"账号";
    accountView.maxInputCount = 11;
    [accountView setPlaceHold:@"请输入您的手机号码"];
    [self.view addSubview:accountView];
    [accountView release];
    
    bg_y += 45;
    UITextEditView *passwordView = [[UITextEditView alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 45)];
    [passwordView resetControlFrame];
    passwordView.noteIcon.hidden = YES;
    self.pwdTextField = passwordView.textField;
    self.pwdTextField.secureTextEntry = YES;
    passwordView.title.text = @"密码";
    [passwordView setPlaceHold:@"请输入密码"];
    [self.view addSubview:passwordView];
    [passwordView release];
    
    bg_y += 45+18;
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid, 56)];
    loginButton.tag = KTagLoginButton;
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_button.png"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton release];
    
    bg_y += 56+20;
    UIButton *realButton = [[UIButton alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid/2, 42)];
    realButton.tag = KTagRegisterRealBtn;
    [realButton setBackgroundImage:[UIImage imageNamed:@"login_left.png"] forState:UIControlStateNormal];
    [realButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:realButton];
    [realButton release];
    
    bg_x += textWid/2;
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(bg_x, bg_y, textWid/2, 42)];
    registerButton.tag = KTagRegisterBtn;
    [registerButton setBackgroundImage:[UIImage imageNamed:@"forget_right.png"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton release];
    
    bg_x = 20;
    bg_y += 55;
    UILabel *label1 = [UICommonView createLabel:CGRectMake(bg_x, bg_y, textWid, 15) :[UIColor whiteColor] :[UIFont systemFontOfSize:SmallFontSize]];
    label1.textAlignment = UITextAlignmentCenter;
    label1.text = @"温馨提示：推荐使用实名注册哦！";
    [self.view addSubview:label1];
    
    bg_y += 15;
    UILabel *label2 = [UICommonView createLabel:CGRectMake(bg_x, bg_y, textWid, 15) :[UIColor whiteColor] :[UIFont systemFontOfSize:SmallFontSize]];
    label2.textAlignment = UITextAlignmentCenter;
    label2.text = @"可以享受到所有功能！";
    [self.view addSubview:label2];
}

- (void)buttonClicked:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSInteger tag = button.tag;
    switch (tag) {
        case KTagLoginButton:
        {
            [self loginGolf];
        }
            break;
        case KTagRegisterRealBtn:
        {
            GolfRegistViewController *controller = [[GolfRegistViewController alloc] initWithNibName:@"GolfRegistViewController" bundle:nil];
            controller.registType = 1;
            controller.delegate = self;
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagRegisterBtn:
        {
            GolfRegistViewController *controller = [[GolfRegistViewController alloc] initWithNibName:@"GolfRegistViewController" bundle:nil];
            controller.registType = 0;
            controller.delegate = self;
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case KTagFindPwdBtn:
            break;
            
        default:
            break;
    }
}

- (void)loginGolf
{
    NSString *account = _accTextField.text;
    NSString *pwd = _pwdTextField.text;
    if([account length] == 0)
    {
        [_comView showAlertMessage:@"用户名不能为空"];
        return;
    }
    if([pwd length] == 0)
    {
        [_comView showAlertMessage:@"密码不能为空"];
        return;
    }
    if (_loginModel == nil) {
        _loginModel = [[LoginModel alloc] init];
        _loginModel.delegate = self;
        [_loginModel setDidFinishSelector:@selector(requestFinish:)];
        [_loginModel setDidFailedSelector:@selector(requestFailed:)];
    }
    [_loginModel requestLoginByAcc:account pwd:pwd];
    [_comView showProgessHUD:@"正在登录，请稍候..."];
}

- (void)requestFinish:(NSDictionary *)dictionary
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        [NSSystemSetMessage defaultMessage].isLogin = YES; //当前为登录状态
        [_comView showAlertMessage:msg delegate:self];
    }
    else {
        [_comView showAlertMessage:msg];
    }
}

- (void)requestFailed:(NSDictionary *)dictionary
{
    [_comView hideProgessHUD];
    NSString *msg = [dictionary objectForKey:@"retText"];
    [_comView showAlertMessage:msg];
}

- (void)RegistSuccessful
{
    [delegate LoginSuccessful];
    [[AppDelegate shareAppDelegate].navigation popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [delegate LoginSuccessful];
    [[AppDelegate shareAppDelegate].navigation popViewControllerAnimated:YES];
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
