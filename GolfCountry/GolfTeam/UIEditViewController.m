//
//  UIEditViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-19.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIEditViewController.h"
#import "UICommonView.h"

@interface UIEditViewController ()
{
    UICommonView *_comView;
}

@end

@implementation UIEditViewController

@synthesize textView = _textView;
@synthesize delegate;

- (void)dealloc
{
    [_comView release];
    [_textView release];

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
    [_comView setTitleText:self.title];
    [_comView setRightText:@"完成"];
    [_comView.rightButton addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view = _comView;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10,60,300,140)];
    [_textView setBackgroundColor:[UIColor whiteColor]];
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.layer.borderWidth = 1.0;
    _textView.layer.cornerRadius = 5.0;
    _textView.font = [UIFont systemFontOfSize:SmallFontSize];
    [_textView setKeyboardType:UIKeyboardTypeDefault];
    [_textView setReturnKeyType:UIReturnKeyDone];
    [_textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    _textView.delegate = self;
    [self.view addSubview:_textView];
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

- (void)rightBtnClicked:(id)sender
{
    if (delegate) {
        [delegate finishEditView:_textView];
    }
    
    [[AppDelegate shareAppDelegate].navigation popViewControllerAnimated:YES];
}

#pragma mark - textView

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.selectedRange = NSMakeRange(0, 0);
//    _label.hidden = YES;
//    [_scrollView setContentOffset:CGPointMake(0, _pTextView.tag) animated:YES];
//    _scrollView.scrollEnabled = YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString: @"\n"]) {
        
        [_textView resignFirstResponder];
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView*)textView
{
//    NSString* textString = textView.text;
//    NSInteger length = [textString length];
//    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)textViewDidChange:(UITextView *)textView
{
#if 0
    NSInteger length = [textView.text length];
    if(length >= 0 && length <= 200)
    {
        _label.hidden = YES;
        NSString* fontLabelText = [[NSString alloc] initWithFormat:@"还可以输入%d个字",200 - length];
        [_fontNumLabel setText:fontLabelText];
        [fontLabelText release];
    }
    else if(length > 200)
    {
        _label.hidden = YES;
        textView.text=[textView.text substringToIndex:200];
        NSString* fontLabelText = [[NSString alloc] initWithFormat:@"还可以输入%d个字",0];
        [_fontNumLabel setText:fontLabelText];
        [fontLabelText release];
    }
    else
    {
        _label.hidden = NO;
    }
#endif
}

@end
