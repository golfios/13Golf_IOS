//
//  UITextEditView.h
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberKeyBoard.h"

@interface UITextEditView : UIView<UITextFieldDelegate>
{
    UILabel         *_title;
    UITextField     *_textField;
    int             _maxInputCount;
    NumberKeyBoard  *_keyBoard;
    
    UIImageView     *_noteIcon;
}

@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UITextField *textField;
@property (nonatomic, assign)int maxInputCount;
@property (nonatomic, retain)UIImageView *noteIcon;

- (void)setKeyBoard;

- (void)setPlaceHold:(NSString *)placeHold;

- (void)resetControlFrame;

@end
