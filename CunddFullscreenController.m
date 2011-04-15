//
//  CunddControllerFullscreen.m
//  Dive
//
//  Created by Daniel Corn on 31.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddFullscreenController.h"


@implementation CunddFullscreenController



-(void) toggleFullscreen:(id)sender{
	if(fullscreenWindow){ // If fullscreenWindow -> leave fullscreen
		NSRect newFrame = [fullscreenWindow frameRectForContentRect:
						   [window contentRectForFrameRect:[window frame]]];
		[fullscreenWindow
		 setFrame:newFrame
		 display:YES
		 animate:YES];
		
		if(self.controller){
			[window setContentView:oldContentView];
			[self.oldContentContainer performSelector:@selector(addSubview:) withObject:[fullscreenWindow contentView]];
		} else {
			[window setContentView:[fullscreenWindow contentView]];
		}
		
		
		[window makeKeyAndOrderFront:nil];
		
		[fullscreenWindow close];
		fullscreenWindow = nil;
		
		// Hide the menu
		if([[window screen] isEqual:[[NSScreen screens] objectAtIndex:0]]){
			[NSMenu setMenuBarVisible:YES];
		}
	} else { // If not fullscreenWindow -> go fullscreen
		[window deminiaturize:nil];
		
		NSView * controllerView;
		if(self.controller){
			controllerView = [self.controller performSelector:@selector(view)];
		} else {
			controllerView = [self.window contentView];
		}
		
		
		if([[window screen] isEqual:[[NSScreen screens] objectAtIndex:0]]){
			[NSMenu setMenuBarVisible:NO];
		}
		
		fullscreenWindow = [[NSWindow alloc]
							initWithContentRect:[window contentRectForFrameRect:[window frame]]
							styleMask:NSBorderlessWindowMask
							backing:NSBackingStoreBuffered
							defer:YES];
		[fullscreenWindow setLevel:NSFloatingWindowLevel];
		
		// [fullscreenWindow setContentView:[window contentView]];
		oldContentView = [window contentView];
		[fullscreenWindow setContentView:controllerView];
		
		[fullscreenWindow setTitle:[window title]];
		[fullscreenWindow makeKeyAndOrderFront:nil];
		
		[fullscreenWindow setFrame:[fullscreenWindow frameRectForContentRect:[[window screen] frame]] display:YES animate:YES];
		[window orderOut:nil];
	}
}

@synthesize oldContentContainer,oldContentView,controller,fullscreenWindow,window;

@end
