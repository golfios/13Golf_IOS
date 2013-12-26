//
//  NSSystemSetMessage.h
//  JOY
//
//  Created by Zheng Xu on 12-5-15.
//  Copyright (c) 2012年 Pica. All rights reserved.
//


/*
 @brief 本类为单实例类，请不要直接alloc，而是使用+(NSSystemSetMessage*)defaultMessage调用
 */
#import <Foundation/Foundation.h>

#define LoadFileName       @"load.plist"
#define Key_UserName       @"username"
#define Key_PassWord       @"password"
#define Key_leaveCity      @"leavecity"
#define Key_ArriveCity     @"arrivecity"
#define Key_leaveCityID    @"leavecityID"
#define Key_ArriveCityID   @"arrivecityID"
#define Key_leaveCityCODER   @"leavecityCODER"
#define Key_ArriveCityCODER  @"arrivecityCODER"
#define Key_HotelRadius    @"hotelradius"
#define Key_HotelImageShow @"hotelimageshow"
#define Key_FirstLaunch    @"firstlaunch"
#define Key_RememberPwd    @"rememberpwd"
#define Key_IsLogin        @"isLogin"


@interface NSSystemSetMessage : NSObject
{
    NSString* _username;       //用户名
    NSString* _password;       //密码
    
    BOOL      _rememberPwd;    //是否记住密码
    BOOL      _hotelImageShow; //是否显示图片
    BOOL      _firstLauch;     //是否第一次启动软件
    BOOL      _isLogin;        //是否登录
    
    NSString* _leaveCity;      //出发城市
    NSString* _arriveCity;     //到达城市
    NSString* _leaveCityID;    //出发城市ID
    NSString* _arriveCityID;   //到达城市ID
    NSString* _leaveCityCoder; //出发城市三字码
    NSString* _arriveCityCoder;//到达城市三字码
    NSInteger _hotelRadius;    //酒店搜索半径
    
    
    NSString* _tempLeaveCity;      //出发城市，退出软件后无效
    NSString* _tempArriveCity;     //到达城市，退出软件后无效
    NSString* _tempLeaveCityCoder; //出发城市三字码，退出软件后无效
    NSString* _tempArriveCityCoder;//到达城市三字码，退出软件后无效
    
    NSString* _tempHotelCity;      //酒店城市名，退出软件后无效
    NSString* _tempHotelCityID;    //酒店城市ID，退出软件后无效
    
    NSString* _tempWeatherCity;      //天气预报城市名，退出软件后无效
    NSString* _tempWeatherCityCoder; //天气预报城市三字码，退出软件后无效
    
    BOOL      _bHasTicket;       //机票预订页是否点击了立即出票，退出软件后无效
    BOOL      _bCommendedHotel;  //是否为机票推荐的酒店，退出软件后无效
    BOOL      _bCommendedTravel; //是否为酒店推荐的度假产品，退出软件后无效

    
    NSMutableDictionary* _plistDictionary;
}

-(void)addCardCode:(NSString*)strId :(NSString*)strCardCode;
-(NSString*)getCardCode:(NSString*)strId;

@property(nonatomic,retain)NSString *leaveCityCoder,*arriveCityCoder;
@property(nonatomic,retain)NSString *leaveCityID,*arriveCityID;
@property(nonatomic,retain)NSString *username,*password,*leaveCity,*arriveCity;
@property(nonatomic,assign)BOOL      hotelImageShow,firstLauch,rememberPwd,isLogin;
@property(nonatomic,assign)NSInteger hotelRadius;

@property(nonatomic,retain)NSString* tempLeaveCity;      //出发城市，退出软件后无效
@property(nonatomic,retain)NSString* tempArriveCity;     //到达城市，退出软件后无效
@property(nonatomic,retain)NSString* tempLeaveCityCoder; //出发城市三字码，退出软件后无效
@property(nonatomic,retain)NSString* tempArriveCityCoder;//到达城市三字码，退出软件后无效

@property(nonatomic,retain)NSString* tempHotelCity;      //酒店城市名，退出软件后无效
@property(nonatomic,retain)NSString* tempHotelCityID;    //酒店城市ID，退出软件后无效

@property(nonatomic,retain)NSString* tempWeatherCity;      //天气预报城市名，退出软件后无效
@property(nonatomic,retain)NSString* tempWeatherCityCoder; //天气预报城市三字码，退出软件后无效

@property(nonatomic,assign)BOOL      bHasNewVersion;       //是否有新版本
@property(nonatomic,retain)NSString* versionCode;          //新版本号
@property(nonatomic,retain)NSString* versionContent;       //新版本介绍
@property(nonatomic,retain)NSString* downloadUrl;          //下载地址
@property(nonatomic,retain)NSString* gradeUrl;             //评分地址

@property(nonatomic,assign)BOOL      bHasTicket;           //机票预订页是否点击了立即出票，退出软件后无效
@property(nonatomic,assign)BOOL      bCommendedHotel;      //是否为机票推荐的酒店，退出软件后无效
@property(nonatomic,assign)BOOL      bCommendedTravel;     //是否为酒店推荐的度假产品，退出软件后无效

+(NSSystemSetMessage*)defaultMessage;

-(void)setLoadFileData;

@end
