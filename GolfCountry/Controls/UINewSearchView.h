//
//  UINewSearchView.h
//  GolfCountry
//
//  Created by xijun on 13-12-5.
//  Copyright (c) 2013年 Pica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINewSearchView : UIView
{
    UIImageView           *_bgImage;
    UITextField           *_searchTextField;
}

@property (nonatomic, retain)UITextField  *searchTextField;

@end
