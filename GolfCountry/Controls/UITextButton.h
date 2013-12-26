//
//  UITextButton.h
//  GolfCountry
//
//  Created by xijun on 13-12-10.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextButton : UIButton
{
    UILabel     *_label1;
    UILabel     *_label2;
}

@property (nonatomic, retain)UILabel *label1;
@property (nonatomic, retain)UILabel *label2;

- (void)setButtonTexts:(NSInteger)text1 :(NSString*)text2;

- (void)resetLabelRect;

@end
