//
//  NSCsvParse.m
//  JOY
//
//  Created by  on 12-5-21.
//  Copyright (c) 2012年 Pica. All rights reserved.
//

#import "NSCsvParse.h"


@implementation CityInfo
@synthesize strCityID=_strCityID, strCityName = _strCityName;
@synthesize strCityNameCN =_strCityNameCN, strCityNameEN = _strCityNameEN;
@synthesize strCityOrderNO =_strCityOrderNO, strCityCoder = _strCityCoder;

-(id)initWithArray:(NSArray *)array
{
    if (self = [super init])
    {
        self.strCityID = [array objectAtIndex:CityID];
        self.strCityName = [array objectAtIndex:Name];
        self.strCityNameCN = [array objectAtIndex:NameCN];
        self.strCityNameEN = [array objectAtIndex:NameEN];
        self.strCityOrderNO = [array objectAtIndex:OrderNo];
        self.strCityCoder = [array objectAtIndex:Coder];
               
    }
    return self;
}
//mArrayCityNamepy


-(BOOL)matchKey:(NSString*)keyword
{
	if(!keyword)
		return FALSE;	

	//对比原串
    if (0 != [self.strCityNameEN rangeOfString:keyword options:NSCaseInsensitiveSearch].length) 
    {
        return TRUE;
	}
    
	if (0 != [self.strCityNameCN rangeOfString:keyword options:NSCaseInsensitiveSearch].length) 
    {
        return TRUE;
	}
	
	return FALSE;
}

- (void)dealloc
{
    self.strCityID = nil;
    self.strCityName = nil;
    self.strCityNameCN = nil;
    self.strCityNameEN = nil;
    self.strCityOrderNO = nil;
    self.strCityCoder = nil;
    [super dealloc];
}

@end

@implementation NSCsvParse

-(void)paserCsvFileForData:(NSArray*)array
{
    if (_arrayItems)
    {
        [_arrayItems removeAllObjects];
    }
    else
        _arrayItems = [[NSMutableArray alloc] init];
    
   

    for (int i = 1; i < [array count]; i++)
    {
        NSString *str = [array objectAtIndex:i];
        /*去除"\n"*/
        NSString *strFormat = [str substringToIndex:[str length]-1];
        NSArray *arrayCityInfo = [strFormat componentsSeparatedByString:@","];
        CityInfo *cityInfo = [[CityInfo alloc] initWithArray:arrayCityInfo];
        [_arrayItems addObject:cityInfo];
        [cityInfo release];
    } 
}


-(BOOL)paserCsvFile:(NSString *)strPath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL bFileExists = [fileManager fileExistsAtPath:strPath];

    if (!bFileExists)
    {
        return NO;
    }
    
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000); 
  
    NSString *str = [[NSString alloc] initWithContentsOfFile:strPath encoding:encode error:nil];
    NSArray *array = [str componentsSeparatedByString:@"\n"];
   
    [self paserCsvFileForData:array];

    
    [str release];
    
    return YES;

}

-(NSArray *)getArrayCityInfos
{
    return self->_arrayItems;
}

-(void)dealloc
{
    [_arrayItems release];
    [super dealloc];
}


@end
