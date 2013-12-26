//
//  PersonModel.h
//  GolfCountry
//
//  Created by xijun on 13-12-7.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpModelBase.h"

/** 个人相关接口 */
@interface PersonModel : HttpModelBase

- (void)requestPersonInfo:(NSInteger)userId;

@end
