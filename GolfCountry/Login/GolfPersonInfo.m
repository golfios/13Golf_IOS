//
//  GolfPersonInfo.m
//  GolfCountry
//
//  Created by xijun on 13-12-7.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "GolfPersonInfo.h"

static GolfPersonInfo* defaultInstance = nil;

@implementation GolfPersonInfo

@synthesize userId = _userId;
@synthesize userName = _userName;
@synthesize email = _email;
@synthesize phone = _phone;
@synthesize gender = _gender;
@synthesize headUrl = _headUrl;
@synthesize description = _description;
@synthesize playAge = _playAge;
@synthesize handicap = _handicap;
@synthesize createdTime = _createdTime;
@synthesize token = _token;
@synthesize city = _city;
@synthesize status = _status;
@synthesize friendCount = _friendCount;
@synthesize followCount = _followCount;
@synthesize fansCount = _fansCount;
@synthesize isFollowed = _isFollowed;

- (void)dealloc
{
    [_userName dealloc];
    [_email release];
    [_phone dealloc];
    [_headUrl release];
    [_description release];
    [_createdTime dealloc];
    [_token dealloc];
    [_city release];
    
    [super dealloc];
}

+ (GolfPersonInfo*)defaultPersonInfo
{
    if(defaultInstance == nil)
    {
        defaultInstance = [[GolfPersonInfo alloc] init];
    }
    
    return defaultInstance;
}

+ (void)clearPersonInfo
{
    if(defaultInstance != nil)
    {
        [defaultInstance release];
        defaultInstance = nil;
    }
}

+ (void)createPersonInfo:(NSDictionary *)dict
{
    [GolfPersonInfo clearPersonInfo];
    
    GolfPersonInfo *info = [GolfPersonInfo defaultPersonInfo];
    info.userId = [[dict objectForKey:@"id"] integerValue];
    info.userName = [dict objectForKey:@"userName"];
    info.email = [dict objectForKey:@"email"];
    info.phone = [dict objectForKey:@"phone"];
    info.gender = [[dict objectForKey:@"gender"] integerValue];
    info.headUrl = [dict objectForKey:@"headUrl"];
    info.description = [dict objectForKey:@"description"];
    info.playAge = [[dict objectForKey:@"playAge"] integerValue];
    info.handicap = [[dict objectForKey:@"handicap"] floatValue];
    info.createdTime = [dict objectForKey:@"createdTime"];
    info.token = [dict objectForKey:@"token"];
    info.city = [dict objectForKey:@"city"];
    info.status = [[dict objectForKey:@"status"] integerValue];
    info.friendCount = [[dict objectForKey:@"friendCount"] integerValue];
    info.followCount = [[dict objectForKey:@"followCount"] integerValue];
    info.fansCount = [[dict objectForKey:@"fansCount"] integerValue];
}

@end
