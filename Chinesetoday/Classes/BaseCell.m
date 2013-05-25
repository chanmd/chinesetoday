//
//  BaseCell.m
//  Chinesetoday
//
//  Created by Man Tung on 3/6/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "BaseCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+HTML.h"
#import "UILabel+Extensions.h"

@implementation BaseCell
@synthesize smallImg,titleLB,contentpreviewLB,createtimeLB,createtimeiconImg;
@synthesize dateString, summaryString, cellheight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        titleLB = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 300, 17)];
        titleLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        titleLB.backgroundColor = [UIColor clearColor];
        titleLB.textColor = [UIColor blackColor];
        [self addSubview:titleLB];
        
        smallImg = [[UIImageView alloc] init];
        [self addSubview:smallImg];
        createtimeiconImg = [[UIImageView alloc] init];
        [self addSubview:createtimeiconImg];
        
        contentpreviewLB = [[UILabel alloc] init];
        contentpreviewLB.font = [UIFont fontWithName:FONT_NAME size:14];
        contentpreviewLB.backgroundColor = [UIColor clearColor];
        [self addSubview:contentpreviewLB];
        
        createtimeLB = [[UILabel alloc] init];
        createtimeLB.font = [UIFont fontWithName:FONT_NAME size:12];
        createtimeLB.textColor = [UIColor grayColor];
        createtimeLB.backgroundColor = [UIColor clearColor];
        [self addSubview:createtimeLB];
        
    }
    return self;
}


- (void)configcell:(MWFeedItem *)item
{
 
    [item parseString];
    NSString *perviewcontent = item.CMDsum;
    smallImg.frame = CGRectMake(235, 40, 75, 50);
    [smallImg setImageWithURL:[NSURL URLWithString:item.CMDimageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *cutstring = [perviewcontent stringByTrimmingCharactersInSet:whitespace];
    if ([cutstring length] > 58) {
        self.summaryString = [NSString stringWithFormat:@"%@...", [cutstring substringToIndex:58]];
    } else {
        self.summaryString = cutstring;
    }
    NSString *mytitle = [item.title stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    titleLB.text = mytitle;
    [titleLB sizeToFitFixedWidth:300];
    CGRect titleRect = titleLB.frame;
    
    CGRect contentpreviewRect = CGRectMake(10, titleRect.origin.y + titleRect.size.height + 10, 215, 10);
    
    contentpreviewLB.frame = contentpreviewRect;
    contentpreviewLB.text = self.summaryString;
    [contentpreviewLB sizeToFitFixedWidth:215];
    
    CGFloat timeframey = contentpreviewLB.frame.size.height + contentpreviewLB.frame.origin.y + 10;
    
    createtimeiconImg.frame = CGRectMake(10, timeframey, 12, 12);
    [createtimeiconImg setImage:[UIImage imageNamed:@"clock.png"]];
    
    createtimeLB.frame = CGRectMake(26, timeframey, 200, 14);
    createtimeLB.text = item.CMDtime;
    cellheight = createtimeLB.frame.size.height + createtimeLB.frame.origin.y + 10.f;
}

/*

- (NSString*)timestamp
{
	NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
        }
        
        struct tm * createAtTM = localtime(&createdAt);
        NSDate * currentlytime = [NSDate date];
        NSCalendar * gregorian = gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents * currentlytimeComponents = [gregorian components:NSDayCalendarUnit fromDate:currentlytime];
        if (createAtTM->tm_mday == [currentlytimeComponents day]) {
            [dateFormatter setDateFormat:@"HH:mm"];
        }
//        else if (createAtTM->tm_mday == ([currentlytimeComponents day] - 1) ) {
//            [dateFormatter setDateFormat:@"'昨' HH:mm"];
//        }
        else {
            [dateFormatter setDateFormat:@"M月d日"];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
        
    }
    
    
    
    return _timestamp;
}
 
 */

- (CGFloat)ch
{
    if (cellheight < 90.f) {
        cellheight = 90.f;
    }
    return cellheight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
