//
//  CunddMIDIDataOwner.h
//  MidIn
//
//  Created by Daniel Corn on 17.06.10.
//
//	Copyright © 2010 Corn Daniel
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//	software and associated documentation files (the "Software"), to deal in the Software 
//	without restriction, including without limitation the rights to use, copy, modify, 
//	merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
//	permit persons to whom the Software is furnished to do so, subject to the following 
//	conditions: 
//	The above copyright notice and this permission notice shall be included in all copies 
//	or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
//	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
//	CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
//	OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//

#import <Cocoa/Cocoa.h>
#import <CunddMIDI/CunddMIDIObject.h>



@interface CunddMIDIDataOwnerAbstract : CunddMIDIObject {
	NSMutableData * packetData;
	NSNumber * output;
}

/*!
 @method     
 @abstract   Returns the current data as a dictionary
 @discussion Returns the current data split up into a dictionary with the keys "command", "key" and "velocity"
 */
-(NSDictionary *)dataAsDictionary;


/*!
    @method     
    @abstract   Returns a string of the data in hexadecimal form
    @discussion Returns a string of the data in hexadecimal form
*/
-(NSString *)dataAsString;

/*!
    @method     
    @abstract   Copies the receiver's command value into a given buffer.
    @discussion Copies the receiver's command value into a given buffer.
*/
-(void)getCommand:(Byte **)buffer;

/*!
    @method     
    @abstract   Copies the receiver's key value into a given buffer.
    @discussion Copies the receiver's key value into a given buffer.
*/
-(void)getKey:(Byte **)buffer;

/*!
    @method     
    @abstract   Copies the receiver's velocity value into a given buffer.
    @discussion Copies the receiver's velocity value into a given buffer.
*/
-(void)getVelocity:(Byte **)buffer;


/*!
    @method     
    @abstract   Returns the key property as string in the format %X.
    @discussion Returns the key property as string in the format %X.
*/
-(NSString *)keyAsString;

-(NSString *)customDescription;

@property (retain) NSMutableData * packetData;
@property (retain) NSNumber * output;

@property (readonly) NSValue * command;
@property (readonly) NSValue * key;
@property (readonly) NSValue * velocity;
@end
