//
//  CunddAppMIDIHandler.h
//  Dive
//
//  Created by Daniel Corn on 18.06.10.
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
