//
//  AboutViewController.m
//  Chinesetoday
//
//  Created by Man Tung on 6/5/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIImageView * imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutChineseToday.jpg"]];
    imageview.frame = CGRectMake(0, 0, 320, 600);
    
    [scrollview addSubview:imageview];
    scrollview.contentSize = CGSizeMake(320, 600 + 70);
    [self.view addSubview:scrollview];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
