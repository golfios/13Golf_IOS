//
//  FTGridView.m
//  FTGridView
//
//  Created by wxj wu on 12-7-23.
//  Copyright (c) 2012年 tt. All rights reserved.
//

#import "FTGridView.h"
#import "FTGridCellView.h"

@interface FTGridView ()


@end

@implementation FTGridView

@synthesize
tableView = _tableView,
delegate = _delegate;

#pragma mark -
#pragma mark 内部调用方法

- (GridIndex *)gridIndexOfIndex:(NSInteger)index
{
    NSInteger columnCount = [_delegate columnNumberOfGridView:self];
    NSInteger column = index % columnCount;
    NSInteger row = index / columnCount;
    return [GridIndex gridIndexWithRow:row column:column];
}

// 初始化子视图
- (void)initSubControls
{
    // 初始化列表
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    _tableView = [[[UITableView alloc] initWithFrame:rect] autorelease];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self, _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        [self initSubControls];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark 外部调用方法

- (FTGridItemView *)dequeueReusableGridItemAtGridIndex:(GridIndex *)gridIndex ofGridCellView:(FTGridCellView *)gridCellView
{
    return [gridCellView gridItemViewAtIndex:gridIndex.column];
}

- (FTGridItemView *)gridItemViewAtGridIndex:(GridIndex *)gridIndex
{
    FTGridCellView *cell = (FTGridCellView *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:gridIndex.row inSection:0]];
    return [cell gridItemViewAtIndex:gridIndex.column];
}

- (FTGridItemView *)gridItemViewAtIndex:(NSInteger)index
{
    return [self gridItemViewAtGridIndex:[self gridIndexOfIndex:index]];
}

- (GridIndex *)gridIndexOfGridItemView:(FTGridItemView *)gridItem
{
    FTGridCellView *cell = (FTGridCellView *)[gridItem superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if (indexPath) 
    {
        NSInteger itemIndex = [cell indexOfGridItemView:gridItem];
        return [GridIndex gridIndexWithRow:indexPath.row column:itemIndex];
    }
    return nil;
}

- (NSInteger)indexOfGridItemView:(FTGridItemView *)gridItem
{
    GridIndex *gridIndex = [self gridIndexOfGridItemView:gridItem];
    return [self indexOfGridIndex:gridIndex];
}

- (NSInteger)indexOfGridIndex:(GridIndex *)gridIndex
{
    return gridIndex.row * [_delegate columnNumberOfGridView:self] + gridIndex.column;
}

- (void)reloadData
{
    [_tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

// todo：暂时只考虑一个section的情况
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_delegate rowNumberOfGridView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *gridCellStr = @"gridCell";
    FTGridCellView *cellView = [tableView dequeueReusableCellWithIdentifier:gridCellStr];
    if (!cellView) 
    {
        cellView = [[[FTGridCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gridCellStr] autorelease];
    }
    // 获取grid的总数
    NSInteger count = [_delegate gridNumberOfGridView:self];
    // 行数
    NSInteger rowCount = [_delegate rowNumberOfGridView:self];
    // 列数
    NSInteger columnCount = [_delegate columnNumberOfGridView:self];
    // 判断区域是否合法
    if (indexPath.row < rowCount) 
    {
        for (NSInteger index = 0; index < columnCount; index ++) 
        {
            GridIndex *gridIndex = [GridIndex gridIndexWithRow:indexPath.row column:index];
            if ([self indexOfGridIndex:gridIndex] >= count)
            {
                FTGridItemView *itemView = [cellView gridItemViewAtIndex:gridIndex.column];
                itemView.hidden = YES;
                continue;
            }
            // 暂时，griditeview的frame由delegate设置
            FTGridItemView *gridItemView = [_delegate gridView:self inGridCell:cellView gridItemViewAtGridIndex:gridIndex listIndex:[self indexOfGridIndex:gridIndex]];
            gridItemView.hidden = NO;
            // todo: 将griditemview添加到gridcellview中
            [cellView addGridItemViewAtGridIndex:gridIndex withGridItemView:gridItemView];
            //  给gridItemView添加点击事件
            [gridItemView setTarget:self action:@selector(didTap:)];
        }
    }
    return cellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_delegate gridView:self heightForRowAtIndexPath:indexPath];
}

- (void)didTap:(id)sender
{
    if ([_delegate respondsToSelector:@selector(gridView:didSelectGridItemAtIndex:)]) 
    {
        FTGridItemView *view = (FTGridItemView *)sender;
        NSLog(@"tap index:%d", [self indexOfGridItemView:view]);
        [_delegate gridView:self didSelectGridItemAtIndex:[self indexOfGridItemView:view]];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    if ([_delegate respondsToSelector:@selector(gridViewDidScroll:)])
    {
        [_delegate gridViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([_delegate respondsToSelector:@selector(gridViewDidEndDragging:willDecelerate:)]) 
    {
        [_delegate gridViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(gridViewDidEndDecelerating:)])
    {
        [_delegate gridViewDidEndDecelerating:self];
    }
}

@end

@implementation GridIndex

@synthesize
row = _row,
column = _column;

- (id)initWithRow:(NSInteger)row column:(NSInteger)column
{
    if (self = [super init]) 
    {
        _row = row;
        _column = column;
    }
    return self;
}

+ (id)gridIndexWithRow:(NSInteger)row column:(NSInteger)column
{
    GridIndex *index = [[GridIndex alloc] initWithRow:row column:column];
    return [index autorelease];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{row:%d, column:%d}", _row, _column];
}

@end
