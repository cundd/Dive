//
//  CunddHTTPConnection.h
//  Dive
//
//  Created by Daniel Corn on 30.08.10.
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
#import "CunddHTTPHandlerProtocol.h"



@interface CunddHTTPConnection : NSObject {
	NSFileHandle * fileHandle;
	id handler;
	
	NSString * clientAddress;
	NSString * httpVersion;
	
	CFHTTPMessageRef message;
	BOOL messageComplete;
	
/*	NSInteger _code;
	NSDictionary * _headers;
	NSData * _body;*/
}


/*!
    @method     
    @abstract   Returns a new instance with the given filehandle and data provider.
    @discussion Returns a new instance with the given filehandle and delegate.
*/
-(id)initWithFileHandle:(NSFileHandle *)theFileHandle handler:(id)theHandler;


/*!
 @method     
 @abstract   Replies to the client.
 @discussion Creates a HTTP message and sends it to the client.
 */
-(void) replyWithStatusCode:(NSInteger)theCode headers:(NSDictionary *)theHeaders body:(NSData *)theBody;


/*!
 @method     
 @abstract   Replies to the client.
 @discussion Creates a HTTP message and sends it to the client.
 */
-(void)replyWithStatusCode:(NSInteger)theCode;


/*!
    @method     
    @abstract   Replies to the client.
    @discussion Creates a HTTP message with data from the dictionary and sends it to the client.
*/
-(void)replyWithDataFromDictionary:(NSDictionary *)dictionary;


/*!
    @method     
    @abstract   Invoked when data is received.
    @discussion Invoked when data is received.
*/
-(void)dataReceivedNotification:(NSNotification *)notif;


/*!
    @method     
    @abstract   Close the connection.
    @discussion Close the connection.
*/
-(void)close;


@property (readonly)	NSFileHandle * fileHandle;
@property (readonly)	BOOL messageComplete;
@property (retain)		NSString * httpVersion;

/*@property (assign)		NSInteger code;
@property (retain)		NSDictionary * headers;
@property (retain)		NSData * body;*/

@end
