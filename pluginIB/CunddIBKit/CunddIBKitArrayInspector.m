//
//  CunddIBKitArrayInspector.m
//  CunddIBKit
//
//  Created by Daniel Corn on 10.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddIBKitArrayInspector.h"

@implementation CunddIBKitArrayInspector

- (NSString *)viewNibName {
    return @"CunddIBKitArrayInspector";
}

- (void)refresh {
	// Synchronize your inspector's content view with the currently selected objects
	[super refresh];
}

@end
