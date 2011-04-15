//
//  CunddDiceSettings.h
//
//  Created by Daniel Corn on 26.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveMasterSettings.h"

@interface CunddDiceSettings : CunddDiveAbstractSettings {
	NSNumber * environment;
}
@property (retain) NSNumber * environment;
@end
