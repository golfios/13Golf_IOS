//
//  GolfPersonInfo.h
//  GolfCountry
//
//  Created by xijun on 13-12-7.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GolfPersonInfo : NSObject
{
    NSInteger   _userId;
    NSString    *_userName;
    NSString    *_email;
    NSString    *_phone;
    NSInteger   _gender;    /** 0为女，1为男 */
    NSString    *_headUrl;
    NSString    *_description;
    NSInteger   _playAge;
    float       _handicap;
    NSString    *_createdTime;
    NSString    *_token;
    NSString    *_city;
    NSInteger   _status;        /** 1为认证用户，0为非认证用户 */
    NSInteger   _friendCount;
    NSInteger   _followCount;
    NSInteger   _fansCount;
    BOOL        _isFollowed;    /** 是否被关注 */
}

@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain)NSString *email;
@property (nonatomic, retain)NSString *phone;
@property (nonatomic, assign)NSInteger gender;
@property (nonatomic, retain)NSString *headUrl;
@property (nonatomic, retain)NSString *description;
@property (nonatomic, assign)NSInteger playAge;
@property (nonatomic, assign)float handicap;
@property (nonatomic, retain)NSString *createdTime;
@property (nonatomic, retain)NSString *token;
@property (nonatomic, retain)NSString *city;
@property (nonatomic, assign)NSInteger status;
@property (nonatomic, assign)NSInteger friendCount;
@property (nonatomic, assign)NSInteger followCount;
@property (nonatomic, assign)NSInteger fansCount;
@property (nonatomic, assign)BOOL isFollowed;

+ (GolfPersonInfo*)defaultPersonInfo;

+ (void)clearPersonInfo;

+ (void)createPersonInfo:(NSDictionary *)dict;

@end
