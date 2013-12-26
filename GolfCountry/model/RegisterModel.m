//
//  RegisterModel.m
//  GolfCountry
//
//  Created by xijun on 13-12-3.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "RegisterModel.h"
#import "GolfPersonInfo.h"

@implementation RegisterStruct

@synthesize phone, userName, pwd, device, realName, sfzId;

- (void)dealloc
{
    self.phone = nil;
    self.userName = nil;
    self.pwd = nil;
    self.device = nil;
    self.realName = nil;
    self.sfzId = nil;
    
    [super dealloc];
}

@end

@implementation RegisterModel

- (void)requestRegister:(RegisterStruct *)rsStruct
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/user/register", SERVER_NAME];
    NSURL *requestURL = [NSURL URLWithString:requestStr];
    ASIFormDataRequest *asiHttpReq = [[ASIFormDataRequest alloc] initWithURL:requestURL];
    asiHttpReq.userInfo = [NSDictionary dictionaryWithObject:@"Register" forKey:@"Method"];
    [self setHttpHeaders:asiHttpReq];
    
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"phone=%@&userName=%@&pwd=%@&device=%@", rsStruct.phone, rsStruct.userName, rsStruct.pwd, rsStruct.device];
    if (rsStruct.realName && rsStruct.sfzId) {
        [postParam appendFormat:@"&realName=%@&sfzId=%@", rsStruct.realName, rsStruct.sfzId];
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

- (void)requestFinish:(ASIHTTPRequest *)request
{
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *responseStr = [request responseString];
    NSLog(@"%@", responseStr);
    NSDictionary *dic = [self transferJSONToDic:responseStr needHandle:NO];
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
