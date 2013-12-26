//
//  UIAllTeamViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-21.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIAllTeamViewController.h"
#import "UICommonView.h"
#import "UISelSearchView.h"
#import "GolfTeamModel.h"
#import "UIGolfTeamCell.h"
#import "UITeamInfoViewController.h"

@interface UIAllTeamViewController ()
{
    UICommonView        *_comView;
    UISelSearchView     *_selSearchView;
    UITableView         *_allTeamList;
    
    GolfTeamModel       *_teamModel;
    NSArray             *_allTeamArray;
}

@property (nonatomic, retain)NSArray *allTeamArray;

@end

@implementation UIAllTeamViewController

@synthesize allTeamArray = _allTeamArray;

- (void)dealloc
{
    [_comView release];
    [_selSearchView release];
    [_allTeamList release];
    
    [_teamModel release];
    [_allTeamArray release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    _comView = [[UICommonView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [_comView setTitleText:@"所有球队"];
    [_comView setRightText:@"创建球队"];
    self.view = _comView;
    
    _selSearchView = [[UISelSearchView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, 39)];
    [_selSearchView.leftButton addTarget:self action:@selector(citySelectedBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_selSearchView.rightButton addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selSearchView];
    
    NSInteger table_y = _selSearchView.frame.origin.y + _selSearchView.frame.size.height;
    NSInteger height = self.view.frame.size.height - table_y;
    _allTeamList = [[UITableView alloc] initWithFrame:CGRectMake(0, table_y, 320, height)];
    _allTeamList.dataSource = self;
    _allTeamList.delegate = self;
    [self.view addSubview:_allTeamList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self requestTeamList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestTeamList
{
    if (_teamModel == nil) {
        _teamModel = [[GolfTeamModel alloc] init];
        _teamModel.delegate = self;
        [_teamModel setDidFinishSelector:@selector(requestFinish::)];
        [_teamModel setDidFailedSelector:@selector(requestFailed::)];
    }
    [_teamModel requestAllTeamList:@"北京" :0 :100];
    [_comView showProgessHUD:@"正在获取所有球队列表，请稍候..."];
}

- (void)requestFinish:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        if ([method isEqualToString:KAllTeamList]) {
            self.allTeamArray = [_teamModel getTeamArray:[dictionary objectForKey:@"data"]];
            [_allTeamList reloadData];
        }
    }
    else {
        [_comView showAlertMessage:msg];
    }
}

- (void)requestFailed:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    NSString *msg = [dictionary objectForKey:@"retText"];
    [_comView showAlertMessage:msg];
}

#pragma mark - button delegate

- (void)citySelectedBtnClicked:(id)sender
{
    [_selSearchView showButtonFocus];
}

- (void)searchBtnClicked:(id)sender
{
    [_selSearchView showTextFieldHidden:NO];
    _selSearchView.textField.delegate = self;
    [_selSearchView.textField addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_selSearchView.textField resignFirstResponder];
    [_selSearchView showTextFieldHidden:YES];;
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)textEditingChanged:(UITextField *)textField
{
    //    if(_maxInputCount == 0)
    //        return;
    //
    //    if ([textField.text length] > _maxInputCount)
    //    {
    //        textField.text=[textField.text substringToIndex:_maxInputCount];
    //    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allTeamArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIGolfPlayerCell";
    UIGolfTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UIGolfTeamCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int row = [indexPath row];
    GolfTeamInfo *info = nil;
    info = [_allTeamArray objectAtIndex:row];
    cell.nameLabel.text = info.name;
    [cell setDesText:info.count :info.city];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    GolfTeamInfo *info = nil;
    info = [_allTeamArray objectAtIndex:row];
    UITeamInfoViewController *controller = [[UITeamInfoViewController alloc] init];
    controller.teamInfo = info;
    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
    [controller release];
    
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.5f];
}

@end
