//
//  CunddMIDIDataOwner.h
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddMIDI/CunddMIDIDataOwnerAbstract.h>
#import <CunddMIDI/CunddMIDIData.h>


@interface CunddMIDIDataOwner : CunddMIDIDataOwnerAbstract {
	NSMutableDictionary * notes;
}
@property (retain) NSMutableDictionary * notes;
@end
