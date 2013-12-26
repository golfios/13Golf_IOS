//
//  NSCsvParse.h
//  JOY
//
//  Created by  on 12-5-21.
//  Copyright (c) 2012年 Pica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityInfo : NSObject {
@private
    NSString *_strCityID;
    NSString *_strCityName;
    NSString *_strCityNameCN;
    NSString *_strCityNameEN;
    NSString *_strCityOrderNO;
    NSString *_strCityCoder;
    
    enum
    {
        CityID = 0,
        Name,
        NameCN,
        NameEN,
        OrderNo,
        Coder,
    };
    
}

@property (nonatomic, copy)NSString *strCityID;
@property (nonatomic, copy)NSString *strCityName;
@property (nonatomic, copy)NSString *strCityNameCN;
@property (nonatomic, copy)NSString *strCityNameEN;
@property (nonatomic, copy)NSString *strCityOrderNO;
@property (nonatomic, copy)NSString *strCityCoder;

-(id)initWithArray:(NSArray *)array;
-(BOOL)matchKey:(NSString*)keyword;
-(void)dealloc;

@end




@interface NSCsvParse : NSObject
{
    NSMutableArray *_arrayItems;
    
}
-(BOOL)paserCsvFile:(NSString *)strPath;
-(NSArray *)getArrayCityInfos;

@end
