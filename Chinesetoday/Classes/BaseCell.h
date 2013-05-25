//
//  BaseCell.h
//  Chinesetoday
//
//  Created by Man Tung on 3/6/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface BaseCell : UITableViewCell
{
    UILabel * titleLB;
    UILabel * createtimeLB;
    UIImageView * smallImg;
    UILabel * contentpreviewLB;
    UIImageView * createtimeiconImg;
    NSString *dateString, *summaryString;
    time_t createdAt;
    CGFloat cellheight;
}

@property (nonatomic, retain)UILabel * titleLB;
@property (nonatomic, retain)UILabel * createtimeLB;
@property (nonatomic, retain)UIImageView * smallImg;
@property (nonatomic, retain)UILabel * contentpreviewLB;
@property (nonatomic, retain)UIImageView *createtimeiconImg;
@property (nonatomic, assign)CGFloat cellheight;
@property (nonatomic, retain) NSString *dateString, *summaryString;

- (void)configcell:(MWFeedItem *)item;

- (CGFloat)ch;

@end
