//
//  CunddIBKitInspector.m
//  CunddIBKit
//
//  Created by Daniel Corn on 10.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddIBKitInspector.h"

@implementation CunddIBKitInspector

- (NSString *)viewNibName {
	return @"CunddIBKitInspector";
}

- (void)refresh {
	// Synchronize your inspector's content view with the currently selected objects.
	[super refresh];
}

@end
