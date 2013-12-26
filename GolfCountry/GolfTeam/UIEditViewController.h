//
//  UIEditViewController.h
//  GolfCountry
//
//  Created by xijun on 13-12-19.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIEditViewControllerDelegate <NSObject>

@optional

- (void)finishEditView:(UITextView*)textView;

@end

@interface UIEditViewController : UIViewController<UITextViewDelegate>
{
    UITextView      *_textView;
}

@property (nonatomic, retain)UITextView *textView;
@property (nonatomic, assign)id<UIEditViewControllerDelegate> delegate;

@end
