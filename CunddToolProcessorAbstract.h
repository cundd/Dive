//
//  CunddToolsProcessor.h
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddObject.h>


@interface CunddToolProcessorAbstract : CunddObject {
	NSNumber * value;
	NSNumber * frameRate;
@private
	NSTimer * _timer;
}

extern NSUInteger const kCunddToolProcessorStandardFrameRate;

/*!
    @method     
    @abstract   Returns an instance with the given frameRate.
    @discussion Returns an instance with the given frameRate.
*/
+(id)processorWithFrameRate:(NSNumber *)theFrameRate;


/*!
    @method     
    @abstract   Returns an instance with the given frameRate.
    @discussion Returns an instance with the given frameRate.
*/
-(id)initWithFrameRate:(NSNumber *)theFrameRate;


/*!
    @method     
    @abstract   Processes the value at the current time of the NSTimer _timer.
    @discussion Processes the value at the current time of the NSTimer _timer. A dictionary containing special arguments may be passed.
*/
-(BOOL)processWithArguments:(NSDictionary *)arguments;


/*!
 @method     
 @abstract   Processes the value at the current time of the NSTimer _timer.
 @discussion Processes the value at the current time of the NSTimer _timer. A dictionary containing special arguments may be passed.
 NOTE: This is the place for the actual processing.
 */
-(BOOL)processAtTime:(NSTimeInterval)time arguments:(NSDictionary *)arguments;


/*!
    @method     
    @abstract   Starts the timer.
    @discussion Starts the timer.
*/
-(BOOL)startTimer;


/*!
    @method     
    @abstract   Stops the timer.
    @discussion Stops the timer.
*/
-(BOOL)stopTimer;


/*!
    @method     
    @abstract   Reset the timer.
    @discussion Reset the timer.
*/
-(BOOL)resetTimer;



@property (retain) NSNumber * value;
@property (retain) NSNumber * frameRate;

@end
