//
//  CunddDiveQCPatchController.h
//
//  Created by Daniel Corn on 11.05.10.
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
#import <Quartz/Quartz.h>
#import "Cundd.h"
#import "CunddDiveAbstractSettings.h"
#import "CunddDiveQCView.h"

@interface CunddDiveQCPatchController : CunddObject {
	IBOutlet CunddDiveQCView * view;
	QCComposition * qcComposition;
	
	CunddDiveAbstractSettings * _patch;
@private
	BOOL _qcCompositionDidClearInputsOnce;
	NSUInteger _qcCompositionDidClearCounter;
	NSUInteger _qcCompositionDidClearMax;
}

/*!
 @method     
 @abstract   
 @discussion On startup the QCComposition seems to clear all input-values, this method checks if the current observed change would delete (null) a settings-property and returns NO if the change is part of the startup-clear-routine.
 */
-(BOOL)_qcCompositionDidClear;


@property (retain) CunddDiveQCView * view;
@property (retain) QCComposition * qcComposition;
@property (retain) id content;
@end
