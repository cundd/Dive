//
//  CunddDiveQCPatchController.h
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
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
