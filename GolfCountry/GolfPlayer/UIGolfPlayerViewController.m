//
//  UIGolfPlayerViewController.m
//  GolfCountry
//
//  Created by xijun on 13-12-5.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfPlayerViewController.h"
#import "UICommonView.h"
#import "UISelSearchView.h"
#import "GolfPlayerModel.h"
#import "UIGolfPlayerCell.h"
#import "UIGolfPersonInfoViewController.h"

@interface UIGolfPlayerViewController ()
{
    UICommonView    *_comView;
    UISelSearchView *_selSearchView;
    UITableView     *_playerList;
    
    GolfPlayerModel *_playerModel;
    NSArray         *_playerArray;
}

@property (nonatomic, retain)NSArray *playerArray;

@end

@implementation UIGolfPlayerViewController

@synthesize playerArray = _playerArray;

- (void)dealloc
{
    [_comView release];
    [_selSearchView release];
    [_playerList release];
    
    [_playerModel release];
    [_playerArray release];
    
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
    [_comView setTitleText:@"球手"];
    [_comView setRightText:@"筛选"];
    self.view = _comView;
    
    _selSearchView = [[UISelSearchView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, 39)];
    [_selSearchView.leftButton addTarget:self action:@selector(citySelectedBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_selSearchView.rightButton addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selSearchView];
    
    NSInteger table_y = _selSearchView.frame.origin.y + _selSearchView.frame.size.height;
    NSInteger height = self.view.frame.size.height - table_y;
    _playerList = [[UITableView alloc] initWithFrame:CGRectMake(0, table_y, 320, height)];
    _playerList.dataSource = self;
    _playerList.delegate = self;
    [self.view addSubview:_playerList];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([_playerArray count] > 0) {
        [_playerList reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self requestPlayerList];
}

- (void)requestPlayerList
{
    if (_playerModel == nil) {
        _playerModel = [[GolfPlayerModel alloc] init];
        _playerModel.delegate = self;
        [_playerModel setDidFinishSelector:@selector(requestFinish::)];
        [_playerModel setDidFailedSelector:@selector(requestFailed::)];
    }
    [_playerModel requestPlayerList:0 :0 :100 : nil];
    [_comView showProgessHUD:@"正在获取球手列表，请稍候..."];
}

- (void)requestFinish:(NSDictionary *)dictionary :(NSString*)method
{
    [_comView hideProgessHUD];
    
    NSNumber *status = [dictionary objectForKey:@"status"];
    NSString *msg = [dictionary objectForKey:@"msg"];
    if ([status integerValue] == 200) {
        self.playerArray = [_playerModel getPlayerArray:[dictionary objectForKey:@"data"]];
        [_playerList reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_playerArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIGolfPlayerCell";
    UIGolfPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UIGolfPlayerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int row = [indexPath row];
    GolfPersonInfo *info = [_playerArray objectAtIndex:row];
    cell.nameLabel.text = info.userName;
    [cell setDesText:info.playAge :info.fansCount :info.handicap];
    [cell setFollowText:info.isFollowed];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    GolfPersonInfo *info = [_playerArray objectAtIndex:row];
    UIGolfPersonInfoViewController *controller = [[UIGolfPersonInfoViewController alloc] init];
    controller.personInfo = info;
    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
    
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.5f];
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

@end
