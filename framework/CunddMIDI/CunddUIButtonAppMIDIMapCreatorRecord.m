//
//  CunddUIButtonAppMIDIMapCreator.m
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
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

#import "CunddUIButtonAppMIDIMapCreatorRecord.h"


@implementation CunddUIButtonAppMIDIMapCreatorRecord

NSString * const kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults = @"Clear defaults";

-(void) mouseDown:(NSEvent *)theEvent{
	[super mouseDown:theEvent];
	
	if([theEvent modifierFlags] & NSAlternateKeyMask){
		[self.mapCreator clearDefaults];
	} else 
	if(self.mapCreator.recording){
		NSLog(@"Stop rec");
		[self setTitle:@"Start recording"];
		//[self setState:NSOnState];
		[self.mapCreator stopRecording];
	} else {
		NSLog(@"Start rec");
		[self setTitle:@"Stop recording"];
		//[self setState:NSOnState];
		[self.mapCreator startRecording];
	}
}


-(void)mouseEntered:(NSEvent *)theEvent{
	if([theEvent modifierFlags] & NSAlternateKeyMask){
				_oldTitle = [self title];
		[self setTitle:kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults];
	}
	[super mouseEntered:theEvent];
}

-(void)mouseExited:(NSEvent *)theEvent{
	if([self title] == kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults){
		[self setTitle:_oldTitle];
	}
	[super mouseExited:theEvent];
}

-(CunddAppMIDIMapCreator *) mapCreator{
	if(!mapCreator){
		[self setMapCreator:[CunddAppMIDIMapCreator sharedInstance]];
	}
	return mapCreator;
}
@synthesize mapCreator;
@end
