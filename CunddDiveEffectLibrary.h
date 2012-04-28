//
//  CunddDiveEffectLibrary.h
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


@interface CunddDiveEffectLibrary : CunddObject {
	NSArray * library;
	NSArray * sortedLibrary;
	NSDictionary * libraryDictionary;
}

/*!
    @method     
    @abstract   Returns the shared instance
    @discussion Returns the shared instance
*/
+(CunddDiveEffectLibrary *)sharedLibrary;
/*!
    @method     
    @abstract   Return the effect at the given index from the library
    @discussion Return the effect at the given index from the library
*/
+(NSDictionary *)effectAtIndex:(NSUInteger)index;


/*!
 @method     
 @abstract   Return the effect at the given index from the library
 @discussion Return the effect at the given index from the library
 */
-(NSDictionary *)effectAtIndex:(NSUInteger)index;


/*!
    @method     
    @abstract   Return the effect with the given name from the library
    @discussion Return the effect with the given name from the library
*/
+(NSDictionary *) effectWithName:(NSString *)name;


/*!
 @method     
 @abstract   Return the effect with the given name from the library
 @discussion Return the effect with the given name from the library
 */
-(NSDictionary *) effectWithName:(NSString *)name;


/*!
    @method     
    @abstract   Removes the hidden effects from the library.
    @discussion Removes the hidden effects from the library.
*/
-(void)removeHidden;

@property (retain) NSArray * sortedLibrary;
@property (retain) NSArray * library;
@property (retain) NSDictionary * libraryDictionary;
@end
