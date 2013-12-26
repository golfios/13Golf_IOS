//
//  GolfTeamModel.h
//  GolfCountry
//
//  Created by xijun on 13-12-15.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "HttpModelBase.h"

#define KAllTeamList        @"AllTeamList"
#define KJoinTeamList       @"JoinTeamList"
#define KCreatedTeamList    @"CreatedTeamList"
#define KTeamUploadLogo     @"UploadTeamLogo"
#define KMethodTeamInfo     @"GetTeamInfo"
#define KMethodCreateTeam   @"CreateTeam"
#define KMethodEditTeam     @"EditTeam"

@interface GolfTeamInfo : NSObject

@property (nonatomic, assign)NSInteger  userId;
@property (nonatomic, assign)NSInteger  creatorId;
@property (nonatomic, retain)NSString   *contacts;
@property (nonatomic, retain)NSString   *phone;
@property (nonatomic, retain)NSString   *name;
@property (nonatomic, retain)NSString   *logo;
@property (nonatomic, retain)NSString   *city;
@property (nonatomic, retain)NSString   *createdDate;
@property (nonatomic, retain)NSString   *purpose;
@property (nonatomic, retain)NSString   *description;
@property (nonatomic, assign)NSInteger  count;
@property (nonatomic, assign)NSInteger  isMember;
@property (nonatomic, assign)NSInteger  canEdit;

@end

@interface createTeamStruct : NSObject

@property (nonatomic, assign)NSInteger  teamId;     /** 球队id */
@property (nonatomic, retain)NSString   *teamName;  /** 球队名 */
@property (nonatomic, retain)NSString   *city;      /** 城市名 */
@property (nonatomic, retain)NSString   *logoUrl;   /** 球队logo url */
@property (nonatomic, retain)NSString   *contacts;  /** 球队秘书姓名 */
@property (nonatomic, retain)NSString   *phone;     /** 球队秘书联系方式 */
@property (nonatomic, retain)NSString   *createdDate;/** 球队创建日期2013-09-12 */
@property (nonatomic, retain)NSString   *purpose;   /** 球队宗旨 */
@property (nonatomic, retain)NSString   *description;/** 球队简介 */

@end

@interface GolfTeamModel : HttpModelBase

/**
 * @brief 球队列表获取接口
 * @param city:     城市名
 * @param offset:   第几页 从0开始
 * @param limit:    每页的大小
 * @return N/A
 */
- (void)requestAllTeamList:(NSString*)city :(NSInteger)offset :(NSInteger)limit;

/**
 * @brief 加入的球队列表获取接口
 * @param offset:   第几页 从0开始
 * @param limit:    每页的大小
 * @return N/A
 */
- (void)requestJoinTeamList:(NSInteger)offset :(NSInteger)limit;

/**
 * @brief 创建的球队列表获取接口
 * @param offset:   第几页 从0开始
 * @param limit:    每页的大小
 * @return N/A
 */
- (void)requestCreatedTeamList:(NSInteger)offset :(NSInteger)limit;

/**
 * @brief 查看球队信息接口
 * @param id:   球队id
 * @return N/A
 */
- (void)requestTeamInfo:(NSInteger)teamId;

/**
 * @brief 获取球队列表数组
 * @param dataArray: 联网返回的数据
 * @return 球手结构数组
 */
- (NSArray *)getTeamArray:(NSArray*)dataArray;

/**
 * @brief 获取球队列表数组
 * @param dataArray: 联网返回的数据
 * @return 球手结构数组
 */
- (void)requestUploadTeamLogo:(NSString*)fileName;

/**
 * @brief 创建球队接口
 * @param ctStruct: 创建球队结构体
 * @return 球手结构数组
 */
- (void)requestCreateTeam:(createTeamStruct*)ctStruct;

/**
 * @brief 编辑球队接口
 * @param ctStruct: 编辑球队结构体
 * @return 球手结构数组
 */
- (void)requestEditTeam:(createTeamStruct*)ctStruct;

@end
