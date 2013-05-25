//
//  DetailViewController.h
//  Chinesetoday
//
//  Created by Man Tung on 3/14/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>
{
    NSString *summary;
    NSString *titlestring;
    NSString *imageurl;
    NSString *timestring;
}

@property (nonatomic, retain)NSString *titlestring;
@property (nonatomic, retain)NSString *imageurl;
@property (nonatomic, retain)NSString *timestring;
@property (nonatomic, retain)NSString *summary;

@property (nonatomic, retain)UIImageView *viewImg;
@property (nonatomic, retain)UIScrollView * contentScroll;
@property (nonatomic, retain)UILabel *contentLB;

@end
