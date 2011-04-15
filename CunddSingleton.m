//
//  CunddSingleton.m
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddSingleton.h"


@implementation CunddSingleton
+(id)sharedInstance{
	static NSMutableDictionary * sharedInstanceCollection = nil;
	id sharedInstance;
	NSString * classNameAsKey = [self className];
	
	
	if(sharedInstanceCollection == nil){
		sharedInstance = [[[super allocWithZone:NULL] init] autorelease];
		sharedInstanceCollection = [[[NSMutableDictionary alloc]initWithObjectsAndKeys:sharedInstance,classNameAsKey,nil] retain];
	} else if(![sharedInstanceCollection objectForKey:classNameAsKey]){
		sharedInstance = [[super allocWithZone:NULL] init];
		[sharedInstanceCollection setObject:sharedInstance forKey:classNameAsKey];
	} else {
		sharedInstance = [sharedInstanceCollection objectForKey:classNameAsKey];
	}
    
	return sharedInstance;
}

+(id)allocWithZone:(NSZone *)zone{
    return [[self sharedInstance] retain];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

-(id)retain{
    return self;
}

-(NSUInteger)retainCount{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

-(void)release{
    //do nothing
}

-(id)autorelease{
    return self;
}
@end
