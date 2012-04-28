//
//  CunddDiveQuitPanel.m
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
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
