//
//  CunddHTTPServer.m
//  Dive
//
//  Created by Daniel Corn on 30.08.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddHTTPServer.h"


@implementation CunddHTTPServer
+(id) serverWithPortNumber:(NSInteger)thePortNumber andDelegate:(id)theDelegate{
	return [[self alloc] initWithPortNumber:thePortNumber andDelegate:theDelegate];
}


-(id) initWithPortNumber:(NSInteger)thePortNumber andDelegate:(id)theDelegate{
	if([self init]){
		portNumber = thePortNumber;
		delegate = theDelegate;
		NSInteger fileDescriptor;
		fileDescriptor = -1;
		
		// Start the server
		// NSSocketPort version:
		/*
		socketPort = [[NSSocketPort alloc] initWithTCPPort:portNumber];
		fileDescriptor = [socketPort socket];
		/* */
		
		CFSocketRef socket;
		socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM,
								IPPROTO_TCP, 0, NULL, NULL);
		if(socket){
			fileDescriptor = CFSocketGetNative(socket);
			int yes = 1;
			setsockopt(fileDescriptor, SOL_SOCKET, SO_REUSEADDR, (void *)&yes, sizeof(yes));
			
			struct sockaddr_in addr;
			memset(&addr, 0, sizeof(addr));
			addr.sin_len = sizeof(addr);
			addr.sin_family = AF_INET;
			addr.sin_port = htons(portNumber);
			addr.sin_addr.s_addr = htonl(INADDR_ANY);
			NSData *address = [NSData dataWithBytes:&addr length:sizeof(addr)];
			if(CFSocketSetAddress(socket, (CFDataRef)address) != 			   kCFSocketSuccess ) {
				NSLog(@"Could not bind to address");
			}
		} else {
			NSLog(@"No server socket");
		}
		
		
		
		if(fileDescriptor == -1 || fileDescriptor == 0){
			[self throw:@"FileDescriptor Error"];
		} else {
			
		}
		
		fileHandle = [[NSFileHandle alloc] initWithFileDescriptor:fileDescriptor closeOnDealloc:YES];
		
		if(!fileHandle) return nil;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newConnection:) name:NSFileHandleConnectionAcceptedNotification object:fileHandle];
		[fileHandle acceptConnectionInBackgroundAndNotify];
		
		
		
		
		
		NSLog(@"CunddHTTPServer: Server started");
		NSLog(@"%@",self);
	}
	return self;
}



-(id) init{
	if([super init]){
		connections = [[NSMutableArray array] retain];
		requests	= [[NSMutableArray array] retain];
	}
	return self;
}



-(void) newConnection:(NSNotification *)notif{
	NSDictionary * userInfo = [notif userInfo];
	NSFileHandle * remoteFileHandle = [userInfo objectForKey:NSFileHandleNotificationFileHandleItem];
	
	[fileHandle acceptConnectionInBackgroundAndNotify];
	
	NSNumber * errorNr = [userInfo objectForKey:@"NSFileHandleError"];
	if(errorNr){
		[self throw:@"NSFileHandleError" reason:[NSString stringWithFormat:@"NSFileHandle Error: %@",errorNr]];
	}
	
	if(remoteFileHandle){
		CunddHTTPConnection * newConnection = [[CunddHTTPConnection alloc] initWithFileHandle:remoteFileHandle handler:delegate];
		
		if(newConnection){
			//[self debug:@"New connection"];
			NSIndexSet *insertedIndexes;
			insertedIndexes = [NSIndexSet indexSetWithIndex:[connections count]];
			
			[self willChange:NSKeyValueChangeInsertion 
			 valuesAtIndexes:insertedIndexes 
					  forKey:@"connections"];
			
			[connections addObject:newConnection];
			
			[self didChange:NSKeyValueChangeInsertion
			valuesAtIndexes:insertedIndexes 
					 forKey:@"connections"];
		}
	}
}

-(NSString *) description{
	NSMutableString * addresses = [NSMutableString stringWithFormat:@""];
	for(NSString * address in [[NSHost currentHost] addresses]){
		[addresses appendFormat:@" %@",address];
	}
	
	return [NSString stringWithFormat:@"CunddHTTPServer listening on port %i through the IP addresses %@.",portNumber,addresses];
}



-(void) dealloc{
	[connections release];
	[requests release];
	
	[super dealloc];
}
@end
