//
//  UIChooseImgViewController.h
//  GolfCountry
//
//  Created by xijun on 13-12-20.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIChooseImgControllerDelegate <NSObject>

@optional

- (void)chooseImageFinish:(UIImage*)image byPath:(NSString*)imagePath;

@end

@interface UIChooseImgViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImageView *_imageView;
    
    BOOL        isFullScreen;
}

@property (nonatomic, retain)UIImageView *imageView;
@property (nonatomic, assign)id<UIChooseImgControllerDelegate> delegate;

@end
