//
//  UICitySelectController.m
//  GolfCountry
//
//  Created by pple a on 12-4-20.
//  Copyright (c) 2012年 Pica. All rights reserved.
//

#import "UICitySelectController.h"
#import "AppDelegate.h"
#import "UICommonView.h"

#define SIGNAL_TEXTFIELD_TAG    202

@interface UICitySelectController ()
{
}

-(void)initHeadView;

@end


@implementation UICitySelectController

@synthesize cityList = _cityList;
@synthesize cityTableView = _cityTableView;
@synthesize selectedCity = _selectedCity;
@synthesize delegate = _delegate,tag = _tag;
@synthesize dicCityGroup = _dicCityGroup,dicSearchCityGroup = _dicSeachCityGroup;
@synthesize serachRusultGroup = _searchResultGroup;
@synthesize bIsLimitedCity;

@synthesize cityName;

- (id)init
{
    if (self == [super init]) {
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_cityList release];
    _cityList = nil;
    
    [_dicCityGroup release];
    _dicCityGroup = nil;
    
    [_listGroup release];
    _listGroup = nil;
    
    [_cityTableView release];
    _cityTableView = nil;
    
    [_searchResultTableView release];
    _searchResultTableView = nil;
    
    [_searchResultGroup release];
    _searchResultGroup = nil;
    
    [_dicSeachCityGroup release];
    _dicSeachCityGroup = nil;
}

-(void)dealloc
{
    [_mDicSelectCityInfo release];
    [_selectedCity release];
    [_cityList release];
    [_cityTableView release];
    [_listGroup release];
    [_dicCityGroup release];
    [_searchResultTableView release];
    [_searchResultGroup release];
    [_dicSeachCityGroup release];
    [_signalCitySearch  release];
    
    self.cityName = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)initHeadView
{
    //到达城市搜索栏
    _signalCitySearch = [[UINewSearchView alloc] initWithFrame:CGRectMake(10, 50, 300, 45)];
    _signalCitySearch.searchTextField.placeholder = @"输入城市或拼音";
    _signalCitySearch.searchTextField.delegate = self;
    if (cityName) {
        _signalCitySearch.searchTextField.text = self.cityName;
    }
    _signalCitySearch.searchTextField.tag = SIGNAL_TEXTFIELD_TAG;
    [_signalCitySearch.searchTextField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_signalCitySearch];
    
    _tableViewY = 100;
}

- (void)loadView;
{
    UICommonView *comView = [[UICommonView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [comView setBackgroundImage:nil];
    comView.backgroundColor = [Utility hexStringToColor:@"EBEFEB"];
    [comView.topTitle setText:@"选择城市"];
    comView.rightButton.hidden = YES;
    self.view = comView;
    [comView release];
    
    [self initHeadView];
    
    //所有结果列表
    _cityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _tableViewY, self.view.frame.size.width, self.view.frame.size.height-_tableViewY) style:UITableViewStylePlain];
    _cityTableView.delegate=self;
    _cityTableView.dataSource=self;
    _cityTableView.tag = 100;
    _cityTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_cityTableView];
    
    //查询结果列表
    _searchResultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _tableViewY, self.view.frame.size.width, self.view.frame.size.height-_tableViewY) style:UITableViewStylePlain];
    _searchResultTableView.tag = 101;
    _searchResultTableView.delegate=self;
    _searchResultTableView.dataSource=self;
    _searchResultTableView.backgroundColor=[UIColor clearColor];
    
    _searchResultGroup = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_cityList == nil) {        
        NSBundle *boudle = [NSBundle mainBundle];
        NSString *strCsvFile = [boudle pathForResource:@"热门城市" ofType:@"csv"];
        NSCsvParse *parse = [[NSCsvParse alloc] init];
        [parse paserCsvFile:strCsvFile];
        _cityList = [[NSMutableArray alloc] initWithArray:[parse getArrayCityInfos]];
        [parse release];
    }
    
    _dicCityGroup = [[NSMutableDictionary alloc] init];
    for (CityInfo *info in _cityList)
    {
        NSString *strChar = [info.strCityNameEN substringToIndex:1];
        NSMutableArray *array = [_dicCityGroup objectForKey:strChar];
        if (nil == array)
        {
            array = [NSMutableArray arrayWithObject:info];
            [_dicCityGroup setValue:array forKey:strChar];
        }
        else
            [array addObject:info];
    }
    
    NSArray *listGroup = [_dicCityGroup allKeys];
    listGroup = [listGroup sortedArrayUsingSelector:@selector(compare:)];
    _listGroup = [[NSMutableArray alloc] initWithArray:listGroup];
    if (self.bIsLimitedCity == NO) {
        [_listGroup insertObject:@"热门城市" atIndex:0];
        [self addHotCitys];
    }
    
    [_dicCityGroup setObject:_cityList forKey:@"hot"];
    
    _mDicSelectCityInfo = [[NSMutableDictionary alloc]initWithCapacity:0];
}

