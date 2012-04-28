//
//  CunddChoserController.m
//
//  Created by Daniel Corn on 25.05.10.
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
		// */
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
