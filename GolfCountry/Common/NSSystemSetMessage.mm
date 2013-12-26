//
//  NSSystemSetMessage.m
//  JOY
//
//  Created by Zheng Xu on 12-5-15.
//  Copyright (c) 2012年 Pica. All rights reserved.
//

#import "NSSystemSetMessage.h"


@interface NSSystemSetMessage()

-(NSString*)getDataFilePath;

-(void)getLoadFileData;

@end

static NSSystemSetMessage* defaultInstance = nil;

@implementation NSSystemSetMessage
@synthesize username = _username,password = _password;

@synthesize hotelRadius = _hotelRadius,hotelImageShow = _hotelImageShow;
@synthesize firstLauch = _firstLauch,rememberPwd = _rememberPwd,isLogin = _isLogin;

@synthesize leaveCity = _leaveCity,arriveCity = _arriveCity;
@synthesize leaveCityID = _leaveCityID,arriveCityID = _arriveCityID;
@synthesize leaveCityCoder = _leaveCityCoder,arriveCityCoder = _arriveCityCoder;

@synthesize tempLeaveCity = _tempLeaveCity;
@synthesize tempArriveCity = _tempArriveCity;
@synthesize tempLeaveCityCoder = _tempLeaveCityCoder;
@synthesize tempArriveCityCoder = _tempArriveCityCoder;

@synthesize tempHotelCity = _tempHotelCity;
@synthesize tempHotelCityID = _tempHotelCityID;

@synthesize tempWeatherCity = _tempWeatherCity;
@synthesize tempWeatherCityCoder = _tempWeatherCityCoder;

@synthesize bHasNewVersion;
@synthesize versionCode;
@synthesize versionContent;
@synthesize downloadUrl;
@synthesize gradeUrl;

@synthesize bHasTicket       = _bHasTicket;
@synthesize bCommendedHotel  = _bCommendedHotel;
@synthesize bCommendedTravel = _bCommendedTravel;



+(NSSystemSetMessage*)defaultMessage
{
    if(defaultInstance == nil)
    {
        defaultInstance = [[self alloc] init];
    }
    
    return defaultInstance;
}

