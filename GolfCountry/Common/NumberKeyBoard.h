//
//  NumberKeyBoard.h
//  JOY
//
//  Created by pple a on 12-7-3.
//  Copyright (c) 2012年 Pica. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    keyBoardTypeDone = 0, //完成
    keyBoardTypeNext = 1 //下一项
}keyBoardType; //设置排序方式

@interface NumberKeyBoard : UIView<UITextFieldDelegate>
{
    UITextField     *_textField;
    int             _keyBoardType;
    UITextField     *_nextField;
    UITextView      *_nextTextView;
}
@property(nonatomic,retain)UITextField  *textField,*nextField;
@property(nonatomic,assign)int          keyBoardType;
@property(nonatomic,retain)UITextView   *nextTextView;
-(void)initView;
-(id)initWithKeyBoardType:(int)keyBoardType;
- (void) numberKeyBoardInput:(NSInteger) number;
- (void) numberKeyBoardBackspace;
- (void) numberKeyBoardFinish;
-(void)keyBoardNextField;
@end
