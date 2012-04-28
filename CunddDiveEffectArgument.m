//
//  CunddDiveEffectArgument.m
//  Dive
//
//  Created by Daniel Corn on 29.04.10.
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

#import "CunddDiveEffectArgument.h"


@implementation CunddDiveEffectArgument
-(id) init{
	// Prohibit empty initialization
	return nil;
}
+(CunddDiveEffectArgument *) argumentWithDictionary:(NSDictionary *)parent{
	return [self argumentWithEffect:parent];
}
+(CunddDiveEffectArgument *) argumentWithEffect:(NSDictionary *)parent{
	return [[[self alloc] initWithEffect:parent] autorelease];
}
-(CunddDiveEffectArgument *) initWithDictionary:(NSDictionary *)parent{
	return [self initWithEffect:parent];
}
-(CunddDiveEffectArgument *) initWithEffect:(NSDictionary *)parent{
	if([super init]){
		[self.effect release];
		self.effect = parent;
		[parent retain];
	}
	return self;
}
+(CunddDiveEffectArgument *) argumentDummy{
	return [[[self alloc] initArgumentDummy] autorelease];
}
-(CunddDiveEffectArgument *) initArgumentDummy{
	if([super init]){
		NSMutableDictionary * tempEffect = [NSMutableDictionary dictionary];
		[tempEffect setObject:@"dummy" forKey:@"Name"];
		[tempEffect setObject:@"dummy" forKey:@"Type"];
		[tempEffect setObject:[NSNumber numberWithInt:0] forKey:@"min"];
		[tempEffect setObject:[NSNumber numberWithInt:0] forKey:@"max"];
		
		effect = [NSDictionary dictionaryWithDictionary:tempEffect];
		argValue = [NSNumber numberWithInt:0];
		[effect retain];
		[argValue retain];
	}
	return self;
}

-(id) valueForKey:(NSString *)key{
	[self debug:@"CunddDiveEffectArgument valueForKey:%@" o:key];
	return [super valueForKey:key];
}
-(id) valueForUndefinedKey:(NSString *)key{
	[self debug:@"CunddDiveEffectArgument valueForUndefinedKey:%@" o:key ];
	return [super valueForUndefinedKey:key];
}

-(NSString *) name{
	return [self.effect valueForKey:@"Name"];
}
-(NSString *) Name{
	return [self.effect valueForKey:@"Name"];	
}

-(NSString *) type{
	return [self.effect valueForKey:@"Type"];
}
-(NSString *) Type{
	return [self.effect valueForKey:@"Type"];
}

-(NSNumber *) min{
	return [self.effect valueForKey:@"min"];
}
-(NSNumber *) max{
	return [self.effect valueForKey:@"max"];
}

-(void) setArgValue:(id)value{
	[self debug:@"setArgValue to %@" o:value];
	
	NSString * notificationName = [CunddConfig valueForKeyPath:@"Constants.CunddDive.Notifications.HandleEffectArgumentChange"];
	[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
	
	argValue = value;
}
//@property (retain) NSString *name,*type,*Name,*Type;
//@property (retain) NSNumber *min,*max;
//@property (retain) CunddDiveEffect * effect;
@synthesize effect,argValue;
@end
