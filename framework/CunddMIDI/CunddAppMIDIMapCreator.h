//
//  CunddAppMIDIMapCreator.h
//  CunddMIDI
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddAppAbstractMapCreator.h>
#import <CunddMIDI/CunddMIDI.h>
#import <CunddCore/CunddAppAbstractHandler.h>


@interface CunddAppMIDIMapCreator : CunddAppAbstractMapCreator {
	CunddMIDIClient * midiClient;
}

/*!
    @method     
    @abstract   Waits for incoming MIDI data.
    @discussion Waits for incoming MIDI data.
*/
-(void)receivedMIDIData:(NSNotification *)notif;


@property (assign) CunddMIDIClient * midiClient;
@end
