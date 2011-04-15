//
//  CunddIBKitView.m
//  CunddIBKit
//
//  Created by Daniel Corn on 10.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <InterfaceBuilderKit/InterfaceBuilderKit.h>
#import <CunddIBKit/CunddIBKitView.h>
#import "CunddIBKitInspector.h"


@implementation CunddIBKitView ( CunddIBKitView )

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
	
	// Remove the comments and replace "MyFirstProperty" and "MySecondProperty" 
	// in the following line with a list of your view's KVC-compliant properties.
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:/* @"MyFirstProperty", @"MySecondProperty",*/ nil]];
}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[CunddIBKitInspector class]];
}

@end
