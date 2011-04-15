//
//  CunddArray.m
//  CunddArray
//
//  Created by Daniel Corn on 10.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddArray.h"

@implementation CunddArray
- (NSArray *)libraryNibNames {
    return [NSArray arrayWithObject:@"CunddArrayLibrary"];
}

- (NSArray *)requiredFrameworks {
    return [NSArray arrayWithObjects:[NSBundle bundleWithIdentifier:@"net.cundd.CunddArray"], nil];
}

@end
