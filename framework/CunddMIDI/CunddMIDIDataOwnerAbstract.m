//
//  CunddMIDIDataOwner.m
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

#import "CunddMIDIDataOwnerAbstract.h"


@implementation CunddMIDIDataOwnerAbstract
-(id) init{
	if([super init]){
		NSString * lock = @"locked";
		@synchronized(lock){
			packetData = [[NSMutableData data] retain];
			
			const int eins = 1;
			NSNumber * tempNum = [NSNumber numberWithInt:eins];
			output = [[NSNumber numberWithInt:1] copy];
		}
	}
	return self;
}


-(void) setOutput:(NSNumber *)theValue{
	NSString * lock = @"locked";
	@synchronized(lock){
		[output release];
		output = theValue;
		[theValue retain];
	}
}

-(void) setPacketData:(NSMutableData *)theValue{
	Byte vale[3];
	[theValue getBytes:&vale length:3];
	//	NSLog(@"MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWfreak %X%X%X.",vale[0],vale[1],vale[2]);
	
	NSString * lock = @"locked";
	@synchronized(lock){
		packetData = nil;
		if(packetData)
			[packetData release];
		
		packetData = theValue;
		
		[packetData getBytes:&vale length:3];
		//		NSLog(@"MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWfreak %X %X %i.",vale[0],vale[1],vale[2]);
		//		NSLog(@"set");
		
		[theValue retain];
		
		Byte velocityL = vale[2];
		self.output = [NSNumber numberWithInt:velocityL];
		//		[self setValue:[NSNumber numberWithInt:vale[2]] forKey:@"output"];
		//		NSLog(@"self.value=%@",self.value);
		
	}
}

-(NSDictionary *)dataAsDictionary{
	NSValue * commandV;
	NSValue * sentKeyV;
	NSValue * velocityV;
	Byte * sentCommand	= malloc(1);
	Byte * sentKey		= malloc(1);
	Byte * sentVelocity = malloc(1);
	
	NSMutableData * currentPacketData = self.packetData;
	
	[currentPacketData getBytes:sentCommand	range:NSMakeRange(0, 1)];
	if([currentPacketData length] >= 2)	[currentPacketData getBytes:sentKey		range:NSMakeRange(1, 1)];
	if([currentPacketData length] >= 3)	[currentPacketData getBytes:sentVelocity	range:NSMakeRange(2, 1)];
	
	
//	NSLog(@"%X %X %X",*sentCommand,*sentKey,*sentVelocity);
	
	commandV = [NSValue valueWithPointer:sentCommand];
	sentKeyV = [NSValue valueWithPointer:sentKey];
	velocityV = [NSValue valueWithPointer:sentVelocity];
	
	[commandV getValue:&sentCommand];
	[sentKeyV getValue:&sentKey];
	[velocityV getValue:&sentVelocity];
	/* */
	
	
//	NSLog(@"ES IST %X %X %X",*sentCommand,*sentKey,*sentVelocity);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			commandV,@"command",
			sentKeyV,@"sentKey",
			sentKeyV,@"key",
			velocityV,@"velocity",
			nil
			];
}
-(NSString *)dataAsString{
	Byte * cCommand;
	Byte * cSentKey;
	Byte * cVelocity;
	
	[self getCommand:&cCommand];
	[self getKey:&cSentKey];
	[self getVelocity:&cVelocity];
	
	return [NSString stringWithFormat:@"%X %X %X",*cCommand,*cSentKey,*cVelocity];
}

-(NSString *)customDescription{
	Byte * sentCommand	= malloc(1);
	Byte * sentKey		= malloc(1);
	Byte * sentVelocity = malloc(1);
	
	if([packetData length] > 0){
		[self.command getValue:&sentCommand];
		[self.key getValue:&sentKey];
		[self.velocity getValue:&sentVelocity];
	}
	
	NSDictionary * descDict = [NSDictionary dictionaryWithObjectsAndKeys:
							   [NSString stringWithFormat:@"%X",*sentCommand],@"command",
							   [NSString stringWithFormat:@"%X",*sentKey],@"key",
							   [NSString stringWithFormat:@"%X",*sentVelocity],@"velocity",
							   nil
							   ];
	
	free(sentCommand);
	free(sentKey);
	free(sentVelocity);
	
	
	return [NSString stringWithFormat:@"%@",descDict];
}

-(NSString *) keyAsString{
	Byte * tBuffer = malloc(1);
	[self.key getValue:&tBuffer];
	NSString * returnString = [NSString stringWithFormat:@"%X",*tBuffer];
	free(tBuffer);
	
	return returnString;
}

-(NSValue *)command{
	return [[self dataAsDictionary] objectForKey:@"command"];
}
-(NSValue *)key{
	return [[self dataAsDictionary] objectForKey:@"key"];
}
-(NSValue *)velocity{
	return [[self dataAsDictionary] objectForKey:@"velocity"];
}

-(void) getCommand:(Byte **)buffer{
	Byte * tBuffer = malloc(1);
	
	[self.command getValue:&tBuffer];
	*buffer = tBuffer;
	free(tBuffer);
}
-(void) getKey:(Byte **)buffer{
	Byte * tBuffer = malloc(1);
	
	[self.key getValue:&tBuffer];
	*buffer = tBuffer;
	free(tBuffer);
}
-(void) getVelocity:(Byte **)buffer{
	Byte * tBuffer = malloc(1);
	
	[self.velocity getValue:&tBuffer];
	*buffer = tBuffer;
	free(tBuffer);
}

-(void) dealloc{
	[output release];
	[super dealloc];
}


@synthesize packetData,output;
@end
