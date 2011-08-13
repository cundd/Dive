//
//  CunddAppMIDIHandler.h
//  Dive
//
//  Created by Daniel Corn on 18.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddAppAbstractHandler.h>
#import <CunddCore/CunddAppAbstractMapCreator.h>
#import <CunddMIDI/CunddAppMIDIMapCreator.h>
#import "CunddMIDI.h"


@interface CunddAppMIDIHandler : CunddAppAbstractHandler {
	CunddMIDIClient * client;
	NSArray * userDefaultEntities;
}

/*!
    @method     
    @abstract   Returns an array containing the entity UIDs the user specified.
    @discussion Returns an array containing the entity UIDs the user specified.
*/
-(NSArray *)getUserDefaultEntities;


/*!
    @method     
    @abstract   Post a notification if one is assigned to the MIDI notification.
    @discussion Post a notification if one is assigned to the MIDI notification.
*/
-(BOOL)handleMIDINotification:(NSNotification *)notif;

extern NSString * const kCunddAppMIDIHandlerUserDefaultsEntitiesPath;

@property (retain) NSArray * userDefaultEntities;
@property (retain) CunddMIDIClient * client;
@end