-(id)init
{
    if(self = [super init])
    {
        _isLogin = NO;
        
        self.versionCode = [NSString stringWithUTF8String:Golf_Version];
        
        _username = [[NSString alloc] init];
        _password = [[NSString alloc] init];
        _leaveCity = [[NSString alloc] init];
        _arriveCity = [[NSString alloc] init];
        _leaveCityID = [[NSString alloc] init];
        _arriveCityID = [[NSString alloc] init];
        _leaveCityCoder = [[NSString alloc] init];
        _arriveCityCoder = [[NSString alloc] init];
        
        _tempLeaveCity = [[NSString alloc] init];
        _tempArriveCity = [[NSString alloc] init];
        _tempLeaveCityCoder = [[NSString alloc] init];
        _tempArriveCityCoder = [[NSString alloc] init];
        
        _tempWeatherCity = [[NSString alloc] init];
        _tempWeatherCityCoder = [[NSString alloc] init];
        
        NSString *filePath = [self getDataFilePath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
        {
            _plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
            [self getLoadFileData];
        }
        else
        {
            _plistDictionary = [[NSMutableDictionary alloc] init];
            _firstLauch = YES;
            _hotelImageShow = YES;
            _leaveCity = @"北京";
            _arriveCity = @"上海";
            _leaveCityCoder = @"BJS";
            _arriveCityCoder = @"SHA";
            _leaveCityID =  @"9445C561D6E52B5BE040FE0A07DC3622";
            _arriveCityID = @"9445C561DBC42B5BE040FE0A07DC3622";
            _rememberPwd = NO;
            _username = @"";
            _password = @"";
            _hotelRadius = 4000;
            
            [self setLoadFileData];
        }
    }
    
    return self;
}

-(NSString*)getUsername
{
    return [_username retain];
}

-(NSString*)getPassword
{
    return [_password retain];
}

-(void)setUsername:(NSString *)username
{
    _username = [username copy];
    if(_isLogin)
    {
        [_plistDictionary setObject:_username forKey:Key_UserName];
        [_plistDictionary setObject:_password forKey:Key_PassWord];
        [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
    }
}


-(void)setPassword:(NSString *)password
{
    _password = [password copy];
    if(_isLogin)
    {
        [_plistDictionary setObject:_username forKey:Key_UserName];
        [_plistDictionary setObject:_password forKey:Key_PassWord];
        [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
    }
}

-(void)setLeaveCity:(NSString *)leaveCity
{
    _leaveCity = leaveCity;
    [_plistDictionary setObject:_leaveCity forKey:Key_leaveCity];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setArriveCity:(NSString *)arriveCity
{
    _arriveCity = arriveCity;
    [_plistDictionary setObject:arriveCity forKey:Key_ArriveCity];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setLeaveCityID:(NSString *)leaveCityID
{
    _leaveCityID = leaveCityID;
    [_plistDictionary setObject:_leaveCityID forKey:Key_leaveCityID];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setArriveCityID:(NSString *)arriveCityID
{
    _arriveCityID = arriveCityID;
    [_plistDictionary setObject:arriveCityID forKey:Key_ArriveCityID];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setLeaveCityCoder:(NSString *)leaveCityCoder
{
    _leaveCityCoder = leaveCityCoder;
    [_plistDictionary setObject:_leaveCityCoder forKey:Key_leaveCityCODER];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setArriveCityCoder:(NSString *)arriveCityCoder
{
    _arriveCityCoder = arriveCityCoder;
    [_plistDictionary setObject:arriveCityCoder forKey:Key_ArriveCityCODER];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setHotelRadius:(NSInteger)hotelRadius
{
    _hotelRadius = hotelRadius;
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",hotelRadius]  forKey:Key_HotelRadius];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setHotelImageShow:(BOOL)hotelImageShow
{
    _hotelImageShow = hotelImageShow;
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_hotelImageShow] forKey:Key_HotelImageShow];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setFirstLauch:(BOOL)firstLauch
{
    _firstLauch = firstLauch;
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_firstLauch] forKey:Key_FirstLaunch];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setRememberPwd:(BOOL)rememberPwd
{
    _rememberPwd = rememberPwd;
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_rememberPwd] forKey:Key_RememberPwd];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    
    if(isLogin)
    {
        [_plistDictionary setObject:_username forKey:Key_UserName];
        [_plistDictionary setObject:_password forKey:Key_PassWord];
        [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
    }
}
 
-(void)addCardCode:(NSString*)strId :(NSString*)strCardCode
{
    [_plistDictionary setObject:strCardCode forKey:strId];
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}

-(NSString*)getCardCode:(NSString*)strId
{
    NSString* cardCode = [_plistDictionary objectForKey:strId];
    return cardCode;
}

-(NSString*)getDataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];    
    return [documentDirectory stringByAppendingPathComponent:LoadFileName];
}

-(void)setLoadFileData
{
    [_plistDictionary setObject:_username forKey:Key_UserName];
    [_plistDictionary setObject:_password forKey:Key_PassWord];
    [_plistDictionary setObject:_leaveCity forKey:Key_leaveCity];
    [_plistDictionary setObject:_arriveCity forKey:Key_ArriveCity];
    [_plistDictionary setObject:_leaveCityID forKey:Key_leaveCityID];
    [_plistDictionary setObject:_arriveCityID forKey:Key_ArriveCityID];
    [_plistDictionary setObject:_leaveCityCoder forKey:Key_leaveCityCODER];
    [_plistDictionary setObject:_arriveCityCoder forKey:Key_ArriveCityCODER];
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_hotelRadius] forKey:Key_HotelRadius];
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_hotelImageShow] forKey:Key_HotelImageShow];
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_firstLauch] forKey:Key_FirstLaunch];
    [_plistDictionary setObject:[NSString stringWithFormat:@"%d",_rememberPwd] forKey:Key_RememberPwd];
    
    [_plistDictionary writeToFile:[self getDataFilePath] atomically:YES];
}


-(void)getLoadFileData
{
    _username = [_plistDictionary objectForKey:Key_UserName];
    _password = [_plistDictionary objectForKey:Key_PassWord];
    _leaveCity = [_plistDictionary objectForKey:Key_leaveCity];
    _arriveCity = [_plistDictionary objectForKey:Key_ArriveCity];
    _leaveCityID = [_plistDictionary objectForKey:Key_leaveCityID];
    _arriveCityID = [_plistDictionary objectForKey:Key_ArriveCityID];
    _leaveCityCoder = [_plistDictionary objectForKey:Key_leaveCityCODER];
    _arriveCityCoder = [_plistDictionary objectForKey:Key_ArriveCityCODER];
    _hotelRadius = [[_plistDictionary objectForKey:Key_HotelRadius] intValue];
    
    if([[_plistDictionary objectForKey:Key_HotelImageShow] isEqualToString:@"0"])
       _hotelImageShow = NO;
    else
        _hotelImageShow = YES;
    
    if([[_plistDictionary objectForKey:Key_FirstLaunch] isEqualToString:@"0"])
        _firstLauch = NO;
    else
        _firstLauch = YES;
    
    if([[_plistDictionary objectForKey:Key_RememberPwd] isEqualToString:@"0"])
        _rememberPwd = NO;
    else
        _rememberPwd = YES;
    
}

-(void)dealloc
{
    [_username release];
    [_password release];
    [_leaveCity release];
    [_arriveCity release];
    [_leaveCityID release];
    [_arriveCityID release];
    [_leaveCityCoder release];
    [_arriveCityCoder release];
    
    [_tempLeaveCity release];
    [_tempArriveCity release];
    [_tempLeaveCityCoder release];
    [_tempArriveCityCoder release];
    
    [_tempHotelCity release];
    [_tempHotelCityID release];
    
    [_tempWeatherCity release];
    [_tempWeatherCityCoder release];
    
    [_plistDictionary release];
    
    self.versionContent = nil;
    self.versionCode = nil;
    self.downloadUrl = nil;
    self.gradeUrl = nil;
    
    [super dealloc];
}

@end
