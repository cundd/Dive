//
//  CunddDiveEffectArgument.h
//  Dive
//
//  Created by Daniel Corn on 29.04.10.
//  Copyright 2010 cundd. All rights reserved.
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
