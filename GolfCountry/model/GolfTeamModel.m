//
//  GolfTeamModel.m
//  GolfCountry
//
//  Created by xijun on 13-12-15.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "GolfTeamModel.h"

@implementation GolfTeamInfo

@synthesize userId, creatorId, count, isMember,canEdit;
@synthesize contacts, phone, name, logo, city, createdDate, purpose, description;

- (void)dealloc
{
    self.contacts = nil;
    self.phone = nil;
    self.name = nil;
    self.logo = nil;
    self.city = nil;
    self.createdDate = nil;
    self.purpose = nil;
    self.description = nil;
    
    [super dealloc];
}

@end

@implementation createTeamStruct

@synthesize teamId;
@synthesize teamName, city, logoUrl, contacts, phone, createdDate, purpose, description;

- (void)dealloc
{
    self.teamName = nil;
    self.city = nil;
    self.logoUrl = nil;
    self.contacts = nil;
    self.phone = nil;
    self.createdDate = nil;
    self.purpose = nil;
    self.description = nil;
    
    [super dealloc];
}

@end

@implementation GolfTeamModel

- (void)requestAllTeamList:(NSString *)city :(NSInteger)offset :(NSInteger)limit
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/list", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"city=%@&offset=%d&limit=%d", city, offset, limit];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    [self sendRequest:requestStr method:KAllTeamList param:postParam];
}

- (void)requestJoinTeamList:(NSInteger)offset :(NSInteger)limit
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/joinList", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"offset=%d&limit=%d", offset, limit];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    [self sendRequest:requestStr method:KJoinTeamList param:postParam];
}

- (void)requestCreatedTeamList:(NSInteger)offset :(NSInteger)limit
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/createdList", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"offset=%d&limit=%d", offset, limit];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    [self sendRequest:requestStr method:KCreatedTeamList param:postParam];
}

- (void)requestTeamInfo:(NSInteger)teamId
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/show", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"id=%d", teamId];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    [self sendRequest:requestStr method:KMethodTeamInfo param:postParam];
}

- (void)requestCreateTeam:(createTeamStruct *)ctStruct
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/create", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"name=%@&city=%@&logo=%@&contacts=%@&phone=%@&createdDate=%@&purpose=%@&description=%@", ctStruct.teamName, ctStruct.city, ctStruct.logoUrl, ctStruct.contacts, ctStruct.phone, ctStruct.createdDate, ctStruct.purpose, ctStruct.description];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    [self sendRequest:requestStr method:KMethodCreateTeam param:postParam];
}

- (void)requestEditTeam:(createTeamStruct *)ctStruct
{
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/edit", SERVER_NAME];
    NSMutableString *postParam = [NSMutableString stringWithFormat:@"id=%dname=%@city=%@logo=%@contacts=%@phone=%@purpose=%@description=%@", ctStruct.teamId, ctStruct.teamName, ctStruct.city, ctStruct.logoUrl, ctStruct.contacts, ctStruct.phone, ctStruct.purpose, ctStruct.description];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    [self sendRequest:requestStr method:KMethodCreateTeam param:postParam];
}

- (void)requestUploadTeamLogo:(NSString *)fileName
{
    NSLog(@"fileName=%@", fileName);
    
    NSString *requestStr = [NSString stringWithFormat:@"%@/v1/team/uploadPhoto", SERVER_NAME];
    NSMutableString *postParam = [[NSMutableString alloc] init];
    NSString *token = [GolfPersonInfo defaultPersonInfo].token;
    if ([token length] > 0) {
        [postParam appendFormat:@"&token=%@", token];
    }
    
    NSURL *requestURL = [NSURL URLWithString:requestStr];
    ASIFormDataRequest *asiHttpReq = [[ASIFormDataRequest alloc] initWithURL:requestURL];
    [asiHttpReq setTimeOutSeconds:60];
    [asiHttpReq setPostFormat:ASIMultipartFormDataPostFormat];
    asiHttpReq.userInfo = [NSDictionary dictionaryWithObject:KTeamUploadLogo forKey:@"Method"];
    [self setHttpHeaders:asiHttpReq];
    
    NSString *sign = [self getSign:postParam];
    if (sign) {
        [postParam appendFormat:@"&sign=%@", sign];
    }
    [asiHttpReq appendPostData:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (fileName) {
//        [asiHttpReq setPostValue:@"TeamLogo" forKey:@"name"];
//        [asiHttpReq setFile:fileName forKey:@"photos"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:fileName];
        [asiHttpReq addData:imgData withFileName:@"currentImage.jpg" andContentType:@"image/jpeg" forKey:@"photos"];
        [asiHttpReq buildPostBody];
    }
    
    [asiHttpReq setDelegate:self];
    [asiHttpReq setDidFinishSelector:@selector(requestFinish:)];
    [asiHttpReq setDidFailSelector:@selector(requestFailed:)];
    
    NSLog(@"%@", [asiHttpReq requestHeaders].description);
    NSLog(@"%@", [asiHttpReq postBody].description);
    
    [asiHttpReq startAsynchronous];
    [asiHttpReq release];
//    [postParam release];
}

- (void)requestFinish:(ASIHTTPRequest *)request
{
    NSString *method = [request.userInfo objectForKey:@"Method"];
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *responseStr = [request responseString];
    NSLog(@"%@", responseStr);
    NSDictionary *dic = [self transferJSONToDic:responseStr];
    if (dic != nil) {
        if (self.delegate && [self.delegate respondsToSelector:didFinishSelector]) {
            [self.delegate performSelector:didFinishSelector withObject:dic withObject:method];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (self.delegate && [self.delegate respondsToSelector:didFailedSelector]) {
        NSDictionary *retDic       = [NSDictionary dictionaryWithObject:@"连接服务器失败!" forKey:@"retText"];
        [self.delegate performSelector:didFailedSelector withObject:retDic];
    }
}

- (NSArray*)getTeamArray:(NSArray *)dataArray
{
    if (dataArray == KGolfNull || [dataArray count] <= 0) {
        return nil;
    }
    NSMutableArray *teamArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dataArray) {
        GolfTeamInfo *info = [[GolfTeamInfo alloc] init];
        info.userId = [[dict objectForKey:@"id"] integerValue];
        info.creatorId = [[dict objectForKey:@"creatorId"] integerValue];
        info.contacts = [dict objectForKey:@"contacts"];
        info.phone = [dict objectForKey:@"phone"];
        info.name = [dict objectForKey:@"name"];
        info.logo = [dict objectForKey:@"logo"];
        info.city = [dict objectForKey:@"city"];
        info.createdDate = [self getStringValue:dict :@"createdDate"];
        info.purpose = [self getStringValue:dict :@"purpose"];
        info.description = [self getStringValue:dict :@"description"];
        info.count = [self getIntegerValue:dict :@"count"];
        info.isMember = [self getIntegerValue:dict :@"isMember"];
        info.canEdit = [self getIntegerValue:dict :@"canEdit"];
        
        [teamArr addObject:info];
        [info release];
    }
    
    return [teamArr autorelease];
}

@end
