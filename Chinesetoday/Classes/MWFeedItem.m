//
//  MWFeedItem.m
//  MWFeedParser
//
//  Copyright (c) 2010 Michael Waterfall
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//  
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the 
//     purpose of any concept relating to diary/journal keeping.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "MWFeedItem.h"

#define EXCERPT(str, len) (([str length] > len) ? [[str substringToIndex:len-1] stringByAppendingString:@"…"] : str)

@implementation MWFeedItem

@synthesize identifier, title, link, date, updated, summary, content, enclosures;
@synthesize CMDimageurl, CMDsum, CMDtime, CMDtitle;

#pragma mark NSObject

- (NSString *)description {
	NSMutableString *string = [[NSMutableString alloc] initWithString:@"MWFeedItem: "];
	if (title)   [string appendFormat:@"“%@”", EXCERPT(title, 50)];
	if (date)    [string appendFormat:@" - %@", date];
	//if (link)    [string appendFormat:@" (%@)", link];
	//if (summary) [string appendFormat:@", %@", EXCERPT(summary, 50)];
	return [string autorelease];
}

- (void)dealloc {
	[identifier release];
	[title release];
	[link release];
	[date release];
	[updated release];
	[summary release];
	[content release];
	[enclosures release];
	[super dealloc];
}

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		identifier = [[decoder decodeObjectForKey:@"identifier"] retain];
		title = [[decoder decodeObjectForKey:@"title"] retain];
		link = [[decoder decodeObjectForKey:@"link"] retain];
		date = [[decoder decodeObjectForKey:@"date"] retain];
		updated = [[decoder decodeObjectForKey:@"updated"] retain];
		summary = [[decoder decodeObjectForKey:@"summary"] retain];
		content = [[decoder decodeObjectForKey:@"content"] retain];
		enclosures = [[decoder decodeObjectForKey:@"enclosures"] retain];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	if (identifier) [encoder encodeObject:identifier forKey:@"identifier"];
	if (title) [encoder encodeObject:title forKey:@"title"];
	if (link) [encoder encodeObject:link forKey:@"link"];
	if (date) [encoder encodeObject:date forKey:@"date"];
	if (updated) [encoder encodeObject:updated forKey:@"updated"];
	if (summary) [encoder encodeObject:summary forKey:@"summary"];
	if (content) [encoder encodeObject:content forKey:@"content"];
	if (enclosures) [encoder encodeObject:enclosures forKey:@"enclosures"];
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

- (NSString*)timestamp:(time_t)createdAt
{
	NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"发布于%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"发布于%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
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
            [dateFormatter setDateFormat:@"发布于今日H点"];
        } else {
            [dateFormatter setDateFormat:@"发布于M月d日"];
        }
        
        NSDate *dat = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:dat];
        
    }
    
    return _timestamp;
}

- (void)parseString
{
    if (self.date) {
        time_t createdAt = (time_t)[self.date timeIntervalSince1970];
        self.CMDtime = [self timestamp:createdAt];
	}
    self.CMDimageurl = [self PainStringWithComp:self.summary CutString:@"<img" StartString:@"SRC=\"" EndString:@"\""];
    self.CMDtitle = [self PainStringWithComp:self.summary CutString:@"<h2" StartString:@"font-weight:600;\">" EndString:@"</H2>"];
    
    self.CMDsum = [self PainStringWithComp:self.summary CutString:@"<p>" StartString:@"p>" EndString:@"</P>"];
}

@end
