//
//  CunddUISegmentedControlAppMIDIMapCreatorRecord.h
//  CunddMIDI
//
//  Created by Daniel Corn on 24.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddUISegmentedControlAppMapCreatorRecord.h>
#import <CunddMIDI/CunddAppMIDIMapCreator.h>

@interface CunddUISegmentedControlAppMIDIMapCreatorRecord : CunddUISegmentedControlAppMapCreatorRecord {
	CunddAppMIDIMapCreator * mapCreator;
	NSString * _oldTitle;
}
extern NSString * const kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults;
@property (retain) CunddAppMIDIMapCreator * mapCreator;
@end
