//
//  CunddStreamClient.h
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


@interface CunddStreamClient : NSObject <NSStreamDelegate,NSNetServiceDelegate,NSNetServiceBrowserDelegate>{
	NSString * outputString;
	
	NSNetServiceBrowser * browser;
    NSMutableArray * services;
    NSMutableData * currentDownload;
	NSNetService * serverService;
	BOOL debug;
	
	NSTableView * browserTable;
	
	BOOL _streamRunning;
	NSUInteger _countSkippedUpdates;
	NSUInteger _maxSkippedUpdates;
	NSInputStream * _oldStream;
}

/*!
 @method     
 @abstract   Print a debug message if debug is checked in the internal settings
 @discussion Print a debug message if debug is checked in the internal settings
 */
-(void)debug:(NSString *)msg;

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


// Properties
@property (retain) NSTableView * browserTable;
@property (retain) NSString * outputString;
@property (retain) NSNetServiceBrowser	* browser;
@property (retain) NSMutableArray		* services;
@property (retain) NSMutableData		* currentDownload;
@property (retain) NSNetService			* serverService;
@property (assign) BOOL debug;

@property (assign) NSUInteger _countSkippedUpdates;
@property (assign) NSUInteger _maxSkippedUpdates;

@end
