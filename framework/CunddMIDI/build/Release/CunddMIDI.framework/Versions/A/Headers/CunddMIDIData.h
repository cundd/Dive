//
//  CunddMIDIData.h
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddMIDI/CunddMIDIDataOwnerAbstract.h>


@interface CunddMIDIData : CunddMIDIDataOwnerAbstract {
}


/*!
    @method     
    @abstract   Returns an instance with all values set to zero.
    @discussion Returns an instance with all values set to zero.
*/
+(id)zeroMIDIData;

/*!
    @method     
    @abstract   Returns a new data object with the given data.
    @discussion Returns a new data object with the given data.
*/
+(id)MIDIDataWithMutableData:(NSMutableData *)theData;
/*!
    @method     
    @abstract   Returns a new data object with the given data.
    @discussion Returns a new data object with the given data.
*/
-(id)initWithMutableData:(NSMutableData *)theData;
@end
