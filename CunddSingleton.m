//
//  CunddSingleton.m
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
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
