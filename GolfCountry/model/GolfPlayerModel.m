//
//  GolfPlayer.m
//  GolfCountry
//
//  Created by xijun on 13-12-12.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "GolfPlayerModel.h"
#import "GolfPersonInfo.h"

@implementation GolfPlayerModel

- (void)requestPlayerList:(NSInteger)type :(NSInteger)offset :(NSInteger)limit :(NSString *)city
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/user/list", SERVER_NAME];
    NSURL *requestURL = [NSURL URLWithString:requestStr];
    ASIFormDataRequest *asiHttpReq = [[ASIFormDataRequest alloc] initWithURL:requestURL];
    asiHttpReq.userInfo = [NSDictionary dictionaryWithObject:KMethodPlayerList forKey:@"Method"];
    [self setHttpHeaders:asiHttpReq];
    
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"type=%d&offset=%d&limit=%d&token=%@", type, offset, limit, [GolfPersonInfo defaultPersonInfo].token];
    //type 为 1时带上city参数
    if (type == 1) {
        [postParam appendFormat:@"&city=%@", city];
    }
    NSString *sign = [self getSign:postParam];
    if (sign) {
        [postParam appendFormat:@"&sign=%@", sign];
    }
    [asiHttpReq appendPostData:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    [asiHttpReq setDelegate:self];
    [asiHttpReq setDidFinishSelector:@selector(requestFinish:)];
    [asiHttpReq setDidFailSelector:@selector(requestFailed:)];
    
    [asiHttpReq startAsynchronous];
    [asiHttpReq release];
}

- (void)requestFollowUser:(NSInteger)userId
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/relation/follow", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"userId=%d&token=%@", userId, [GolfPersonInfo defaultPersonInfo].token];
    [self sendRequest:requestStr method:KMethodFollow param:postParam];
}

- (void)requestCancelFollow:(NSInteger)userId
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/relation/unFollow", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"userId=%d&token=%@", userId, [GolfPersonInfo defaultPersonInfo].token];
    [self sendRequest:requestStr method:KMethodUnFollow param:postParam];
}

- (void)requestFinish:(ASIHTTPRequest *)request
{
    NSString *method = [request.userInfo objectForKey:@"Method"];
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *responseStr = [request responseString];
    NSLog(@"%@", responseStr);
    NSDictionary *dic = [self transferJSONToDic:responseStr];
    if (dic != nil) {
        if (self.delegate && [self.delegate respondsToSelector:didFinishSelector]) {
            [self.delegate performSelector:didFinishSelector withObject:dic withObject:method];
        }
    }
}

- (NSArray *)getPlayerArray:(NSArray *)dataArray
{
    if ([dataArray count] <= 0) {
        return nil;
    }
    NSMutableArray *playArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dataArray) {
        GolfPersonInfo *info = [[GolfPersonInfo alloc] init];
        info.userId = [self getIntegerValue:dict :@"id"];
        info.userName = [self getStringValue:dict :@"userName"];
        info.email = [self getStringValue:dict :@"email"];
        info.phone = [self getStringValue:dict :@"phone"];
        info.gender = [self getIntegerValue:dict :@"gender"];
        info.headUrl = [self getStringValue:dict :@"headUrl"];
        info.description = [dict objectForKey:@"description"];
        info.playAge = [self getIntegerValue:dict :@"playAge"];
        info.handicap = [self getFloatValue:dict :@"handicap"];
        info.createdTime = [self getStringValue:dict :@"createdTime"];
        info.token = [self getStringValue:dict :@"token"];
        info.city = [self getStringValue:dict :@"city"];
        info.status = [self getIntegerValue:dict :@"status"];
        info.friendCount = [self getIntegerValue:dict :@"friendCount"];
        info.followCount = [self getIntegerValue:dict :@"followCount"];
        info.fansCount = [self getIntegerValue:dict :@"fansCount"];
        info.isFollowed = [self getBoolValue:dict :@"isFollowed"];
        
        [playArr addObject:info];
        [info release];
    }
    
    return [playArr autorelease];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (self.delegate && [self.delegate respondsToSelector:didFailedSelector]) {
        NSDictionary *retDic       = [NSDictionary dictionaryWithObject:@"连接服务器失败!" forKey:@"retText"];
        [self.delegate performSelector:didFailedSelector withObject:retDic];
    }
}

@end
