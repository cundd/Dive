//
//  CunddMIDIDevice.m
//  MidIn
//
//  Created by Daniel Corn on 14.06.10.
//
//	Copyright © 2010 Corn Daniel
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//	software and associated documentation files (the "Software"), to deal in the Software 
//	without restriction, including without limitation the rights to use, copy, modify, 
//	merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
//	permit persons to whom the Software is furnished to do so, subject to the following 
//	conditions: 
//	The above copyright notice and this permission notice shall be included in all copies 
//	or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
//	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
//	CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
//	OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//

#import "CunddMIDIDevice.h"


@implementation CunddMIDIDevice

+(id)deviceWithMIDIDeviceRef:(MIDIDeviceRef)theDevice{
	return [[[self alloc] initWithDevice:theDevice] autorelease];
}
-(id) initWithDevice:(MIDIDeviceRef)theDevice{
	if([self init]){
		_device = theDevice;
		entities = [[NSMutableArray array] retain];
		
		for(NSUInteger j = 0; j < MIDIDeviceGetNumberOfEntities(_device); j++){
			MIDIEntityRef entity = MIDIDeviceGetEntity(_device, j);
			CunddMIDIEntity * cunddEntity = [[CunddMIDIEntity entityWithMIDIEntityRef:entity] retain];
			[entities addObject:cunddEntity];
		}
	}
	return self;
}


-(void) dealloc{
	[entities release];
	[super dealloc];
}


@synthesize entities;
@end
