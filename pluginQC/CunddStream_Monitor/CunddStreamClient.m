//
//  CunddStreamClient.m
//  CunddStream_Monitor
//
//  Created by Daniel Corn on 02.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddStreamClient.h"


@implementation CunddStreamClient

-(id) init{
	if([super init]){
		self.debug = TRUE;
		self.services = [NSMutableArray array];
	}
	return self;
}

-(void) startStream:(id)sender{
	BOOL cancelAfterTime = NO;
	
	if(!_countSkippedUpdates){
		_countSkippedUpdates = 0;
	}
	if(!_maxSkippedUpdates){
		[self debug:[NSString stringWithFormat:@"set _maxSkippedUpdates=%i",_maxSkippedUpdates]];
		_maxSkippedUpdates = 10;
	}
	[self debug:[NSString stringWithFormat:@"_countSkippedUpdates=%i",_countSkippedUpdates]];
	
	
	if(_countSkippedUpdates >= _maxSkippedUpdates && cancelAfterTime){ // Flush content
		if([currentDownload length]){
			[self.outputString release];
			self.outputString = [[NSString alloc] initWithData:currentDownload encoding:NSUTF8StringEncoding];
			
			[currentDownload release];
			currentDownload = nil;			
		}
		if(_oldStream){
			[_oldStream close];
			_oldStream = nil;
		}
		
		_countSkippedUpdates = 0;
		_streamRunning = NO;
		
		[self debug:@"Old stream finished"];
	}
	/* */
	
	
	if(!_streamRunning && self.serverService){
		[self debug:@"startStream"];
		
		NSInputStream * istream;
		
		if([browserTable selectedRow] != -1){
			if([self.services objectAtIndex:[browserTable selectedRow]]){
				serverService = [self.services objectAtIndex:[browserTable selectedRow]];
			}
		}
		
		[self.serverService getInputStream:&istream outputStream:nil];
		
		if(!istream){
			_countSkippedUpdates = 0;
			return;
		}
		[istream retain];
		[istream setDelegate:self];
		[istream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[istream open];	
		
		_streamRunning = YES;
	}
	_countSkippedUpdates++;
}


#pragma mark NSNetServiceBrowser delegate methods
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
	
	printf("\n");
	NSLog(@"CunddStreamClient: didFindService %@",aNetService);
	[self.services addObject:aNetService];
	
	
	[aNetService retain];
	[aNetService setDelegate:self];
	[aNetService resolveWithTimeout:5.0];
	
	if(!moreComing){
		NSMutableArray * oldServices = self.services;
		self.services = [self.services copy];
		[oldServices release];
	}
}

#pragma mark NSNetService delegate methods
-(void) netServiceDidResolveAddress:(NSNetService *)sender{
	self.serverService = sender;
}

#pragma mark NSStreamDelegate methods
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)event {
	switch(event) {
        case NSStreamEventHasBytesAvailable:
            if (!currentDownload) {
                currentDownload = [[NSMutableData alloc] initWithCapacity:409600];
            }
            uint8_t readBuffer[4096];
            int amountRead = 0;
            NSInputStream * is = (NSInputStream *)aStream;
            amountRead = [is read:readBuffer maxLength:4096];
            [currentDownload appendBytes:readBuffer length:amountRead];
			
			//[self debug:[NSString stringWithFormat:@"stream %s",readBuffer]];
			if(!_oldStream) _oldStream = (NSInputStream *)aStream;
			
            break;
        case NSStreamEventEndEncountered:
            [(NSInputStream *)aStream close];
			if(![currentDownload length]){
				_streamRunning = NO;
				break;
			}
			
			[self.outputString release];
			NSString * tempOut = [[[NSString alloc] initWithData:currentDownload encoding:NSUTF8StringEncoding] retain];
			self.outputString = [[NSString stringWithFormat:@"%@: %@",self.serverService.name,tempOut] retain];
			[tempOut release];
			
			[currentDownload release];
            currentDownload = nil;
			_countSkippedUpdates = 0;
			_streamRunning = NO;
			[self debug:@"Stream finished"];
            break;
        default:
            break;
    }
}

-(void) debug:(NSString *)msg{
	if(self.debug != 0 && self.debug){
		NSLog(@"CunddStreamClient: %@",msg);
	}
}


- (void)browse:(id)sender{
	if(self.services){
		NSLog(@"CunddStreamClient: services to release:%@",self.services);
		[self.services release];
	}
	self.services = [NSMutableArray array];
	
	browser = [[NSNetServiceBrowser alloc] init];
    [browser setDelegate:self];
	
	_countSkippedUpdates = 0;
    
	[self debug:@"start browsing"];
	
    // Passing in "" for the domain causes us to browse in the default browse domain
    [browser searchForServicesOfType:@"_cunddQCStream._tcp." inDomain:@""];
}


@synthesize outputString,browser,services,currentDownload,serverService,debug,_countSkippedUpdates,_maxSkippedUpdates,browserTable;
@end
