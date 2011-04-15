//
//  CunddToolOscillatorProcessor.h
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddToolProcessorAbstract.h"

typedef enum{
	CunddToolOscillatorProcessorSin,
	CunddToolOscillatorProcessorCos,
	CunddToolOscillatorProcessorTriangle,
	CunddToolOscillatorProcessorSquare,
	CunddToolOscillatorProcessorSawToothUp,
	CunddToolOscillatorProcessorSawToothDown
} CunddToolOscillatorProcessorType;

@interface CunddToolOscillatorProcessor : CunddToolProcessorAbstract {
	NSNumber	* phase,
				* amplitude,
				* offset;
	
	CunddToolOscillatorProcessorType type;
	
	NSTimeInterval _time;
	NSNumber * _oldValue;
	NSNumber * _customNumber;
}

@property (retain) NSNumber	* phase, * amplitude, * offset;
@property (assign) CunddToolOscillatorProcessorType type;

-(void)sin;
-(void)cos;
-(void)triangle;
-(void)square;
-(void)sawToothUp;
-(void)sawToothDown;


@end
