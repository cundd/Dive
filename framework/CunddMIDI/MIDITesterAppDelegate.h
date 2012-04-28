//
//  MidInAppDelegate.h
//  MidIn
//
//  Created by Daniel Corn on 12.06.10.
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
#import <CunddMIDI/CunddMIDI.h>
#import <CunddMIDI/CunddAppMIDIMapCreator.h>


@interface MIDITesterAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	CunddMIDIClient * midiClient;
	CunddMIDIEntity * launchpad;
	NSTextField * key;
	
	NSNumber * value1;
	NSNumber * value2;
	NSNumber * value3;
	NSNumber * value4;
	NSNumber * value5;
	NSNumber * value6;
	NSNumber * value7;
	NSNumber * value8;
	
	
	
	NSMutableDictionary * _keysStates;
	CunddAppMIDIMapCreator * mapCreator;
	BOOL _on;
}

-(IBAction)sendData:(id)sender;
-(IBAction)toggleRecording:(id)sender;

extern NSString * const kCunddMIDIButtonStateOnPress;
extern NSString * const kCunddMIDIButtonStateOnRelease;
extern NSString * const kCunddMIDIButtonStateOffPress;
extern NSString * const kCunddMIDIButtonStateOffRelease;

@property (retain) IBOutlet CunddMIDIClient * midiClient;
@property (retain) IBOutlet CunddMIDIEntity * launchpad;
@property (retain) IBOutlet NSTextField * key;
@property (assign) IBOutlet NSWindow *window;


@property (retain) NSNumber * value1;
@property (retain) NSNumber * value2;
@property (retain) NSNumber * value3;
@property (retain) NSNumber * value4;
@property (retain) NSNumber * value5;
@property (retain) NSNumber * value6;
@property (retain) NSNumber * value7;
@property (retain) NSNumber * value8;

@end
