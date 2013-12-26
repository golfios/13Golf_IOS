//
//  GolfPlayerModel.h
//  GolfCountry
//
//  Created by xijun on 13-12-12.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "HttpModelBase.h"

#define KMethodPlayerList   @"PlayerList"
#define KMethodFollow       @"Follow"
#define KMethodUnFollow     @"UnFollow"

@interface GolfPlayerModel : HttpModelBase

/**
 * @brief 球手列表获取接口
 * @param type:     0 全部球手 1 本地球手 2 附近球手 3 认证球手 4非认证球手
 * @param offset:   第几页 从0开始
 * @param limit:    每页的大小
 * @param city:     type 为 1时带上city参数
 * @return N/A
 */
- (void)requestPlayerList:(NSInteger)type :(NSInteger)offset :(NSInteger)limit :(NSString*)city;

/**
 * @brief 获取球手列表数组
 * @param dataArray: 联网返回的数据
 * @return 球手结构数组
 */
- (NSArray *)getPlayerArray:(NSArray*)dataArray;

/**
 * @brief 关注用户
 * @param userId:   被关注人ID
 * @return N/A
 */
- (void)requestFollowUser:(NSInteger)userId;

/**
 * @brief 取消关注用户
 * @param userId:   被取消关注人ID
 * @return N/A
 */
- (void)requestCancelFollow:(NSInteger)userId;

@end
