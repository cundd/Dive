//
//  CunddDiveEffectLibrary.h
//  Dive
//
//  Created by Daniel Corn on 29.04.10.
//  Copyright 2010 cundd. All rights reserved.
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
