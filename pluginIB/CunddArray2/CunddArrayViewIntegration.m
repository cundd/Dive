//
//  CunddArrayView.m
//  CunddArray
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <InterfaceBuilderKit/InterfaceBuilderKit.h>
#import <CunddArray/CunddArrayView.h>
#import "CunddArrayInspector.h"


@implementation CunddArrayView ( CunddArrayView )

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
	
	// Remove the comments and replace "MyFirstProperty" and "MySecondProperty" 
	// in the following line with a list of your view's KVC-compliant properties.
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:/* @"MyFirstProperty", @"MySecondProperty",*/ nil]];
}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[CunddArrayInspector class]];
}

@end
