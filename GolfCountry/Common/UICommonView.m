//
//  UICommonView.m
//  GolfCountry
//
//  Created by xijun on 13-11-28.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UICommonView.h"
#import "MBProgressHUD.h"

#define KNavHeight      45

@interface UICommonView()

-(void)initComView;

@property(nonatomic,retain)UIView *topView;

@end

@implementation UICommonView

@synthesize leftButton = _leftButton,rightButton = _rightButton,topTitle = _topTitle;
@synthesize backgroundImage = _backgroundImage;
@synthesize comDeleate, HUD;

@synthesize topView;
@synthesize navBarView = _navBarView;
@synthesize textField = _textField;

+ (NSInteger)getNavHeight
{
    return KNavHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initComView];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [self initComView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initComView];
    }
    return self;
}

-(void)initComView
{
#if ADD_WEBTRENDS
    [JOYWebTrend afterLoginTrends];
#endif
    
    [self setBackgroundColor:RGBA(234, 241, 255, 1.0f)];
    
    CGRect rect = self.frame;
    rect.origin.y = KNavHeight;
    _backgroundImageView = [[UIImageView alloc] init];
    [_backgroundImageView setFrame:rect];
    _backgroundImageView.image = [UIImage imageNamed:@"bg.jpg"];
    [self addSubview:_backgroundImageView];
    
    _navBarView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,KNavHeight)];
    [self addSubview:_navBarView];
    
    UIImageView* navBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"topbar.png"]];
    [navBar setFrame:CGRectMake(0,0,320,KNavHeight)];
    [_navBarView addSubview:navBar];
    [navBar release];
    
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(8,8,56,28)];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"press.png"] forState:UIControlStateNormal];
//    [_leftButton setBackgroundImage:[UIImage imageNamed:@"pressed.png"] forState:UIControlStateHighlighted];
    [_leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(closeController) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(256,8,56,28)];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"press.png"] forState:UIControlStateNormal];
//    [_rightButton setBackgroundImage:[UIImage imageNamed:@"pressed.png"] forState:UIControlStateHighlighted];
    [_rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navBarView addSubview:_rightButton];
    
    _topTitle = [[UILabel alloc] initWithFrame:CGRectMake(80,5,160,35)];
    [_topTitle setBackgroundColor:[UIColor clearColor]];
    _topTitle.textAlignment = UITextAlignmentCenter;
    [_topTitle setTextColor:[UIColor whiteColor]];
    [_topTitle setFont:[UIFont boldSystemFontOfSize:BigFontSize]];
    [_navBarView addSubview:_topTitle];
}

-(void)setBackButtonImage
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 20, 25)];
    imgView.image = [UIImage imageNamed:@"back_arrow.png"];
    [_leftButton addSubview:imgView];
    [imgView release];
}

+(UILabel *)getNoDataLabel:(CGFloat)yLocation
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, yLocation, 320, 38)];
    lbl.text = @"没有相关数据！";
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:25];
    lbl.textAlignment = UITextAlignmentCenter;
    
    return [lbl autorelease];
}

+(UILabel *)createLabel:(CGRect)frame :(UIColor *)textColor :(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = font;
    return [label autorelease];
}

- (void)showAlertMessage:(NSString *)strMessage delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMessage delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void)showAlertMessage:(NSString*)strMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+(void)showAlertMessage:(NSString*)strMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    [_backgroundImageView setImage:backgroundImage];
}

-(void)setTitleText:(NSString*)strTitle
{
    CGSize titleSize = [strTitle sizeWithFont:_topTitle.font constrainedToSize: CGSizeMake(1000,MAXFLOAT)];
    [_topTitle removeFromSuperview];
    
    if(titleSize.width > 165)
    {
        UIView* tempTopView = [[UIView alloc] initWithFrame:CGRectMake(80,5,160,35)];
        [tempTopView setBackgroundColor:[UIColor clearColor]];
        [tempTopView setClipsToBounds:YES];
        [_navBarView addSubview:tempTopView];
        self.topView = tempTopView;
        [tempTopView release];
        
        [_topTitle setFrame:CGRectMake(0, 0, titleSize.width, 35)];
        [_topTitle setText:strTitle];
        [_topTitle setClipsToBounds:NO];
        [self.topView addSubview:_topTitle];
        
        CGRect frame = _topTitle.frame;
        frame.origin.x = 160 - titleSize.width;
        _topTitle.frame = frame;
        
        [UIView beginAnimations:@"testAnimation" context:NULL];
        [UIView setAnimationDuration:(titleSize.width - 160) * 0.03f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationRepeatCount:999999];
        
        frame = _topTitle.frame;
        frame.origin.x = 0;
        _topTitle.frame = frame;
        [UIView commitAnimations];
        
        [_rightButton removeFromSuperview];
        [self addSubview:_rightButton];
    }
    else
    {
        [self addSubview:_topTitle];
        [_topTitle setText:strTitle];
    }
}

