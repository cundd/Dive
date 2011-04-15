//
//  CunddConfig.m
//  Menu
//
//  Created by Daniel Corn on 15.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddConfig.h"


@implementation CunddConfig

/*
        static CunddConfig *sharedCunddConfigInstance = NULL;

+(id) alloc {

    @synchronized(self) {
        if (sharedCunddConfigInstance == NULL)
            sharedCunddConfigInstance = [[super alloc] init];
    }
    return (sharedCunddConfigInstance);
}
/* */

-(id) init {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL * fileURL = [NSURL fileURLWithPath : [mainBundle pathForResource : @"config" ofType : @"plist"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath : [fileURL path]]) {
        self.configData = [NSMutableDictionary dictionaryWithContentsOfURL : fileURL];
        [self.configData retain];
    } else {
        NSLog(@"CunddConfig: config-file not found at %@", [fileURL path]);
    }
    return self;
}

+(id) valueForKeyPath : (NSString *) path {
    CunddConfig * cunddConfigInstance = [CunddConfig sharedInstance];
    id value = [cunddConfigInstance valueForKeyPath:path];
    return value;
}

-(id) valueForKeyPath : (NSString *) path {
	id value = [self.configData valueForKeyPath : path];
	
	if(value == nil){
		NSLog(@"CunddConfig: No configuration found for path %@",path);
	}
	/*
	NSLog(@"%s",object_getClassName(value));
	if(object_getClassName(value) == "NSCFBoolean"){
		NSLog(@"FASDFDSF");
		value = [value boolValue];
	}
	/* */
	return value;
}

+(BOOL)isTrue:(NSString *)path{
	if([[self valueForKeyPath:path]boolValue] == 0){
		return NO;
	} else {
		return YES;
	}
}

+(NSString *) stringForKeyPath:(NSString *)path{
	return [NSString stringWithFormat:@"%@",[self valueForKeyPath:path]];
}


+(NSString *) notificationForKeyPath:(NSString *)path{
	NSString * completePath = [NSString stringWithFormat:@"Constants.%@",path];
	return [self stringForKeyPath:completePath];
}

+(NSString *) constForKeyPath:(NSString *)path{
	NSString * completePath = [NSString stringWithFormat:@"Constants.%@",path];
	return [self stringForKeyPath:completePath];
}


+(id) defaultForKeyPath:(NSString *)path{
	return [self valueForKeyPath:[NSString stringWithFormat:@"Defaults.%@",path]];
}



+(id)sharedInstance{
	static id sharedInstance = nil;
	
	
	if(sharedInstance == nil){
		sharedInstance = [[[super allocWithZone:NULL] init] autorelease];
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


@synthesize configData;
@end
