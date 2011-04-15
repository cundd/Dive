//
//  CunddDiveVCAlphaPunchIn.m
//
//  Created by Daniel Corn on 19.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVCAlphaPunchIn.h"

@implementation CunddDiveVCAlphaPunchIn
-(id) newValue{
	return [[NSNumber numberWithInt:1] retain];
}
-(NSString *) controllerKeyPath{
	return @"patch.alpha";
}
@end
