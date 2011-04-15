//
//  CunddDiveEffectLibraryProxy.h
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveEffectLibrary.h"


@interface CunddDiveEffectLibraryProxy : NSArray {
	NSArray * content;
}
@property (retain,readonly) NSArray * sortedLibrary;
@property (retain,readonly) NSArray * content;
@end
