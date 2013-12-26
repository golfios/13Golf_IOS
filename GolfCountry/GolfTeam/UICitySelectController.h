//
//  UICitySelectController.h
//  GolfCountry
//
//  Created by pple a on 12-4-20.
//  Copyright (c) 2012年 Pica. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NSCsvParse.h"
#import "UINewSearchView.h"

@protocol UICitySelectControllerDelegate;

@interface UICitySelectController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray        *_cityList;
    UITableView           *_cityTableView;
    UITableView           *_searchResultTableView;
    NSMutableArray        *_listGroup;
    NSString              *_selectedCity;
    NSMutableDictionary   *_dicCityGroup;
    NSInteger             _tag;
    NSMutableArray        *_searchResultGroup;
    NSMutableDictionary   *_dicSeachCityGroup;
    NSMutableDictionary   *_mDicSelectCityInfo;
    
    UINewSearchView       *_signalCitySearch;//选择单个城市时加载
    
    int                   _tableViewY;    //tableView的Y坐标
}

@property(nonatomic,retain) NSMutableArray      *cityList;
@property(nonatomic,retain) UITableView         *cityTableView;
@property(nonatomic,retain) NSString            *selectedCity;
@property(nonatomic,retain) NSMutableDictionary *dicCityGroup,*dicSearchCityGroup;
@property(nonatomic,retain) NSArray             *serachRusultGroup;
@property(nonatomic,assign) id<UICitySelectControllerDelegate> delegate;
@property(nonatomic,assign) NSInteger tag;

@property(nonatomic,assign) BOOL                  bIsLimitedCity;

@property(nonatomic,retain) NSString *cityName;

-(void)handleSearchForTerm:(NSString *)searchTerm;
- (void)addAllCityTable;

+(CityInfo*)getCityInfoByName:(NSString*)cityName;
+(CityInfo*)getCityInfoById:(NSString *)cityId;
+(CityInfo*)getCityInfoByCoder:(NSString *)cityCoder;

@end


@protocol UICitySelectControllerDelegate <NSObject>

@optional

//返回值：YES 符合选择结果 NO 不符合选择结果（重新选择）兼容之前代码
-(BOOL)citySelectController: (UICitySelectController*)citySelectController selectCity:(CityInfo*)selectedCityInfo;


-(BOOL)citySelectController:(UICitySelectController *)citySelectController selectCityFinish:(NSDictionary *)dicSelectedCity;

@end

