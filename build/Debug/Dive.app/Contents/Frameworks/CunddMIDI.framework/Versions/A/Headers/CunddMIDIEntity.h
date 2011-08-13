//
//  CunddMIDIEntity.h
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

#import <Cocoa/Cocoa.h>
#import <CoreMIDI/CoreMIDI.h>
#import <CunddMIDI/CunddMIDISource.h>
#import <CunddMIDI/CunddMIDIDestination.h>
#import <CunddMIDI/CunddMIDIDataOwner.h>
#import <CunddCore/CunddAppRegistry.h>



@interface CunddMIDIEntity : CunddMIDIDataOwner {
	MIDIEntityRef entity;
	
	NSString * displayName;
	NSString * name;
	NSString * manufacturer;
	
	NSNumber * deviceId;
	NSNumber * entityUid;
	
	NSMutableArray * sources;
	NSMutableArray * destinations;
}

extern NSString * const kCunddMIDIEntityRegistryCollectionName;

+(void)printCounter;
/*!
    @method     
    @abstract   Returns a new instance with the given Core MIDI entity
    @discussion Returns a new instance with the given Core MIDI entity
*/
+(id)entityWithMIDIEntityRef:(MIDIEntityRef)theEntity;
-(id) initWithEntity:(MIDIEntityRef)theEntity;

/*!
    @method     
    @abstract   Returns the source object at the given index
    @discussion Returns the source object at the given index
*/
-(CunddMIDISource *)sourceAtIndex:(NSUInteger)theIndex;

/*!
 @method     
 @abstract   Returns the destination object at the given index
 @discussion Returns the destination object at the given index
 */
-(CunddMIDIDestination *)destinationAtIndex:(NSUInteger)theIndex;

/*!
 @method     
 @abstract   Returns the first source object
 @discussion Returns the first source object
 */
-(CunddMIDISource *)firstSource;

/*!
 @method     
 @abstract   Returns the first destination object
 @discussion Returns the first destination object
 */
-(CunddMIDIDestination *)firstDestination;



@property (assign) MIDIEntityRef entity;
@property (retain) NSString * displayName;
@property (retain) NSString * name;
@property (retain) NSString * manufacturer;

@property (retain) NSNumber * deviceId;
@property (retain) NSNumber * entityUid;

@property (retain) NSMutableArray * sources;
@property (retain) NSMutableArray * destinations;


@end
