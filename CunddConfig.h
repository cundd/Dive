//
//  CunddConfig.h
//  Menu
//
//  Created by Daniel Corn on 15.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CunddConfig : NSObject {
	NSDictionary * configData;
}

/*!
 @method     
 @abstract   Returns a config value
 @discussion Returns a config value specified by a keyPath-like string.
 */
+(id)valueForKeyPath:(NSString *)path;


/*!
 @method     
 @abstract   Returns a config value
 @discussion Returns a config value specified by a keyPath-like string.
 */
-(id)valueForKeyPath:(NSString *)path;


/*!
 @method     
 @abstract   Checks if a config value can be evaluated as TRUE
 @discussion Checks if a config value can be evaluated as TRUE
 */
+(BOOL)isTrue:(NSString *)path;

/*!
    @method     
    @abstract   Returns a config value as NSString
    @discussion Returns a config value specified by a keyPath-like string and parsed to a NSString through +stringWithFormat:@"%@".
*/
+(NSString *)stringForKeyPath:(NSString *)path;



/*!
    @method     
    @abstract   Return a notification entry
    @discussion Return a notification entry specified by a keyPath-like string.
*/
+(NSString *)notificationForKeyPath:(NSString *)path;


/*!
    @method     
    @abstract   Return a constant specified by a path
    @discussion Return a constant specified by a path
*/
+(NSString *)constForKeyPath:(NSString *)path;


/*!
    @method     
    @abstract   Returns the default value for the given path.
    @discussion Returns the configuration value for the given path in the Defaults directory.
*/
+(id)defaultForKeyPath:(NSString *)path;


@property (retain) NSDictionary * configData;
@end
