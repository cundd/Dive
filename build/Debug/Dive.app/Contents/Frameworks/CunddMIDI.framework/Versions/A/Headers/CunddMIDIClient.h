//
//  CunddMIDIClient.h
//  MidIn
//
//  Created by Daniel Corn on 12.06.10.
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
#import <CunddMIDI/CunddMIDIDevice.h>
#import <CunddMIDI/CunddMIDIDataOwner.h>
#import <CunddMIDI/CunddMIDI.h>

#define kCunddMIDIDeviceReceivedData_private @"CunddMIDIClient.DeviceReceivedDataPrivate"
#define kCunddMIDIDeviceInformationDidChange_private @"kCunddMIDIDeviceInformationDidChangePrivate"


@interface CunddMIDIClient : CunddMIDIDataOwner {
	MIDIClientRef midiClient;
	MIDIPortRef inputPort;
	MIDIPortRef outputPort;
	
	CunddMIDISource * sourcePoint;
	CunddMIDIDestination * destinationPoint;
	
	MIDIEndpointRef _destinationPoint;
	MIDIEndpointRef _sourcePoint;
	
	NSMutableArray * devices;
	
	
}


/*!
    @method     
    @abstract   Returns the shared instance
    @discussion Returns the shared instance
*/
+ (CunddMIDIClient *)sharedInstance;

/*!
    @method     
    @abstract   Searches for registered MIDI devices
    @discussion Searches for registered MIDI devices
*/
-(void)rescanDevices;
-(IBAction)rescanDevices:(id)sender;

/*!
    @method     
    @abstract   Called from +sharedInstance
    @discussion Called from +sharedInstance
*/
-(id)_hiddenInit;


/*!
    @method     
    @abstract   Binds a port to a entity
    @discussion Binds a port to a entity
*/
-(OSStatus)bindPortToEntity:(CunddMIDIEntity *)theEntity;


/*!
    @method     
    @abstract   Binds a MIDI object with the given UID
    @discussion Searches for an MIDI object with an given UID and binds it to the clients input port
*/
-(id)bindPortToEntityWithUid:(NSInteger)theUid;


extern NSString * const kCunddMIDIDeviceReceivedData;
extern NSString * const kCunddMIDIDeviceInformationDidChange;

@property (assign) MIDIPortRef inputPort;
@property (assign) MIDIPortRef outputPort;
@property (assign) MIDIClientRef midiClient;


@property (retain) CunddMIDISource * sourcePoint;
@property (retain) CunddMIDIDestination * destinationPoint;
@property (retain) NSMutableArray * devices;
@end
