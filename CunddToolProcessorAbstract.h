//
//  CunddToolsProcessor.h
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
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
