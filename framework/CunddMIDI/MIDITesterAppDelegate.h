//
//  MidInAppDelegate.h
//  MidIn
//
//  Created by Daniel Corn on 12.06.10.
//  Copyright 2010 cundd. All rights reserved.
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
