//
//  FTGridView.h
//  FTGridView
//
//  Created by wxj wu on 12-7-23.
//  Copyright (c) 2012年 tt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTGridItemView.h"

// row和column均从0开始算起
@interface GridIndex : NSObject 
{
    NSInteger _row;
    NSInteger _column;
}

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;

- (id)initWithRow:(NSInteger)row column:(NSInteger)column;
+ (id)gridIndexWithRow:(NSInteger)row column:(NSInteger)column;

@end

@class FTGridCellView;
@protocol FTGridViewDelegate;

@interface FTGridView : UIView<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    id<FTGridViewDelegate> _delegate;
}

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, assign) id<FTGridViewDelegate> delegate;

// 一个cell中的grid在内部是可以反复使用
- (FTGridItemView *)dequeueReusableGridItemAtGridIndex:(GridIndex *)gridIndex ofGridCellView:(FTGridCellView *)gridCellView;
// 获取某一位置出的griditem
- (FTGridItemView *)gridItemViewAtGridIndex:(GridIndex *)gridIndex;
- (FTGridItemView *)gridItemViewAtIndex:(NSInteger)index;
// 根据griditemview获取gridindex
- (GridIndex *)gridIndexOfGridItemView:(FTGridItemView *)gridItem;
- (NSInteger)indexOfGridItemView:(FTGridItemView *)gridItem;
- (NSInteger)indexOfGridIndex:(GridIndex *)gridIndex;
- (void)reloadData;

@end

@protocol FTGridViewDelegate <NSObject>

- (CGFloat)gridView:(FTGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// 获取单元格的总数
- (NSInteger)gridNumberOfGridView:(FTGridView *)gridView;
// 获取单元格的行数
- (NSInteger)rowNumberOfGridView:(FTGridView *)gridView;
// 获取gridview每行显示的grid数
- (NSInteger)columnNumberOfGridView:(FTGridView *)gridView;
// 获取特定位置的单元格视图
- (FTGridItemView *)gridView:(FTGridView *)gridView inGridCell:(FTGridCellView *)gridCell gridItemViewAtGridIndex:(GridIndex *)gridIndex listIndex:(NSInteger)listIndex;
@optional
// 点击某一个单元格的回调
- (void)gridView:(FTGridView *)gridView didSelectGridItemAtIndex:(NSInteger)index;
- (void)gridViewDidScroll:(FTGridView *)gridView;
- (void)gridViewDidEndDragging:(FTGridView *)gridView willDecelerate:(BOOL)decelerate;
- (void)gridViewDidEndDecelerating:(FTGridView *)gridView;

@end