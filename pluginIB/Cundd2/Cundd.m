//
//  Cundd.m
//  Cundd
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "Cundd.h"

@implementation Cundd
- (NSArray *)libraryNibNames {
    return [NSArray arrayWithObject:@"CunddLibrary"];
}

- (NSArray *)requiredFrameworks {
    return [NSArray arrayWithObjects:[NSBundle bundleWithIdentifier:@"com.yourcompany.Cundd"], nil];
}

@end
