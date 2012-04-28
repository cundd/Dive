//
//  CunddDiveEffectArgument.h
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
//#import "CunddDiveEffectInfo.h"

@interface CunddDiveEffectArgument : CunddObject {
	NSDictionary * effect;
	id argValue;
}


/*!
 @method     
 @abstract   Returns a new instance with the given object as data-source
 @discussion Returns a new instance with the given object as data-source
 */
+(CunddDiveEffectArgument *)argumentWithEffect:(NSDictionary *)parent;
/*!
 @method     
 @abstract   Returns a new instance with the given object as data-source
 @discussion Returns a new instance with the given object as data-source
 */
-(CunddDiveEffectArgument *)initWithEffect:(NSDictionary *)parent;


/*!
 @method     
 @abstract   Returns a new instance with the given object as data-source
 @discussion Returns a new instance with the given object as data-source
 */
+(CunddDiveEffectArgument *)argumentWithDictionary:(NSDictionary *)parent;
/*!
 @method     
 @abstract   Returns a new instance with the given object as data-source
 @discussion Returns a new instance with the given object as data-source
 */
-(CunddDiveEffectArgument *)initWithDictionary:(NSDictionary *)parent;


/*!
    @method     
    @abstract   Return a new instance with empty properties
    @discussion Return a new instance with empty properties
*/
+(CunddDiveEffectArgument *)argumentDummy;
/*!
 @method     
 @abstract   Return a new instance with empty properties
 @discussion Return a new instance with empty properties
 */
-(CunddDiveEffectArgument *)initArgumentDummy;



@property (retain,readonly) NSString *name,*type,*Name,*Type;
@property (retain,readonly) NSNumber *min,*max;
@property (retain) NSDictionary * effect;
@property (retain) id argValue;
@end
