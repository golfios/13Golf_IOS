//
//  UIGolfMainViewController.m
//  GolfCountry
//
//  Created by xijun on 13-11-28.
//  Copyright (c) 2013年 hxj. All rights reserved.
//

#import "UIGolfMainViewController.h"
#import "UICommonView.h"
#import "UIGolfPlayerViewController.h"
#import "UIPersonCenterViewController.h"
#import "UIGolfTeamViewController.h"
#import "AppDelegate.h"

#define KTagLogin       1001
#define KTagPerson      1002

@interface UIGolfMainViewController ()
{
    UIScrollView    *_scrollView;
    UICommonView    *_comView;
    NAMenuView      *_menuView;
    NSArray         *_menuItems;
}

@property (nonatomic, retain)NSArray *menuItems;

@end

@implementation UIGolfMainViewController

@synthesize menuItems = _menuItems;

- (void)dealloc
{
    [_scrollView release];
    [_comView release];
    [_menuView release];
    [_menuItems release];
    
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
    [_comView setTitleText:@"Golf-box"];
    _comView.leftButton.hidden = YES;
    [_comView setRightIcon:[UIImage imageNamed:@"search_icon.png"] selected:nil];
    self.view = _comView;
    
    [_comView.leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_comView.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger height = self.view.frame.size.height-[UICommonView getNavHeight]-49;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UICommonView getNavHeight], 320, height)];
    _scrollView.contentSize = CGSizeMake(320, 460);
    [self.view addSubview:_scrollView];
    
    [self initBannerView];
    [self initGridView];
}

- (void)initBannerView
{
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 140)];
    [_scrollView addSubview:bannerView];
    [bannerView release];
    
    CGRect rect = bannerView.bounds;
    UIImageView *bannerBg = [[UIImageView alloc] initWithFrame:rect];
    bannerBg.image = [UIImage imageNamed:@"banner_bg.png"];
    [bannerView addSubview:bannerBg];
    [bannerBg release];
    
    rect.origin.x = 10;
    rect.size.width -= 10*2;
    rect.size.height = 105;
    UIScrollView *bannerScroll = [[UIScrollView alloc] initWithFrame:rect];
    [bannerView addSubview:bannerScroll];
    [bannerScroll release];
    
    UIImageView *bannerImg = [[UIImageView alloc] initWithFrame:bannerScroll.bounds];
    bannerImg.image = [UIImage imageNamed:@"banner.png"];
    [bannerScroll addSubview:bannerImg];
    [bannerImg release];
}

