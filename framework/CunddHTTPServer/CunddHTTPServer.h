//
//  CunddHTTPServer.h
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
#import <CunddCore/CunddObject.h>

#import "CunddHTTPConnection.h"

#include <sys/socket.h>
#import <netinet/in.h>


@interface CunddHTTPServer : CunddObject {
	NSInteger portNumber;
	
	id delegate;
	NSSocketPort * socketPort;
	NSFileHandle * fileHandle;
	
	NSMutableArray * connections;
	NSMutableArray * requests;
}


/*!
 @method     
 @abstract   Returns a new instance that listens at the given portnumber.
 @discussion Returns a new instance that listens at the given portnumber.
 */
+(id)serverWithPortNumber:(NSInteger)thePortNumber andDelegate:(id)theDelegate;


/*!
    @method     
    @abstract   Returns a new instance that listens at the given portnumber.
    @discussion Returns a new instance that listens at the given portnumber.
*/
-(id)initWithPortNumber:(NSInteger)thePortNumber andDelegate:(id)theDelegate;


/*!
    @method     
    @abstract   Invoked when a new connection is accepted.
    @discussion Invoked when a new connection is accepted.
*/
-(void)newConnection:(NSNotification *)notif;
@end
