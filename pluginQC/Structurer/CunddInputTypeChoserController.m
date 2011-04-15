//
//  CunddChoserController.m
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddInputTypeChoserController.h"

@implementation CunddInputTypeChoserController
-(id) content{
	if(!content){
		/*
		NSNumber * Number	= [NSNumber numberWithInt:CunddInputTypeNumber];
		NSNumber * String	= [NSNumber numberWithInt:CunddInputTypeString];
		NSNumber * Color	= [NSNumber numberWithInt:CunddInputTypeColor];
		NSNumber * Int		= [NSNumber numberWithInt:CunddInputTypeInt];
		NSNumber * Bool		= [NSNumber numberWithInt:CunddInputTypeBool];
		NSNumber * Struct	= [NSNumber numberWithInt:CunddInputTypeStruct];
		/* */
		content = [[NSArray arrayWithObjects:
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Number",@"name",	QCPortTypeNumber,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"String",@"name",	QCPortTypeString,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Color",@"name",	QCPortTypeColor,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Int",@"name",		QCPortTypeIndex,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Bool",@"name",	QCPortTypeBoolean,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Struct",@"name",	QCPortTypeStructure,@"value",nil] retain],
					[[NSDictionary dictionaryWithObjectsAndKeys:@"Image",@"name",	QCPortTypeImage,@"value",nil] retain],
					nil
					] retain];
	}
	return content;
}
@end
