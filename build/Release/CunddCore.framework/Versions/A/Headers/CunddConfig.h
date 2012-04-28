//
//  CunddConfig.h
//  Menu
//
//  Created by Daniel Corn on 15.04.10.
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
