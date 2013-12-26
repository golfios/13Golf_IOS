//
//  FTGridCellView.h
//  FTGridView
//
//  Created by wu on 12-7-23.
//  Copyright (c) 2012年 tt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridIndex;
@class FTGridItemView;

@interface FTGridCellView : UITableViewCell
{
    NSMutableArray *_gridItemViewArray;             // 保存griditemview
}

- (void)addGridItemViewAtGridIndex:(GridIndex *)gridIndex withGridItemView:(FTGridItemView *)gridItemView;
- (FTGridItemView *)gridItemViewAtIndex:(NSInteger)index;
- (NSInteger)indexOfGridItemView:(FTGridItemView *)gridItemView;

@end
