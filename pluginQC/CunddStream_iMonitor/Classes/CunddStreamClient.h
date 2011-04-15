//
//  CunddStreamClient.h
//  CunddStream_Monitor
//
//  Created by Daniel Corn on 02.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CunddStreamClient : NSObject <NSStreamDelegate,NSNetServiceDelegate,NSNetServiceBrowserDelegate>{
	NSString * outputString;
	
	NSNetServiceBrowser * browser;
    NSMutableArray * services;
    NSMutableData * currentDownload;
	NSNetService * serverService;
	BOOL debug;
	
	UITableView * browserTable;
	
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
@property (retain) UITableView * browserTable;
@property (retain) NSString * outputString;
@property (retain) NSNetServiceBrowser	* browser;
@property (retain) NSMutableArray		* services;
@property (retain) NSMutableData		* currentDownload;
@property (retain) NSNetService			* serverService;
@property (assign) BOOL debug;

@property (assign) NSUInteger _countSkippedUpdates;
@property (assign) NSUInteger _maxSkippedUpdates;

@end
