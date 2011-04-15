//
//  CunddInspector.m
//  Cundd
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddInspector.h"

@implementation CunddInspector

- (NSString *)viewNibName {
	return @"CunddInspector";
}

- (void)refresh {
	// Synchronize your inspector's content view with the currently selected objects.
	[super refresh];
}

@end
