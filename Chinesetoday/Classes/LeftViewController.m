//
//  LeftViewController.m
//  Chinesetoday
//
//  Created by CMD on 6/3/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "LeftViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "HomeViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"
#import "UMFeedbackViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"首页";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"反馈";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"关于我们";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"评分和更新";
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self tapHomeView];
    } else if (indexPath.row == 1) {
        [self tapFeedbackView];
    } else if (indexPath.row == 2) {
        [self tapAboutView];
    } else if (indexPath.row == 3) {
        [self tapSettingView];
    }
}

- (void)tapAboutView {
    AboutViewController *aboutvc = [[AboutViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:aboutvc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    self.sidePanelController.centerPanel = nav;
    [aboutvc release];
    [nav release];
}

- (void)tapHomeView {
    HomeViewController *homevc = [[HomeViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    self.sidePanelController.centerPanel = nav;
    [homevc release];
    [nav release];
}

- (void)tapSettingView {
    SettingViewController *settingvc = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:settingvc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:nav animated:YES];
    [settingvc release];
    [nav release];
}

- (void)tapFeedbackView {
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = UMENG_APPKEY;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentModalViewController:navigationController animated:YES];
}

@end
