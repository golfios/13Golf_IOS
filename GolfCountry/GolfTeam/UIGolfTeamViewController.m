//
//  UIGolfTeamViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-15.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfTeamViewController.h"
#import "UICommonView.h"
#import "UISelSearchView.h"
#import "GolfTeamModel.h"
#import "UIGolfTeamCell.h"
#import "UIIconTextButton.h"
#import "UICreateTeamViewController.h"
#import "UIAllTeamViewController.h"
#import "UITeamInfoViewController.h"
#import "UITeamLeaderViewController.h"

@interface UIGolfTeamViewController ()
{
    UICommonView        *_comView;
    UISelSearchView     *_selSearchView;
    UIIconTextButton    *_createTeamBtn;
    UITableView         *_joinTeamList;
    UITableView         *_createdList;
    
    GolfTeamModel       *_teamModel;
    NSArray             *_joinTeamArray;
    NSArray             *_createdArray;
}

@property (nonatomic, retain)NSArray *joinTeamArray;
@property (nonatomic, retain)NSArray *createdArray;

@end

@implementation UIGolfTeamViewController

@synthesize joinTeamArray = _joinTeamArray;
@synthesize createdArray = _createdArray;

- (void)dealloc
{
    [_comView release];
    [_selSearchView release];
    [_createTeamBtn release];
    [_joinTeamList release];
    
    [_teamModel release];
    [_joinTeamArray release];
    [_createdArray release];
    
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
    [_comView setTitleText:@"我的球队"];
    [_comView setRightText:@"所有球队"];
    [_comView.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view = _comView;
    
    _selSearchView = [[UISelSearchView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, 39)];
    [_selSearchView setLeftText:@"加入的球队"];
    [_selSearchView setRightText:@"创建的球队"];
    [_selSearchView.leftButton addTarget:self action:@selector(joinTeamBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_selSearchView.rightButton addTarget:self action:@selector(createBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selSearchView];
    
    NSInteger table_y = _selSearchView.frame.origin.y + _selSearchView.frame.size.height;
    NSInteger height = self.view.frame.size.height - table_y - 40;
    _joinTeamList = [[UITableView alloc] initWithFrame:CGRectMake(0, table_y, 320, height)];
    _joinTeamList.dataSource = self;
    _joinTeamList.delegate = self;
    [self.view addSubview:_joinTeamList];
    
    _createdList = [[UITableView alloc] initWithFrame:CGRectMake(0, table_y, 320, height)];
    _createdList.hidden = YES;
    _createdList.dataSource = self;
    _createdList.delegate = self;
    [self.view addSubview:_createdList];
    
    _createTeamBtn = [[UIIconTextButton alloc] initWithFrame:CGRectMake(0, table_y+height, 320, 40)];
    [_createTeamBtn setBackgroundImage:[UIImage imageNamed:@"myTeam_08.png"] forState:UIControlStateNormal];
    [_createTeamBtn resetControlRect];
    _createTeamBtn.icon.image = [UIImage imageNamed:@"myTeam_03(2).png"];
    _createTeamBtn.titleLabel.text = @"创建新球队";
    [_createTeamBtn addTarget:self action:@selector(newTeamBtnDown:) forControlEvents:UIControlEventTouchDown];
    [_createTeamBtn addTarget:self action:@selector(newTeamBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_createTeamBtn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setCreateTeamBtnContent:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self requestTeamList];
}

- (void)requestTeamList
{
    if (_teamModel == nil) {
        _teamModel = [[GolfTeamModel alloc] init];
        _teamModel.delegate = self;
        [_teamModel setDidFinishSelector:@selector(requestFinish::)];
        [_teamModel setDidFailedSelector:@selector(requestFailed::)];
    }
    [_teamModel requestJoinTeamList:0 :100];
    [_comView showProgessHUD:@"正在获取加入的球队列表，请稍候..."];
}

- (void)requestFinish:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        if ([method isEqualToString:KJoinTeamList]) {
            self.joinTeamArray = [_teamModel getTeamArray:[dictionary objectForKey:@"data"]];
            [_joinTeamList reloadData];
        }
        else if ([method isEqualToString:KCreatedTeamList]) {
            self.createdArray = [_teamModel getTeamArray:[dictionary objectForKey:@"data"]];
            [_createdList reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button delegate

- (void)rightButtonClicked:(id)sender
{
    UIAllTeamViewController *controller = [[UIAllTeamViewController alloc] init];
    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
    [controller release];
}

- (void)joinTeamBtnClicked:(id)sender
{
    [_selSearchView showButtonFocus];
    _joinTeamList.hidden = NO;
    _createdList.hidden = YES;
}

- (void)createBtnClicked:(id)sender
{
    [_selSearchView showRightBtnFocus];
    _joinTeamList.hidden = YES;
    _createdList.hidden = NO;
    
    if (_createdArray == nil) {
        [_teamModel requestCreatedTeamList:0 :100];
        [_comView showProgessHUD:@"正在获取我创建的球队列表，请稍候..."];
    }
}

- (void)newTeamBtnDown:(id)sender
{
    [self setCreateTeamBtnContent:YES];
}

- (void)newTeamBtnClicked:(id)sender
{
    UICreateTeamViewController *controller = [[UICreateTeamViewController alloc] init];
    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
}

- (void)setCreateTeamBtnContent:(BOOL)isFocus
{
    if (isFocus) {
        _createTeamBtn.icon.image = [UIImage imageNamed:@"myTeam_03-06.png"];
        _createTeamBtn.titleLabel.textColor = [Utility hexStringToColor:@"71B92C"];
    }
    else {
        _createTeamBtn.icon.image = [UIImage imageNamed:@"myTeam_03(2).png"];
        _createTeamBtn.titleLabel.textColor = [Utility hexStringToColor:@"ABABAB"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _joinTeamList) {
        return [_joinTeamArray count];
    }
    else if (tableView == _createdList) {
        return [_createdArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIGolfTeamCell";
    UIGolfTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UIGolfTeamCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int row = [indexPath row];
    GolfTeamInfo *info = nil;
    if (tableView == _joinTeamList) {
        info = [_joinTeamArray objectAtIndex:row];
    }
    else if (tableView == _createdList) {
        info = [_createdArray objectAtIndex:row];
    }
    cell.joinButton.hidden = YES;
    cell.arrowView.hidden = NO;
    cell.nameLabel.text = info.name;
    [cell setDesText:info.count :info.city];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    GolfTeamInfo *info = nil;
    if (tableView == _joinTeamList) {
        info = [_joinTeamArray objectAtIndex:row];
        UITeamInfoViewController *controller = [[UITeamInfoViewController alloc] init];
        controller.teamInfo = info;
        [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
        [controller release];
    }
    else if (tableView == _createdList) {
        info = [_createdArray objectAtIndex:row];
        UITeamLeaderViewController *controller = [[UITeamLeaderViewController alloc] init];
        controller.teamInfo = info;
        [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
        [controller release];
    }
    
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.5f];
}

@end
