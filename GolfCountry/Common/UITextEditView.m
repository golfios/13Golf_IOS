//
//  UITextEditView.m
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UITextEditView.h"
#import "UICommonView.h"

#define KIconWidth  22

@implementation UITextEditView

@synthesize title = _title;
@synthesize textField = _textField;
@synthesize maxInputCount = _maxInputCount;
@synthesize noteIcon = _noteIcon;

- (void)dealloc
{
    [_title release];
    [_textField release];
    [_keyBoard release];
    [_noteIcon release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        int control_x = 20;
        int control_y = 10;
        int label_wid = 70;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(control_x, control_y, label_wid, 20)];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = [Utility hexStringToColor:@"737373"];
        _title.font = [UIFont boldSystemFontOfSize:MidFontSize];
        [self addSubview:_title];
        
        control_x += label_wid + 10;
        int field_wid = self.frame.size.width - control_x - KIconWidth - 10;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(control_x, control_y, field_wid, 20)];
        [_textField setBackground:nil];
        [_textField setReturnKeyType:UIReturnKeyDone];
//        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
        [_textField setFont:[UIFont systemFontOfSize:15]];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_textField addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.delegate = self;
        [self addSubview:_textField];
        
        control_x += field_wid + 5;
        _noteIcon = [[UIImageView alloc] initWithFrame:CGRectMake(control_x, control_y, KIconWidth, KIconWidth)];
//        _noteIcon.image = [UIImage imageNamed:@"wrong.png"];
        [self addSubview:_noteIcon];
    }
    return self;
}

- (void)resetControlFrame
{
    CGRect frame = _title.frame;
    frame.size.width -= 30;
    _title.frame = frame;
    
    frame = _textField.frame;
    frame.origin.x -= 30;
    frame.size.width += 30;
    _textField.frame = frame;
}

- (void)setPlaceHold:(NSString *)placeHold
{
    _textField.placeholder = placeHold;
}

-(void)textEditingChanged:(UITextField *)textField
{
    NSInteger textLength = [textField.text length];
    if (textLength == 1) {
        _noteIcon.image = [UIImage imageNamed:@"ok.png"];
    }
    else if (textLength == 0) {
        _noteIcon.image = [UIImage imageNamed:@"wrong.png"];
    }
    
    if(_maxInputCount == 0)
        return;
    
    if (textLength > _maxInputCount)
    {
        textField.text = [textField.text substringToIndex:_maxInputCount];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    
    return YES;
}

- (void)setKeyBoard
{
    _keyBoard = [[NumberKeyBoard alloc]initWithKeyBoardType:keyBoardTypeDone];
    _textField.inputView = _keyBoard;
    _keyBoard.textField = _textField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
