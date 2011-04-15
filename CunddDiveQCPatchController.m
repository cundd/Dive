//
//  CunddDiveQCPatchController.m
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveQCPatchController.h"

@implementation CunddDiveQCPatchController

-(BOOL)_qcCompositionDidClear{
	if(!_qcCompositionDidClearInputsOnce){
		if(!_qcCompositionDidClearMax){
			_qcCompositionDidClearMax = [[self.qcComposition inputKeys] count];
		}
		_qcCompositionDidClearCounter++;
		if(_qcCompositionDidClearCounter > _qcCompositionDidClearMax){
			_qcCompositionDidClearInputsOnce = YES;
		}
	}
	return _qcCompositionDidClearInputsOnce;
	
}

-(CunddDiveAbstractSettings *) content{
	return _patch;
}
-(void) setContent:(CunddDiveAbstractSettings *)value{
	[_patch release];
	_patch = value;
	[value retain];
}

@synthesize view,qcComposition;
@end