- (void)addHotCitys
{
    NSArray *hotCityStrings = [NSArray arrayWithObjects:@"北京", @"上海", @"深圳", @"广州", @"杭州", @"成都", @"西安", @"南京", @"重庆", @"长沙", @"沈阳", @"海口", @"武汉", @"青岛", @"大连", @"贵阳", @"福州", @"郑州", @"济南", @"太原", nil];
    NSMutableArray *hotCitys = [[NSMutableArray alloc] initWithCapacity:5];
    for (NSString *cityStr in hotCityStrings) {
        CityInfo *cityInfo = [UICitySelectController getCityInfoByName:cityStr];
        [hotCitys addObject:cityInfo];
    }
    [_dicCityGroup setValue:hotCitys forKey:@"热门城市"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark tableView Delegate

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
#if 0
    NSInteger tag = tableView.tag;
    
    if (tag == 100) {
        return [_cityList count];
    }
    else
    {
        NSString *key = nil;
        if([_searchResultGroup count] <= 0) return 0;
        
        key = [_searchResultGroup objectAtIndex:0];
        NSArray *arrayCity = [_dicSeachCityGroup objectForKey:key];
        return [arrayCity count];
    }
#else  
    
    NSInteger tag = tableView.tag;
    NSString *key = nil;
    NSArray *arrayCity = nil;
    if (tag == 100) {
        key = [_listGroup objectAtIndex:section];
        arrayCity = [_dicCityGroup objectForKey:key];
    }
    else if ([_searchResultGroup count] > 0)
    {
        key = [_searchResultGroup objectAtIndex:section];
        arrayCity = [_dicSeachCityGroup objectForKey:key];
    }
    return [arrayCity count];
    
#endif
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    return 1;
    
    NSInteger tag = tableView.tag;
    if (tag == 100) {
        return [_listGroup count];
    }
    else
    {
        return [_searchResultGroup count];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    NSInteger tag = tableView.tag; 
	NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
	
    static NSString * identifier = @"CityIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if( cell == nil )
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
        cell.backgroundColor=[UIColor clearColor];
        
        UIFont *myFont = [ UIFont fontWithName: @"American Typewriter" size: 18.0 ];
        cell.textLabel.font  = myFont;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSString *key = nil;
    NSArray *arrayCity = nil;
    if (tag == 100) {
        key = [_listGroup objectAtIndex:section];
        arrayCity = [_dicCityGroup objectForKey:key];
//        arrayCity = _cityList;
    }
    else
    {
        key = [_searchResultGroup objectAtIndex:section];
        arrayCity = [_dicSeachCityGroup objectForKey:key];
    }
    
    CityInfo *info = [arrayCity objectAtIndex:row];
    cell.textLabel.text = info.strCityNameCN;
    
	return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    return @"热门城市";
    
    NSInteger tag = tableView.tag;
    if (tag == 100) {
        return [_listGroup objectAtIndex:section];
    }
    else
    {
        return [_searchResultGroup objectAtIndex:section];
    }
}

#if 1
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSInteger tag = tableView.tag;
    if (tag == 100) {
        return _listGroup;
    }
    else
    {
        return _searchResultGroup;
    }
}
#endif

//选择城市
-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSString *key;
    NSArray *arrayCity;
    CityInfo *info;
    
    if(tableView == _cityTableView)  //点击包含所有城市的table
    {
        key = [_listGroup objectAtIndex:section];
        arrayCity = [_dicCityGroup objectForKey:key];
        info = [arrayCity objectAtIndex:row];
    }
    else if(tableView == _searchResultTableView) //点击搜索结果的tableView
    {
        key = [_searchResultGroup objectAtIndex:section];
        arrayCity = [_dicSeachCityGroup objectForKey:key];
        info = [arrayCity objectAtIndex:row];
    }
    
    BOOL ret = [_delegate citySelectController:self selectCity:info];
    if (ret == YES)
    {
        [[AppDelegate shareAppDelegate].navigation popViewControllerAnimated:YES];
    }
}

