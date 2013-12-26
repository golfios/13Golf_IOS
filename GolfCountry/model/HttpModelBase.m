//
//  HttpModelBase.m
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "HttpModelBase.h"
#import "JSON.h"
#import <CommonCrypto/CommonDigest.h>

#define KSecretKey  @"golf_jf_security"

@implementation HttpModelBase

@synthesize didFinishSelector, didFailedSelector, delegate;

- (void)setHttpHeaders:(ASIHTTPRequest *)asiHttpReq
{
    [asiHttpReq addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded; charset=UTF-8"];
    [asiHttpReq addRequestHeader:@"appKey" value:@"jf_golf_ios"];
}

- (NSString *)getSign:(NSString *)params
{
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSArray *paramArr = [params componentsSeparatedByString:@"&"];
    paramArr = [paramArr sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *str in paramArr) {
        [tempStr appendString:str];
    }
    [tempStr appendString:KSecretKey];
    NSString *result = [self md5:tempStr];
    [tempStr release];
    
    return result;
}

- (void)sendRequest:(NSString *)url method:(NSString *)method param:(NSMutableString *)param
{
    NSURL *requestURL = [NSURL URLWithString:url];
    ASIFormDataRequest *asiHttpReq = [[ASIFormDataRequest alloc] initWithURL:requestURL];
    asiHttpReq.userInfo = [NSDictionary dictionaryWithObject:method forKey:@"Method"];
    [self setHttpHeaders:asiHttpReq];
    
    NSString *sign = [self getSign:param];
    if (sign) {
        [param appendFormat:@"&sign=%@", sign];
    }
    [asiHttpReq appendPostData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"url=%@", url);
    NSLog(@"param=%@", param);
    
    [asiHttpReq setDelegate:self];
    [asiHttpReq setDidFinishSelector:@selector(requestFinish:)];
    [asiHttpReq setDidFailSelector:@selector(requestFailed:)];
    
    [asiHttpReq startAsynchronous];
    [asiHttpReq release];
}

- (void)requestFinish:(ASIHTTPRequest *)request
{
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

- (NSDictionary *)transferJSONToDic:(NSString *)str{
    return [self transferJSONToDic:str needHandle:YES];
}

- (NSDictionary *)transferJSONToDic:(NSString *)str needHandle:(BOOL)handle{
    
    id  o = [str JSONValue];
    
    //返回的数据成功,则切换界面
    if ([o isKindOfClass:[NSDictionary class]]) {
        NSDictionary*  dict				= (NSDictionary*)o;
        if (handle) {
            return dict;
        }else{
            return dict;
        }
    }else{ //json格式不正确
        NSDictionary *result = [NSDictionary dictionaryWithObject:@"服务器返回数据错误!" forKey:@"errorDes"];
        return result;
    }
    return nil;
}

- (NSString*)getStringValue:(NSDictionary*)dict :(NSString *)key
{
    NSString *value = [dict objectForKey:key];
    if (value == KGolfNull) {
        return @"";
    }
    return value;
}

- (NSInteger)getIntegerValue:(NSDictionary *)dict :(NSString *)key
{
    id value = [dict objectForKey:key];
    if (value == KGolfNull) {
        return 0;
    }
    return [value integerValue];
}

- (NSInteger)getFloatValue:(NSDictionary *)dict :(NSString *)key
{
    id value = [dict objectForKey:key];
    if (value == KGolfNull) {
        return 0;
    }
    return [value floatValue];
}

- (NSInteger)getBoolValue:(NSDictionary *)dict :(NSString *)key
{
    id value = [dict objectForKey:key];
    if (value == KGolfNull) {
        return 0;
    }
    return [value boolValue];
}

@end
