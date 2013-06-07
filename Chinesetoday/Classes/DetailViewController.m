//
//  DetailViewController.m
//  Chinesetoday
//
//  Created by Man Tung on 3/14/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "DetailViewController.h"
#import "NSString+HTML.h"
#import "UILabel+Extensions.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize summary, timestring, imageurl, titlestring;

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
	// Do any additional setup after loading the view.
//    self.myWebView = [[UIWebView alloc] init];
//    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
//    webFrame.origin.y = 0;
//    webFrame.size.height -= 44;
//    self.myWebView.frame = webFrame;
//    self.myWebView.delegate = self;
//    self.myWebView.backgroundColor = [UIColor whiteColor];
//	self.myWebView.scalesPageToFit = YES;
//	//self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//	[self.view addSubview:self.myWebView];
//    [self.myWebView loadHTMLString:[self CutAds:self.summary] baseURL:nil];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIScrollView *contentScroll = [[UIScrollView alloc] init];
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y = 0;
    webFrame.size.height -= 44;
    contentScroll.frame = webFrame;
    [self.view addSubview:contentScroll];
    
    UILabel * Labellogo = [[UILabel alloc] initWithFrame:CGRectMake(0, -38.f, 320, 20)];
    Labellogo.backgroundColor = [UIColor clearColor];
    Labellogo.font = [UIFont fontWithName:FONT_NAME size:14];
    Labellogo.textAlignment = NSTextAlignmentCenter;
    Labellogo.textColor = [UIColor grayColor];
    Labellogo.text = @"每日来主前 经历祂恩典";
    [contentScroll addSubview:Labellogo];
    [Labellogo release];
    
    CGFloat footviewY = webFrame.size.height;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, footviewY, 320, 44)];
    [footerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"footer.png"]]];
    [self.view addSubview:footerView];
    
    UIButton * backbutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    [backbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    [footerView addSubview:backbutton];
    
    [backbutton release];
    [footerView release];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 222)];
    [imageview setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [contentScroll addSubview:imageview];
    
    UILabel *Labeltitle = [[UILabel alloc] init];
    Labeltitle.frame = CGRectMake(2, 195, 300, 20);
    Labeltitle.text = titlestring;
    Labeltitle.font = [UIFont fontWithName:FONT_NAME size:20];
    Labeltitle.backgroundColor = [UIColor clearColor];
    [imageview addSubview:Labeltitle];
    [Labeltitle release];
    
//    CGFloat timeYaxis = Labeltitle.frame.size.height + Labeltitle.frame.origin.y + 3.f;
//    UILabel *Labeltime = [[UILabel alloc] init];
//    Labeltime.frame = CGRectMake(10, timeYaxis, 300, 20);
//    Labeltime.text = timestring;
//    Labeltime.font = [UIFont fontWithName:FONT_NAME size:13];
//    Labeltime.backgroundColor = [UIColor clearColor];
//    [imageview addSubview:Labeltime];
//    [Labeltime release];
    
    [imageview release];
    
    
    NSString * sum = [[NSString alloc] init];
    sum = self.summary ? [self.summary stringByConvertingHTMLToPlainText] : @"[No Title]";
    
//    NSLog(@"%@", self.summary);
    
//    NSRange lastRang = [sum rangeOfString:@"回到页顶"];
    
//    sum = [sum substringToIndex:lastRang.location];
    
    sum = [sum stringByReplacingOccurrencesOfString:@"    " withString:@"\n"];
    
    
    NSArray * ar = [sum componentsSeparatedByString:@"\n"];
    
    NSMutableString * textstring = [[NSMutableString alloc] initWithCapacity:0];
    
    for (int i = 0; i < [ar count] - 1; i ++) {
        NSArray * ars = [ar[i] componentsSeparatedByString:@"  "];
        if ([ars count] > 3) {
            
//            NSLog(@"%d\n", [ars count]);
            
            for (int j = 0; j < [ars count] - 1; j ++) {
                
                [textstring appendFormat:@"%@\n", ars[j]];
//                NSLog(@"%@", ars[j]);
            }
            
//            [textstring appendFormat:@"\n"];
            
        }
        
        else if ([ars count] == 3){
            
            NSArray *arsss = [ar[i] componentsSeparatedByString:@"  "];
            
            for (int j = 0; j < [arsss count]; j ++) {
                if (j == 1) {
                    NSArray *arssss = [arsss[j] componentsSeparatedByString:@" "];
                    for (int jj = 0; jj < [arssss count]; jj ++) {
                        [textstring appendFormat:@"%@\n", [arssss[jj] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                    }
                } else {
                    [textstring appendFormat:@"%@\n", [arsss[j] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                    //NSLog(@"%@", arsss[j]);
                }
            }
        }
        
        else {
            [textstring appendFormat:@"%@\n", [ar[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        }
    }
    
    UILabel *Labelcontent = [[UILabel alloc] initWithFrame:CGRectMake(5, 230, 310, 17)];
    Labelcontent.text = textstring;
    Labelcontent.font = [UIFont fontWithName:FONT_NAME size:16];
    Labelcontent.backgroundColor = [UIColor clearColor];
    [Labelcontent sizeToFitFixedWidth:310];
    [contentScroll addSubview:Labelcontent];
    [Labelcontent release];
    
    
    UISwipeGestureRecognizer * swipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [contentScroll addGestureRecognizer:swipegr];
    [swipegr release];
    
    CGFloat contentheight = Labelcontent.frame.size.height + 230 + 10;
    contentScroll.contentSize = CGSizeMake(320, contentheight);
    [contentScroll release];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
