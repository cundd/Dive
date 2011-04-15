//
//  CunddArray.m
//  CunddIBKit
//
//  Created by Daniel Corn on 10.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddArray.h"


@implementation CunddArray

- (void)forwardInvocation:(NSInvocation *)invocation{
    /*
	 SEL aSelector = [invocation selector];
	/*
    if([friend respondsToSelector:aSelector]){
		[invocation invokeWithTarget:_internalArray];
	} else {
		[self doesNotRecognizeSelector:aSelector];
	}
	 */
}
@end
