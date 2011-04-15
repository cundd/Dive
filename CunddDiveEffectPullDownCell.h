//
//  CunddDiveEffectPullDownCell.h
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveEffectMenuItem.h"
#import "CunddDiveEffectMenuSeparator.h"



@interface CunddDiveEffectPullDownCell : NSPopUpButtonCell {
	CunddDiveEffectMenuSeparator * separatorPrototype;
	CunddDiveEffectMenuItem * menuItemPrototype;
	NSArray * sortedObjects;
}

-(void)setup;
@property (retain) CunddDiveEffectMenuSeparator * separatorPrototype;
@property (retain) CunddDiveMenuItem * menuItemPrototype;
@property (retain) NSArray * sortedObjects;
@end
