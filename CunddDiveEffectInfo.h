//
//  CunddDiveEffect.h
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

#import <Cocoa/Cocoa.h>
#import "Cundd.h"
#import "CunddDiveEffectArgument.h"
#import "CunddDiveEffectLibrary.h"


@interface CunddDiveEffectInfo : CunddObject {
	NSString * name;
	NSString * type;
	NSString * desc;
	NSMutableArray * arguments;
	NSDictionary * libraryObject;
	
	CunddDiveEffectArgument * arg0;
	CunddDiveEffectArgument * arg1;
	CunddDiveEffectArgument * arg2;
	CunddDiveEffectArgument * arg3;
	CunddDiveEffectArgument * arg4;
	CunddDiveEffectArgument * arg5;
@private
	NSArray * _argumentsSource;
	CunddDiveEffectArgument * _emptyArgument;
}

/*!
    @method     
    @abstract   Returns a new instance with the data from a given dictionary
    @discussion Returns a new instance with the data from a given dictionary
*/
+(CunddDiveEffectInfo *)effectWithLibraryObject:(NSDictionary *)dictionary;
/*!
 @method     
 @abstract   Returns a new instance with the data from a given dictionary
 @discussion Returns a new instance with the data from a given dictionary
 */
-(CunddDiveEffectInfo *)initWithLibraryObject:(NSDictionary *)dictionary;


/*!
    @method     
    @abstract   Returns a new instance with the data associated with the given index in the effect library
    @discussion Returns a new instance with the data associated with the given index in the effect library
*/
+(CunddDiveEffectInfo *)effectWithLibraryObjectAtIndex:(NSUInteger)index;
/*!
 @method     
 @abstract   Returns a new instance with the data associated with the given index in the effect library
 @discussion Returns a new instance with the data associated with the given index in the effect library
 */
-(CunddDiveEffectInfo *)initWithLibraryObjectAtIndex:(NSUInteger)index;


/*!
    @method     
    @abstract   Returns the argument at the given index or nil if this index isn't set
    @discussion Returns the argument at the given index or nil if this index isn't set
*/
-(CunddDiveEffectArgument *)getArgumentIfIndexExists:(NSUInteger)index;

@property (retain) NSString * name;
@property (retain,readonly) NSString * type;
@property (retain,readonly) NSString * desc;
@property (retain) NSMutableArray * arguments;
@property (retain) NSDictionary * libraryObject;
@property (retain) NSArray * _argumentsSource;

@property (retain) CunddDiveEffectArgument * arg0;
@property (retain) CunddDiveEffectArgument * arg1;
@property (retain) CunddDiveEffectArgument * arg2;
@property (retain) CunddDiveEffectArgument * arg3;
@property (retain) CunddDiveEffectArgument * arg4;
@property (retain) CunddDiveEffectArgument * arg5;
@end
