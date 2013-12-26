//
//  HttpModelBase.h
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

/** 联网请求基类 */
@interface HttpModelBase : NSObject
{
    SEL didFinishSelector;
    SEL didFailedSelector;
}

@property (assign) SEL didFinishSelector;
@property (assign) SEL didFailedSelector;
@property (assign, nonatomic) id delegate;

- (void)setHttpHeaders:(ASIHTTPRequest *)asiHttpReq;

- (NSString *)getSign:(NSString *)params;

- (void)sendRequest:(NSString*)url method:(NSString*)method param:(NSMutableString*)param;

- (void)requestFinish:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

//需要处理ret等节点
- (NSDictionary *)transferJSONToDic:(NSString *)str;
- (NSDictionary *)transferJSONToDic:(NSString *)str needHandle:(BOOL)handle;

- (NSString*)getStringValue:(NSDictionary*)dict :(NSString*)key;
- (NSInteger)getIntegerValue:(NSDictionary*)dict :(NSString*)key;
- (NSInteger)getFloatValue:(NSDictionary*)dict :(NSString*)key;
- (NSInteger)getBoolValue:(NSDictionary*)dict :(NSString*)key;

@end