- (void)initGridView
{
    _menuView = [[NAMenuView alloc] initWithFrame:CGRectMake(20, 150, 270, 300)];
    [_menuView setBackgroundImage:[UIImage imageNamed:@"box_bg.png"]];
    _menuView.menuDelegate = self;
    [_scrollView addSubview:_menuView];
    
    self.menuItems = [self createMenuItems];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_menuView changeImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - button action

- (void)leftButtonClicked:(id)sender
{
    UIPersonCenterViewController *controller = [[UIPersonCenterViewController alloc] init];
    [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
    [controller release];
}

- (void)rightButtonClicked:(id)sender
{
    [_comView showTextField];
    [_comView.textField addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    _comView.textField.delegate = self;
}

- (void)LoginSuccessful
{
    [_comView setLeftIcon:[UIImage imageNamed:@"center.png"] selected:nil];
    _comView.leftButton.hidden = NO;
    _comView.leftButton.tag = KTagPerson;
}

- (NSArray *)createMenuItems {
	NSMutableArray *items = [[[NSMutableArray alloc] init] autorelease];
	
	// First Item
	NAMenuItem *item1 = [[[NAMenuItem alloc] initWithTitle:@"球手"
													 image:[UIImage imageNamed:@"man.png"]
                          selImage:[UIImage imageNamed:@"pressed_man.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item1];
	
	// Second Item
	NAMenuItem *item2 = [[[NAMenuItem alloc] initWithTitle:@"球队"
													 image:[UIImage imageNamed:@"team.png"]
                          selImage:[UIImage imageNamed:@"pressed_team.png"]
												   vcClass:[UIGolfTeamViewController class]] autorelease];
	[items addObject:item2];
	
	// Third Item
	NAMenuItem *item3 = [[[NAMenuItem alloc] initWithTitle:@"球场"
													 image:[UIImage imageNamed:@"site.png"]
                          selImage:[UIImage imageNamed:@"pressed_site.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item3];
	
	// Fourth Item
	NAMenuItem *item4 = [[[NAMenuItem alloc] initWithTitle:@"计分"
													 image:[UIImage imageNamed:@"scoring.png"]
                          selImage:[UIImage imageNamed:@"pressed_scoring.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item4];
	
	// Fifth Item
	NAMenuItem *item5 = [[[NAMenuItem alloc] initWithTitle:@"约球交友"
													 image:[UIImage imageNamed:@"date.png"]
                          selImage:[UIImage imageNamed:@"pressed_date.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item5];
	
	// Sixth Item
	NAMenuItem *item6 = [[[NAMenuItem alloc] initWithTitle:@"排行榜"
													 image:[UIImage imageNamed:@"rank.png"]
                          selImage:[UIImage imageNamed:@"pressed_rank.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item6];
	
	// Seventh Item
	NAMenuItem *item7 = [[[NAMenuItem alloc] initWithTitle:@"球具"
													 image:[UIImage imageNamed:@"tool.png"]
                          selImage:[UIImage imageNamed:@"pressed_tool.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item7];
	
	// Eighth Item
	NAMenuItem *item8 = [[[NAMenuItem alloc] initWithTitle:@"直播"
													 image:[UIImage imageNamed:@"live.png"]
                          selImage:[UIImage imageNamed:@"pressed_live.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item8];
    
	// Ninth Item
	NAMenuItem *item9 = [[[NAMenuItem alloc] initWithTitle:@"大学堂"
													 image:[UIImage imageNamed:@"book.png"]
                          selImage:[UIImage imageNamed:@"pressed_book.png"]
												   vcClass:[UIGolfPlayerViewController class]] autorelease];
	[items addObject:item9];
	
	return items;
}

#pragma mark - NAMenuViewDelegate Methods

- (NSUInteger)menuViewNumberOfItems:(id)menuView {
	NSAssert(_menuItems, @"You must set menuItems before attempting to load.");
	return _menuItems.count;
}

- (NAMenuItem *)menuView:(NAMenuView *)menuView itemForIndex:(NSUInteger)index {
	NSAssert(_menuItems, @"You must set menuItems before attempting to load.");
	return [_menuItems objectAtIndex:index];
}

- (void)menuView:(NAMenuView *)menuView didSelectItemAtIndex:(NSUInteger)index {
	NSAssert(_menuItems, @"You must set menuItems before attempting to load.");
	
    if (index == 0 || index == 4) {
        if ([NSSystemSetMessage defaultMessage].isLogin == NO) {
            GolfLoginViewController *controller = [[GolfLoginViewController alloc] init];
            controller.delegate = self;
            [[AppDelegate shareAppDelegate].navigation pushViewController:controller animated:YES];
            [controller release];
        }
        else {
            Class class = [[_menuItems objectAtIndex:index] targetViewControllerClass];
            UIViewController *viewController = [[[class alloc] init] autorelease];
            [[AppDelegate shareAppDelegate].navigation pushViewController:viewController animated:YES];
        }
    }
    else {
        Class class = [[_menuItems objectAtIndex:index] targetViewControllerClass];
        UIViewController *viewController = [[[class alloc] init] autorelease];
        [[AppDelegate shareAppDelegate].navigation pushViewController:viewController animated:YES];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_comView.textField resignFirstResponder];
    
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
