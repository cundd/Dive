//
//  CunddDiveVCAlphaPunchOut.m
//
//  Created by Daniel Corn on 19.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVCAlphaPunchOut.h"

@implementation CunddDiveVCAlphaPunchOut
-(id) newValue{
	return [[NSNumber numberWithInt:0] retain];
}
-(NSString *) controllerKeyPath{
	return @"patch.alpha";
}
@end
