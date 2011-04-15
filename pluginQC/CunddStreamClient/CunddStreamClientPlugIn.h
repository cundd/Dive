//
//  CunddStreamClientPlugIn.h
//  CunddStreamClient
//
//  Created by Daniel Corn on 28.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface CunddStreamClientPlugIn : QCPlugIn <NSStreamDelegate, NSNetServiceBrowserDelegate, NSNetServiceDelegate>
{
	NSString * cunddOutputStringCache;
	NSNetServiceBrowser * browser;
    NSMutableArray * services;
    NSMutableData * currentDownload;
	NSNetService * serverService;
	BOOL debug;
	
	BOOL _streamRunning;
	NSUInteger _countSkippedUpdates;
	NSUInteger _maxSkippedUpdates;
	NSUInteger _rescanAfterSkippedUpdates;
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
-(void)startStream;

/*!
    @method     
    @abstract   Starts a new scan for netservice
    @discussion Starts a new scan for netservice
*/
-(void)startBrowser;

// Ports
@property (assign) NSString * outputString;


// Properties
@property (retain) NSString				* cunddOutputStringCache;
@property (retain) NSNetServiceBrowser	* browser;
@property (retain) NSMutableArray		* services;
@property (retain) NSMutableData		* currentDownload;
@property (retain) NSNetService			* serverService;
@property (assign) BOOL debug;

@property (assign) NSUInteger _countSkippedUpdates;
@property (assign) NSUInteger _maxSkippedUpdates;
@end
