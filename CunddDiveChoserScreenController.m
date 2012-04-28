//
//  CunddDiveChoserScreenController.m
//
//  Created by Daniel Corn on 25.05.10.
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

#import "CunddDiveChoserScreenController.h"

@implementation CunddDiveChoserScreenController
-(id) content{
	if(!content){
		NSNumber * front = 	[NSNumber numberWithInt:CunddDiveScreenFront];
		NSNumber * back = 	[NSNumber numberWithInt:CunddDiveScreenBack];
		NSNumber * left = 	[NSNumber numberWithInt:CunddDiveScreenLeft];
		NSNumber * right = 	[NSNumber numberWithInt:CunddDiveScreenRight];
		NSNumber * top = 	[NSNumber numberWithInt:CunddDiveScreenTop];
		NSNumber * bottom = [NSNumber numberWithInt:CunddDiveScreenBottom];
				
		content = [[NSArray arrayWithObjects:
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Front",@"name",		front,	@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Back",@"name",		back,	@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Left",@"name",		left,	@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Right",@"name",		right,	@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Top",@"name",			top,	@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Bottom",@"name",		bottom,	@"value",nil] retain],
					nil
					] retain];
	}
	return content;
}
@end
