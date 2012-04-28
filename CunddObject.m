//
//  CunddObject.m
//  Dive
//
//  Created by Daniel Corn on 23.04.10.
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

#import "CunddObject.h"
#import </usr/include/objc/runtime.h>


@implementation CunddObject

-(BOOL) ifDebug{
	if(!_cunddObject_debug_determined){
		//NSLog(@"%@",[NSString stringWithFormat:@"Debug.%s",object_getClassName(self)]);
		if([[CunddConfig valueForKeyPath:
			 [NSString stringWithFormat:@"Debug.%s",object_getClassName(self)]
			 ]boolValue] == 0){
			_cunddObject_debug = NO;
		} else {
			_cunddObject_debug = YES;
		}
		_cunddObject_debug_determined = TRUE;
	}
	return _cunddObject_debug;
}



-(void)debug:(NSString *)msg o:(id)object o:(id)object2{
	if([self ifDebug]){
		NSString * msgCombined = [NSString stringWithFormat:msg,object,object2];
		NSLog(@"%s: %@",object_getClassName(self),msgCombined);
	}
}


-(void) debug:(NSString *)msg o:(id)object{
	if([self ifDebug]){
		NSString * msgCombined = [NSString stringWithFormat:msg,object];
		NSLog(@"%s: %@",object_getClassName(self),msgCombined);
	}
}


-(void) debug:(NSString *)msg{
	if([self ifDebug]){
		NSLog(@"%s: %@",object_getClassName(self),msg);
	}
}


/*
-(void)debug:(NSString *)msg o:(id)object, ...{
	if([self ifDebug]){
		NSMutableString *outputString = [NSMutableString string];
		
		va_list args;
		va_start(args, object);
		
		for(NSString * arg = object; arg != nil; arg = va_arg(args, NSString *)){
			[outputString appendString:[NSString stringWithFormat:@"%s ",arg]];
		}
		va_end(args);
		NSLog(@"%@",outputString);
		//[outputString release];
	}
}
// */





-(NSArray *)cundd_getPropertyList{
	NSMutableArray * tempArray = [NSMutableArray array];
	unsigned int outCount, i;
	
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	for(i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		const char *propName = property_getName(property);
		if(propName) {
			[tempArray addObject:[NSString stringWithUTF8String:propName]];
			//const char *propType = getPropertyType(property);
			//NSString *propertyName = [NSString stringWithUTF8String:propName];
			//NSString *propertyType = [NSString stringWithUTF8String:propType];
		}
	}
	free(properties);
	return [NSArray arrayWithArray:tempArray];
}


-(void) die{
	[NSApp terminate:nil];
}
-(void) die:(NSString *)msg{
	NSLog(@"%s: %@",object_getClassName(self),msg);
	[self die];
}
-(void) die:(NSString *)msg o:(id)aObject{
	NSString * msgCombined = [NSString stringWithFormat:msg,aObject];
	NSLog(@"%s: %@",object_getClassName(self),msgCombined);
	[self die];
}

-(void) throw:(NSString *)exceptionName{
	[self throw:exceptionName reason:exceptionName];
}
-(void) throw:(NSString *)exceptionName reason:(NSString *)aReason{
	NSString * exceptionNameWithSender = [NSString stringWithFormat:@"%s: %@",object_getClassName(self),exceptionName];
	
	NSException* myException = [NSException
								exceptionWithName:exceptionNameWithSender
								reason:aReason
								userInfo:nil];
	@throw myException;
}
@end
