//
//  CunddDiveVCPlaybackToggle.m
//  Dive
//
//  Created by Daniel Corn on 19.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVCPlaybackToggle.h"


@implementation CunddDiveVCPlaybackToggle
-(NSString *) controllerKeyPath{
	return @"patch.speed";
}

-(id) newValue{
	return [[NSNumber numberWithInt:0] retain];
}
@end
