//
//  CunddStream_MonitorAppDelegate.h
//  CunddStream_Monitor
//
//  Created by Daniel Corn on 02.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddStreamClient.h"

@interface CunddStream_MonitorAppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource> {
    NSWindow *window;
	NSTextView * textView;
	NSTableView * browserTable;
	NSMutableArray * services;
	CunddStreamClient * client;
}

/*!
 @method     
 @abstract   Starts the stream
 @discussion Starts the stream
 */
-(IBAction)startStream:(id)sender;

/*!
 @method     
 @abstract   Browses for net services
 @discussion Browses for net services
 */
- (IBAction)browse:(id)sender;

@property (retain) CunddStreamClient * client;
@property (retain) IBOutlet NSTableView * browserTable;
@property (retain) IBOutlet NSTextView * textView;
@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSMutableArray * services;

@end
