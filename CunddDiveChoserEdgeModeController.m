//
//  CunddDiveChoserEdgeModeController.m
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

#import "CunddDiveChoserEdgeModeController.h"

@implementation CunddDiveChoserEdgeModeController
-(id) content{
	if(!content){
		NSNumber * fold = [NSNumber numberWithInt:CunddDiveEdgeModeFold];
		NSNumber * clip = [NSNumber numberWithInt:CunddDiveEdgeModeClip];
		NSNumber * warp = [NSNumber numberWithInt:CunddDiveEdgeModeWarp];
		
		content = [[NSArray arrayWithObjects:
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Fold",@"name",	fold,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Clip",@"name",	clip,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Warp",@"name",	warp,@"value",nil] retain],
					nil
		] retain];
	}
	return content;
}
@end
