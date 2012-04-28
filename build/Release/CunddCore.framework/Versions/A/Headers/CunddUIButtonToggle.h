//
//  CunddUIButtonToggle.h
//  Dive
//
//  Created by Daniel Corn on 25.05.10.
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
#import "CunddUIButtonPunch.h"

typedef enum{
	CunddUIButtonStateOn,
	CunddUIButtonStateOff,
	CunddUIButtonStateMax
}CunddUIButtonState;



@interface CunddUIButtonToggle : NSButton {
	CunddUIButtonState state;
	IBOutlet id controller;
	id oldValue;
}


/*!
 @method     
 @abstract   Returns the value that should be set
 @discussion Returns the value that should be set
 */
-(id)newValue;

/*!
 @method     
 @abstract   Returns the key path of the controller to be set
 @discussion Returns the key path of the controller to be set
 */
-(NSString *)controllerKeyPath;

@property (retain) id controller;
@property (retain) id oldValue;
@property (readonly) id newValue;
@property (assign) CunddUIButtonState state;
@end