+ (CityInfo*)getCityInfoByName:(NSString*)cityName
{
    CityInfo* cityInfo = nil;
    
    NSBundle *boudle = [NSBundle mainBundle];
    NSString *strCsvFile = [boudle pathForResource:@"热门城市" ofType:@"csv"];
    NSCsvParse *parse = [[NSCsvParse alloc] init];
    [parse paserCsvFile:strCsvFile];
    NSMutableArray* cityList = [[NSMutableArray alloc] initWithArray:[parse getArrayCityInfos]];
    [parse release];
        
    for (CityInfo *city in cityList)
    {    
        if ([city.strCityNameCN isEqualToString:cityName]) 
        {
            cityInfo = [city retain];
            break;
        }
    }
    
    [cityList release];
    
    return cityInfo;
}

+ (CityInfo*)getCityInfoById:(NSString *)cityId
{
    CityInfo* cityInfo = nil;
    
    NSBundle *boudle = [NSBundle mainBundle];
    NSString *strCsvFile = [boudle pathForResource:@"热门城市" ofType:@"csv"];
    NSCsvParse *parse = [[NSCsvParse alloc] init];
    [parse paserCsvFile:strCsvFile];
    NSMutableArray* cityList = [[NSMutableArray alloc] initWithArray:[parse getArrayCityInfos]];
    [parse release];
    
    for (CityInfo *city in cityList)
    {
        if ([city.strCityID isEqualToString:cityId]) 
        {
            cityInfo = [city retain];
            break;
        }
    }
    
    [cityList release];
    
    return cityInfo;
}

+ (CityInfo*)getCityInfoByCoder:(NSString *)cityCoder
{
    CityInfo* cityInfo = nil;
    
    NSBundle *boudle = [NSBundle mainBundle];
    NSString *strCsvFile = [boudle pathForResource:@"热门城市" ofType:@"csv"];
    NSCsvParse *parse = [[NSCsvParse alloc] init];
    [parse paserCsvFile:strCsvFile];
    NSMutableArray* cityList = [[NSMutableArray alloc] initWithArray:[parse getArrayCityInfos]];
    [parse release];
    
    for (CityInfo *city in cityList)
    {
        if ([city.strCityCoder isEqualToString:cityCoder]) 
        {
            cityInfo = [city retain];
            break;
        }
    }
    
    [cityList release];
    
    return cityInfo;
}

#pragma mark -   － custome method

-(void)rigthButtonDown
{
    if(_delegate && [_mDicSelectCityInfo count] > 0)
    {
        BOOL ret = [_delegate citySelectController:self selectCityFinish:_mDicSelectCityInfo];
        if (ret == YES)
        {
            [[AppDelegate shareAppDelegate].navigation popViewControllerAnimated:YES];
        }
    }
}

- (void)addAllCityTable
{
    for (UIView *view in self.view.subviews) {
        if (view.tag == 100) {
            return;
        }
        if (view.tag == 101) {
            [view removeFromSuperview];
        }
    }
    [self.view addSubview:_cityTableView];
}

#pragma mark -  － 搜索处理

//搜索,将搜索结果在_searchResultTableView中显示
-(void)handleSearchForTerm:(NSString *)searchTerm
{
    _searchResultGroup = [[NSMutableArray alloc] init];
    _dicSeachCityGroup = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in _listGroup) {
        
        NSMutableArray *array = [_dicCityGroup valueForKey:key];
        
        NSMutableArray *toAdd = [[NSMutableArray alloc] init];
        
        for (CityInfo *city in array) {
            
            if ([city matchKey:searchTerm]) 
            {
                [toAdd addObject:city];
            }
        }
        
        if ([toAdd count] != 0) {
            [_searchResultGroup addObject:key];
            [_dicSeachCityGroup setObject:toAdd forKey:key];
        }
        [toAdd release];
    }
    
    [self.view addSubview:_searchResultTableView];
    [_cityTableView removeFromSuperview];
    [_searchResultTableView reloadData];
}

-(IBAction)textFieldDoneEditing:(id)sender   // called when text changes (including clear)
{
    UITextField *textField = (UITextField*)sender;
    if ([textField.text length] == 0) {
        [textField resignFirstResponder];
        [_searchResultTableView removeFromSuperview];
        [self.view addSubview:_cityTableView];
    }
    else
    {
        [self handleSearchForTerm:textField.text];
    }
}

//键盘search按键
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == SIGNAL_TEXTFIELD_TAG)
    {
        [self addAllCityTable];
    }
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)citySelectController:(UICitySelectController *)citySelectController selectCityFinish:(NSDictionary *)dicSelectedCity
{
    return YES;
}

@end
