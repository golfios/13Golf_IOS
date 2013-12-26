//
//  LoginModel.h
//  GolfCountry
//
//  Created by xijun on 13-12-1.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpModelBase.h"

/** 登录注册联网请求 */
@interface LoginModel : HttpModelBase

- (void)requestLoginByAcc:(NSString*)account pwd:(NSString*)pwd;

@end
