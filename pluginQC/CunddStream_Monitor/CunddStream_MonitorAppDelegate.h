//
//  CunddStream_MonitorAppDelegate.h
//  CunddStream_Monitor
//
//  Created by Daniel Corn on 02.06.10.
//
//    Copyright © 2010-2012 Corn Daniel
//
//    This file is part of Dive.
//
//    Dive is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Foobar is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
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
