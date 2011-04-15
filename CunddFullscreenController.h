//
//  CunddControllerFullscreen.h
//  Dive
//
//  Created by Daniel Corn on 31.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CunddFullscreenController : NSObject {
	IBOutlet NSObject * controller;
	IBOutlet NSWindow * window;
	IBOutlet NSView * oldContentContainer;
	
	NSWindow * fullscreenWindow;	
	NSView * oldContentView;
}

/*!
 @method     
 @abstract   Switches to fullscreen
 @discussion Switches to fullscreen
 */
-(IBAction)toggleFullscreen:(id)sender;

@property (retain) NSView * oldContentView;
@property (retain) NSView * oldContentContainer;
@property (retain) NSObject * controller;
@property (retain) NSWindow * fullscreenWindow;
@property (retain) NSWindow * window;

@end
