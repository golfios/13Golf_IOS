//
//  TextGridItemView.h
//  FTGridView
//
//  Created by wxj on 12-10-12.
//  Copyright (c) 2012年 tt. All rights reserved.
//

#import "FTGridItemView.h"

@interface TextGridItemView : FTGridItemView
{
    UILabel *_label;
}

- (void)setText:(NSString *)text;

@end
