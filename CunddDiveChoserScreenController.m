//
//  CunddDiveChoserScreenController.m
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
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