- (void)setLeftText:(NSString *)text
{
    [_leftButton setTitle:text forState:UIControlStateNormal];
}

- (void)setRightText:(NSString *)text
{
    [_rightButton setTitle:text forState:UIControlStateNormal];
    if ([text length] > 3) {
        CGRect frame = _rightButton.frame;
        frame.origin.x -= 20;
        frame.size.width += 20;
        _rightButton.frame = frame;
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"myTeam_03_high.png"] forState:UIControlStateNormal];
    }
}

- (void)setLeftIcon:(UIImage *)icon selected:(UIImage *)selIcon
{
    [_leftButton setFrame:CGRectMake(12, 12, 20, 20)];
    [_leftButton setBackgroundImage:icon forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:selIcon forState:UIControlStateHighlighted];
}

- (void)setRightIcon:(UIImage *)icon selected:(UIImage *)selIcon
{
    [_rightButton setFrame:CGRectMake(288, 12, 20, 20)];
    [_rightButton setBackgroundImage:icon forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:selIcon forState:UIControlStateHighlighted];
}

- (void)setRightIcon:(UIImage *)icon andText:(NSString *)text
{
    [_rightButton setFrame:CGRectMake(250, 6, 65, 32)];
    
    UIImageView *mapView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, 20, 20)];
    mapView.image = [UIImage imageNamed:@"hotel_search_map.png"];
    [_rightButton addSubview:mapView];
    [mapView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 30, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.text = text;
    [_rightButton addSubview:label];
    [label release];
}

-(void)closeController
{
    if (comDeleate && [comDeleate respondsToSelector:@selector(goBack)]) {
        [comDeleate goBack];
        return;
    }
    
    AppDelegate* delegate = [AppDelegate shareAppDelegate];
    [delegate.navigation popViewControllerAnimated:YES];
}

-(UILabel *)getNeedTipsInputLabel //显示必填项的星号
{
    return [UICommonView getNeedTipsInputLabel];
}

+(UILabel *)getNeedTipsInputLabel
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(290, 4, 25, 38)];
    lbl.text = @"*";
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:22];
    lbl.textColor = RGBA(247, 150, 56, 1);
    
    return [lbl autorelease];
}

+(UILabel *)getPlsSelectedLabel
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 50, 38)];
    lbl.text = @"请选择";
    lbl.tag = 11001;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textColor = [UIColor grayColor];
    
    return [lbl autorelease];
}

+(void)removePlsSelectedLabel:(UIView *)view
{
    UILabel *lbl = (UILabel *)[view viewWithTag:11001];
    if (lbl) {
        [lbl removeFromSuperview];
    }
}

- (void)showProgessHUD:(NSString *)text
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
//    UIView *uiView = [UIApplication sharedApplication].delegate.window;
    self.HUD = [[[MBProgressHUD alloc] initWithView:self] autorelease];
    BOOL isKeyBoardShow = false;
    NSArray *windowArray = [[UIApplication sharedApplication] windows];
    for(UIWindow *subWindow in windowArray)
    {
        // 键盘实际上是除了keyWindow之外的第二个window
        if(subWindow != [[UIApplication sharedApplication] keyWindow])
        {
            isKeyBoardShow = true;
            [subWindow addSubview:HUD];
        }
    }
    if (!isKeyBoardShow) {
        [self addSubview:HUD];
    }
    HUD.dimBackground = YES;
    HUD.labelText = text;
    [HUD show:YES];
}

- (void)hideProgessHUD
{
    [HUD hide:YES];
    [HUD removeFromSuperview];
    self.HUD = nil;
}

- (void)showTextField
{
    _rightButton.hidden = YES;
    _topTitle.hidden = YES;
    
    if (_textField == nil) {
        UIImageView *textFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 8, 260, 28)];
        textFieldBg.image = [UIImage imageNamed:@"search_button.png"];
        [self addSubview:textFieldBg];
        [textFieldBg release];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(55, 8, 230, 28)];
        [_textField setReturnKeyType:UIReturnKeySearch];
        [_textField setFont:[UIFont systemFontOfSize:SmallFontSize]];
        [_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self addSubview:_textField];
    }
}

-(void)dealloc
{
    [_leftButton release];
    [_rightButton release];
    [_topTitle release];
    [_textField release];
    [_backgroundImageView release];
    self.topView = nil;
    self.HUD = nil;
    
    [_navBarView release];
    [super dealloc];
}

@end
