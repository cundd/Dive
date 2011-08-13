//
//  CunddMIDIEndpoint.h
//  MidIn
//
//  Created by Daniel Corn on 15.06.10.
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
#import <CunddMIDI/CunddMIDIObject.h>


@interface CunddMIDIEndpoint : CunddMIDIObject {
	MIDIEndpointRef endpoint;
	MIDIPortRef outputPort;
	
	NSData * message;
}

/*!
    @method     
    @abstract   Returns an instance with the given Core Foundation endpoint
    @discussion Returns an instance with the given Core Foundation endpoint
*/
+(id)endpointWithMIDIEndpoint:(MIDIEndpointRef)theEndpoint;


/*!
    @method     
    @abstract   Returns an instance with the given Core Foundation endpoint
    @discussion Returns an instance with the given Core Foundation endpoint
*/
-(id)initWithMIDIEndpoint:(MIDIEndpointRef)theEndpoint;

/*!
 @method     
 @abstract   Sends data of type NSData* to the own destination
 @discussion Sends data of type NSData* to the own destination
 */
-(OSStatus)sendData:(NSData *)data;

/*!
 @method     
 @abstract   Sends the given packetlist to the own destination
 @discussion Sends the given packetlist to the own destination
 */
-(OSStatus)sendMIDIPacketList:(MIDIPacketList *)packetListPointer;

/*!
 @method     
 @abstract   Sends data of type Byte to the own destination
 @discussion Sends data of type Byte to the own destination
 */
-(OSStatus)sendBytes:(Byte *)data;

/*!
 @method     
 @abstract   Sends data of type Byte to the own destination
 @discussion Sends data of type Byte to the own destination
 */
-(OSStatus)sendBytes:(Byte *)data length:(NSUInteger)theLength;

@property (assign) MIDIPortRef outputPort;
@property (assign) MIDIEndpointRef endpoint;

@property (retain) NSData * message;
@end
