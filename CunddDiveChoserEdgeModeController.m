//
//  CunddDiveChoserEdgeModeController.m
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
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
