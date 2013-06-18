//
//  HomeViewController.m
//  Chinesetoday
//
//  Created by Man Tung on 2/22/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "HomeViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DetailTableViewController.h"
#import "BaseCell.h"
#import "DetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize itemsToDisplay;

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

    // Setup
	self.title = @"加载中...";
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	parsedItems = [[NSMutableArray alloc] init];
	self.itemsToDisplay = [NSArray array];
    
    self.navigationItem.rightBarButtonItem = [self rightButtonGen];
    
    
	// Parse
	NSURL *feedURL = [NSURL URLWithString:Data_URL];
	feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	[feedParser parse];
}

#pragma mark -
#pragma mark Parsing

- (UIBarButtonItem *)rightButtonGen {
    UIImage *faceImage = [UIImage imageNamed:@"refresh.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, 22, 22 );
//    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}


// Reset and reparse
- (void)refresh {
	self.title = @"加载中...";
	[parsedItems removeAllObjects];
	[feedParser stopParsing];
	[feedParser parse];
	self.tableView.userInteractionEnabled = NO;
	self.tableView.alpha = 0.3;
}

- (void)updateTableWithParsedItems {
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date"
																				 ascending:NO] autorelease]]];
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
//	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
//	NSLog(@"Parsed Feed Info: “%@”", info.title);
	self.title = @"每日箴言";
    //info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
//	NSLog(@"Parsed Feed Item: “%@”", item.title);
//    if ([item.title isEqualToString:@"四月经典名言"]) {
//        NSLog(@"%@", item.summary);
//    }
    
//    NSLog(@"%@", item.enclosures);
    
	if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
//	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
//	NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"加载失败"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                         message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                        delegate:nil
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil] autorelease];
        [alert show];
    }
    [self updateTableWithParsedItems];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemsToDisplay count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell * cell = (BaseCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return [cell ch];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BaseCell * cell;
    // Configure the cell...
    cell = [[[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    [cell configcell:item];
    //NSLog(@"%@", item.identifier);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Show detail
	DetailViewController *detail = [[DetailViewController alloc] init];
	MWFeedItem *item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
    
    detail.summary = item.summary;
    detail.titlestring = item.CMDtitle;
    detail.timestring = item.CMDtime;
    detail.imageurl = item.CMDimageurl;
	[self.navigationController pushViewController:detail animated:YES];
	[detail release];
	
	// Deselect
	//[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)PainStringWithComp:(NSString *)origString CutString:(NSString *)cutstring StartString:(NSString *)startstring EndString:(NSString *)endstring
{
    NSString *targetString = [[NSString alloc] init];
    
    NSRange r = [origString rangeOfString:cutstring];
    NSRange end;
    if (r.location != NSNotFound) {
        NSRange start = [origString rangeOfString:startstring];
        if (start.location != NSNotFound) {
            int l = [origString length];
            NSRange fromRang = NSMakeRange(start.location + start.length, l-start.length-start.location);
            end   = [origString rangeOfString:endstring options:NSCaseInsensitiveSearch
                                        range:fromRang];
            if (end.location != NSNotFound) {
                r.location = start.location + start.length;
                r.length = end.location - r.location;
                targetString = [origString substringWithRange:r];
            }
            else {
                targetString = @"";
            }
        }
        else {
            targetString = @"";
        }
    }
    return targetString;
}


@end
