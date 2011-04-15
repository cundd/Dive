//
//  CunddDiveRootView.m
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveRootView.h"

@implementation CunddDiveRootView
-(BOOL) performKeyEquivalent:(NSEvent *)theEvent{
	if([CunddAppKeyHandler performKeyEquivalent:theEvent]){
		return YES;
	} else {
		return [super performKeyEquivalent:theEvent];
	}
}
@end
