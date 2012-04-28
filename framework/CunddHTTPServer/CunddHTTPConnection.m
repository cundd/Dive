//
//  CunddHTTPConnection.m
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

#import "CunddHTTPConnection.h"


@implementation CunddHTTPConnection
#pragma mark Initialisation
-(id)initWithFileHandle:(NSFileHandle *)theFileHandle handler:(id)theHandler{
	if([self init]){
		fileHandle = [theFileHandle retain];
		handler = [theHandler retain];
		message = NULL;
		messageComplete = YES;
		httpVersion = (NSString *)kCFHTTPVersion1_1;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceivedNotification:) name:NSFileHandleReadCompletionNotification object:fileHandle];
		
		[fileHandle readInBackgroundAndNotify];
	}
	return self;
}


#pragma mark Receive data
-(void) dataReceivedNotification:(NSNotification *)notif{
	NSData * data = [[notif userInfo] objectForKey:NSFileHandleNotificationDataItem];
	
	if([data length] == 0){ // The client closed the connection
		[self close];
	} else {
		[fileHandle readInBackgroundAndNotify];
		
		if(messageComplete){
			message = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, YES);
		}
		
		BOOL success = CFHTTPMessageAppendBytes(message, [data bytes], [data length]);
		
		if(success){
			if(CFHTTPMessageIsHeaderComplete(message)){
				CFURLRef url = CFHTTPMessageCopyRequestURL(message);
				
				// Let the delegate process the data
				NSDictionary * returnData = [handler processDataForURL:(NSURL *)url message:message];
				if(returnData){
					[self replyWithDataFromDictionary:returnData];
				} else {
					
				}
				
				CFRelease(url);
				CFRelease(message);
				message = NULL;
				messageComplete = YES;
				[self close];
			} else {
				messageComplete = NO;
			}
		} else {
			NSLog(@"Incomming message not a HTTP header, ignored.");
			[self close];
		}
	}
}



#pragma mark Reply
-(void) replyWithDataFromDictionary:(NSDictionary *)dictionary{
	NSInteger theCode = [[dictionary objectForKey:CunddHTTPMessageStatusCode] intValue];
	NSDictionary * theHeaders = [dictionary objectForKey:CunddHTTPMessageHeaders];
	NSData * theBody = [dictionary objectForKey:CunddHTTPMessageBody];
	
	[self replyWithStatusCode:theCode headers:theHeaders body:theBody];
}


-(void) replyWithStatusCode:(NSInteger)theCode headers:(NSDictionary *)theHeaders body:(NSData *)theBody{
	CFHTTPMessageRef msg;
	
	// Create with status code
	msg = CFHTTPMessageCreateResponse(kCFAllocatorDefault,
									  theCode,  // status code
									  NULL,		// use standard reason phrase
									  (CFStringRef)httpVersion);
	
	// Set headers with each key value pair in the headers dictionary
	if(theHeaders){
		for(NSString * key in [theHeaders allKeys]){
			CFHTTPMessageSetHeaderFieldValue(msg, (CFStringRef)key, (CFStringRef)[theHeaders objectForKey:key]);
		}
	}
	
	// Set the body
	CFHTTPMessageSetBody(msg, (CFDataRef)theBody);
	
	CFDataRef msgData = CFHTTPMessageCopySerializedMessage(msg);
	if(!msgData){
		NSLog(@"Error");
	}
	
	@try {
		[fileHandle writeData:(NSData *)msgData];
	} @catch (NSException *exception) {
		NSLog(@"Error while transmitting data");
		NSLog(@"Error while transmitting data %@",exception);
	}
	
	CFRelease(msgData);
    CFRelease(msg);
}


-(void) replyWithStatusCode:(NSInteger)theCode{
	CFHTTPMessageRef msg;
	
	// Create with status code
	msg = CFHTTPMessageCreateResponse(kCFAllocatorDefault,
									  theCode,  // status code
									  NULL,		// use standard reason phrase
									  (CFStringRef)httpVersion);
	
	CFDataRef msgData = CFHTTPMessageCopySerializedMessage(msg);
	
	@try {
		[fileHandle writeData:(NSData *)msgData];
	} @catch (NSException *exception) {
		NSLog(@"Error while transmitting data %@",exception);
	}
}



#pragma mark Close
-(void) close{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[fileHandle closeFile];
}



#pragma mark Dealloc
-(void) dealloc{
	if(message) CFRelease(message);
	[handler release];
	
	[fileHandle closeFile];
	[fileHandle release];
	
	[super dealloc];
}



#pragma mark Accessor methods
/*-(NSInteger) code{
	return _code;
}
-(void) setCode:(NSInteger)value{
	_code = value;
}


-(NSDictionary *) headers{
	return _headers;
}
-(void) setHeaders:(NSDictionary *)value{
	[_headers release];
	_headers = value;
	[value retain];
}


-(NSData *) body{
	return _body;
}
-(void) setBody:(NSData *)value{
	[_body release];
	_body = value;
	[value retain];
}*/

@synthesize fileHandle,messageComplete,httpVersion;
@end
