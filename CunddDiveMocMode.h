//
//  CunddDiveMocMode.h
//  Dive
//
//  Created by Daniel Corn on 21.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import	"Cundd.h"
#import "CunddDiveVideoChainSettings.h"
#import "CunddDiveScreen.h"

// MOC mode (the mode of this MOC):
typedef enum{
	CunddDiveMocModeNone	= 0,
	CunddDiveMocModeFront	= 1,
	CunddDiveMocModeLeft	= 2,
	CunddDiveMocModeRight	= 3,
	CunddDiveMocModeTop		= 4,
	CunddDiveMocModeBottom	= 5
} CunddDiveMocModes;

@interface CunddDiveMocMode : CunddObject {
	CunddDiveScreen environment;
	CunddDiveScreen screen;
	CunddDiveEdgeMode edgeMode;
	CunddDiveMocModes mocMode;
}


/*!
    @method     
    @abstract   Returns a new instance
    @discussion Returns a new instance
*/
+(CunddDiveMocMode *)mocModeWithScreen:(CunddDiveScreen)aScreen andEdgeMode:(CunddDiveEdgeMode)aEdgeMode inTheEnvironment:(CunddDiveScreen)aEnvironment;

/*!
 @method     
 @abstract   Returns a new instance
 @discussion Returns a new instance
 */
-(CunddDiveMocMode *)initWithScreen:(CunddDiveScreen)aScreen andEdgeMode:(CunddDiveEdgeMode)aEdgeMode inTheEnvironment:(CunddDiveScreen)aEnvironment;


/*!
    @method     
    @abstract   Returns the moc mode through checking the relationship between different screens
    @discussion Returns the moc mode through checking the relationship between different screens
*/
-(CunddDiveMocModes)getRelationship;

@property (assign) CunddDiveScreen environment;
@property (assign) CunddDiveScreen screen;
@property (assign,readonly) CunddDiveMocModes mocMode;
@property (assign,readonly) CunddDiveEdgeMode edgeMode;
@end
