//
//  CunddDiveMasterSettings.h
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveAbstractSettings.h"

@interface CunddDiveMasterSettings : CunddDiveAbstractSettings {
	NSNumber * environment;
}

@property (retain) NSNumber * environment;
@end
