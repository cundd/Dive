//
//  CunddDiveQuitPanel.m
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveQuitPanel.h"


@implementation CunddDiveQuitPanel

-(id) init{
	terminate=NO;
	
	if (!panel){
		[NSBundle loadNibNamed:@"TerminatePanel" owner:self];
	}
	
	[panel makeKeyAndOrderFront:nil];
	[NSApp runModalForWindow:panel];
	[panel orderOut:nil];
	
	if(terminate){
		return self;
	} else {
		return nil;
	}
}
- (void)dealloc{
	[panel release];
	[super dealloc];
}

- (IBAction)ok:(id)sender{
	terminate=YES;
	[NSApp stopModal];
}

- (IBAction)cancel:(id)sender{
	terminate=NO;
	[NSApp stopModal];
}
@end
