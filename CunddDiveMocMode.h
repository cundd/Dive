//
//  CunddDiveMocMode.h
//  Dive
//
//  Created by Daniel Corn on 21.05.10.
//
//    Copyright © 2010-2012 Corn Daniel
//
//    This file is part of Dive.
//
//    Dive is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Foobar is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
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
