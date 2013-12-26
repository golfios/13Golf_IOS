//
//  PersonModel.m
//  GolfCountry
//
//  Created by xijun on 13-12-7.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "PersonModel.h"
#import "GolfPersonInfo.h"

@implementation PersonModel

- (void)requestPersonInfo:(NSInteger)userId
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/user/show", SERVER_NAME];
    NSURL *requestURL = [NSURL URLWithString:requestStr];
    ASIFormDataRequest *asiHttpReq = [[ASIFormDataRequest alloc] initWithURL:requestURL];
    asiHttpReq.userInfo = [NSDictionary dictionaryWithObject:@"PersonInfo" forKey:@"Method"];
    [self setHttpHeaders:asiHttpReq];
    
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"id=%d&token=%@", userId, [GolfPersonInfo defaultPersonInfo].token];
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

- (void)requestFinish:(ASIHTTPRequest *)request
{
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *responseStr = [request responseString];
    NSLog(@"%@", responseStr);
    NSDictionary *dic = [self transferJSONToDic:responseStr];
    if (dic != nil) {
        if ([[dic objectForKey:@"status"] integerValue] == 200) {
            [GolfPersonInfo createPersonInfo:[dic objectForKey:@"data"]];
        }
        if (self.delegate && [self.delegate respondsToSelector:didFinishSelector]) {
            [self.delegate performSelector:didFinishSelector withObject:dic];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (self.delegate && [self.delegate respondsToSelector:didFailedSelector]) {
        NSDictionary *retDic       = [NSDictionary dictionaryWithObject:@"连接服务器失败!" forKey:@"retText"];
        [self.delegate performSelector:didFailedSelector withObject:retDic];
    }
}

@end
