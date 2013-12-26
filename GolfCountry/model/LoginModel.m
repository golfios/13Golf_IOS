//
//  LoginModel.m
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "LoginModel.h"
#import "GolfPersonInfo.h"

@implementation LoginModel

- (void)requestLoginByAcc:(NSString *)account pwd:(NSString *)pwd
{
    NSString *loginStr = [NSString stringWithFormat:@"%@/v1/user/slogin", SERVER_NAME];
    NSURL *loginURL = [NSURL URLWithString:loginStr];
    ASIFormDataRequest *asiHttpReq = [[ASIFormDataRequest alloc] initWithURL:loginURL];
    asiHttpReq.userInfo = [NSDictionary dictionaryWithObject:@"Login" forKey:@"Method"];
    [self setHttpHeaders:asiHttpReq];
    
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"identity=%@&pwd=%@", account, pwd];
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
        NSDictionary *retDic = [NSDictionary dictionaryWithObject:@"连接服务器失败!" forKey:@"retText"];
        [self.delegate performSelector:didFailedSelector withObject:retDic];
    }
}

@end
