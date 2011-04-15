//
//  CunddIBKit.m
//  CunddIBKit
//
//  Created by Daniel Corn on 10.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddIBKit.h"

@implementation CunddIBKit
- (NSArray *)libraryNibNames {
    return [NSArray arrayWithObject:@"CunddIBKitLibrary"];
}

- (NSArray *)requiredFrameworks {
    return [NSArray arrayWithObjects:[NSBundle bundleWithIdentifier:@"net.cundd.CunddIBKit"], nil];
}

@end
