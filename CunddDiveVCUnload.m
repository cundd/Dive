//
//  CunddDiveVCUnload.m
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

#import "CunddDiveVCUnload.h"

@implementation CunddDiveVCUnload
/*
-(void) mouseDown:(NSEvent *)theEvent{
	// [super mouseDown:theEvent];
	if(self.qcPatchController){
		[self.qcPatchController.view stop:self];
	}
	
	[super mouseDown:theEvent];
	
	// Call -mouseUp
	[self mouseUp:theEvent];
}
// */

-(id) newValue{
	return @"unloaded";
}
-(NSString *) controllerKeyPath{
	return @"patch.movieLocation";
}

@synthesize qcPatchController;
@end
