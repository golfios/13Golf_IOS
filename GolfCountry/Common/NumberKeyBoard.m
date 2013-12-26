//
//  NumberKeyBoard.m
//  JOY
//
//  Created by yongwei chen on 12-7-3.
//  Copyright (c) 2012年 Pica. All rights reserved.
//

#import "NumberKeyBoard.h"
#import <QuartzCore/QuartzCore.h>


@implementation NumberKeyBoard
@synthesize textField=_textField,nextField=_nextField;
@synthesize keyBoardType=_keyBoardType,nextTextView=_nextTextView;
-(id)initWithKeyBoardType:(int)keyBoardType
{
    self=[super init];
    CGRect fram=CGRectMake(0, 460-213, 320, 213);
    
    _keyBoardType=keyBoardType;
    self.frame=fram;
    if (self)
    {
    [self initView];
    }
    return  self;
    
}

-(id)init
{
    self=[super init];
    CGRect fram=CGRectMake(0, 460-213, 320, 213);
    
    _keyBoardType=keyBoardTypeDone;
    self.frame=fram;
    if (self)
    {
        [self initView];
    }
    return  self;
    
}
-(void)initView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0;
    
    for (int i = 1; i <= 11; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0+((i-1)%3)*107, 2+((i-1)/3)*53, 106.5, 52.5)];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 0.1;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        if (i <= 9) 
        {
            NSString *number=[NSString stringWithFormat:@"%d",i];
            [btn setTitle:number forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
            [btn setBackgroundImage:[UIImage imageNamed:@"iphone_1.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"iphone_1_press.png"] forState:UIControlStateHighlighted];
        }
        else if (i == 10) 
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"iphone_back.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"iphone_back_press.png"] forState:UIControlStateHighlighted];
            
        }
        else if (i == 11) 
        {
            NSString *number=[NSString stringWithFormat:@"%d",0];
            [btn setTitle:number forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
            [btn setBackgroundImage:[UIImage imageNamed:@"iphone_1.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"iphone_1_press.png"] forState:UIControlStateHighlighted];
        }
               
        btn.tag = i;
        
        [self addSubview:btn];
        [btn  addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btn release];
    }
    
    UIButton *btnDone = [[UIButton alloc]initWithFrame:CGRectMake(214, 161, 106.5, 52.5)];
    btnDone.layer.borderColor = [UIColor blackColor].CGColor;
    btnDone.layer.borderWidth = 0.1;
    
    if (_keyBoardType == keyBoardTypeDone)
    {
        [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        [btnDone setTitle:@"Next" forState:UIControlStateNormal];
    }
    
    [btnDone.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [btnDone setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"iphone_button_press.png"] forState:UIControlStateNormal];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"iphone_button.png"] forState:UIControlStateHighlighted];
    
    btnDone.tag = 12;
    [self addSubview:btnDone];
    [btnDone  addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [btnDone release];
}

-(void)btnPressed:(id)sender
{
    UIButton  *btn=sender;
    int number=btn.tag;
    if (number < 10 && number >= 1) 
    {
        [self numberKeyBoardInput:number];
    }
    if (number==11) 
    {
        [self numberKeyBoardInput:0];
    }
    if (number==10) {
        [self numberKeyBoardBackspace];
    }
    if (number==12) {
        if (_keyBoardType==keyBoardTypeDone)
        {
             [self numberKeyBoardFinish];
        }
        else
        {
            if (_nextField==nil&&_nextTextView==nil) {
                return;
            }
            [self keyBoardNextField];
        }
       
    }
}

- (void) numberKeyBoardInput:(NSInteger) number {
    NSMutableString* mutableString = [[[NSMutableString alloc] initWithFormat:@"%@%d", _textField.text, number] autorelease];
    _textField.text = mutableString;
}

- (void) numberKeyBoardBackspace {
    NSMutableString* mutableString = [[[NSMutableString alloc] initWithFormat:@"%@", _textField.text] autorelease];
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    _textField.text = mutableString;
}

- (void) numberKeyBoardFinish
{
    if(_textField.delegate && [_textField.delegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        [_textField.delegate textFieldShouldReturn:_textField];
    }
    else
    {
        [_textField resignFirstResponder];
    }
}

-(void)keyBoardNextField
{
    [_textField resignFirstResponder];
    if (_nextField==nil) {
        [_nextTextView becomeFirstResponder];
    }
    else
    {
        [_nextField  becomeFirstResponder];
    }
}


@end
