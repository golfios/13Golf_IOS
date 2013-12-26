//
//  RegisterModel.h
//  GolfCountry
//
//  Created by xijun on 13-12-3.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpModelBase.h"

@interface RegisterStruct : NSObject

@property (nonatomic, retain)NSString *phone;   /** 手机号码 */
@property (nonatomic, retain)NSString *userName;/** 用户名称 */
@property (nonatomic, retain)NSString *pwd;     /** 用户密码 */
@property (nonatomic, retain)NSString *device;  /** 设备标识 */
@property (nonatomic, retain)NSString *realName;/** 真实姓名 */
@property (nonatomic, retain)NSString *sfzId;   /** 身份证号 */

@end

@interface RegisterModel : HttpModelBase

- (void)requestRegister:(RegisterStruct *)rsStruct;

@end
