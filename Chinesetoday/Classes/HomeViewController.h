//
//  HomeViewController.h
//  Chinesetoday
//
//  Created by Man Tung on 2/22/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface HomeViewController : UITableViewController <MWFeedParserDelegate>
{
	// Parsing
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
	// Displaying
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
	
}

// Properties
@property (nonatomic, retain) NSArray *itemsToDisplay;

@end
