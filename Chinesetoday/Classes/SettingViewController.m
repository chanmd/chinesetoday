//
//  SettingViewController.m
//  Chinesetoday
//
//  Created by CMD on 6/6/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "SettingViewController.h"
#import "MobClick.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    UIView * bgview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgview.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = bgview;
    [bgview release];
    self.title = @"评分和更新";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    UIButton * backbutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 9, 27, 27)];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"btn_comment.png"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backbutton];
    [backbutton release];
    
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int num = 0;
    if (section == 0) {
        num = 2;
    } else if (section == 1) {
        num = 1;
    }
    return num;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"App Store";
    } else if (section == 1) {
        return @"关于开发者";
    } else {
        return @"什么也没有";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"给我们评分";
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"检查新版本";
            }
            
        } else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"民棟";
            } else if (indexPath.row == 1) {
//                cell.textLabel.text = @"hello,world!";
            }
        } else {
            //code here
        }
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            [self goToAppStore];
            
        } else if (indexPath.row == 1) {
            
            [self checkupdate];
            
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [self toToDeveloper];
            
        } else if (indexPath.row == 1) {
            
            NSLog(@"hello,world!");
            
        }
        
    } else {
        //code here
    }
}

- (void)goToAppStore
{
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",AppID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)checkupdate
{
    [MobClick checkUpdate];
}

- (void)toToDeveloper
{
    NSString *str = [NSString stringWithFormat:@"http://www.weibo.com/eclimd"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)goBack
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
