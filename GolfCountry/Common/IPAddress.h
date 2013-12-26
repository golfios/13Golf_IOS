//
//  IPAddress.h
//  DTC_YGJT
//
//  Created by xijun on 13-5-13.
//  Copyright (c) 2013年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddress : NSObject


// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *)getMacAddress;


@end
