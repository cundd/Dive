//
//  CunddUIButtonAppMIDIMapCreator.h
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddUIButtonAppMapCreatorRecord.h>
#import <CunddMIDI/CunddAppMIDIMapCreator.h>


@interface CunddUIButtonAppMIDIMapCreatorRecord : CunddUIButtonAppMapCreatorRecord {
	CunddAppMIDIMapCreator * mapCreator;
	NSString * _oldTitle;
}
extern NSString * const kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults;
@property (retain) CunddAppMIDIMapCreator * mapCreator;
@end
