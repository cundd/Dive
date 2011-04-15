//
//  StructureToStringPlugIn.h
//  StructureToString
//
//  Created by Daniel Corn on 27.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface StructureToStringPlugIn : QCPlugIn <NSXMLParserDelegate>
{
	NSString * cunddOutputStringCache;
	NSDictionary * cunddOutputDictionaryCache;
}

/*!
    @method     
    @abstract   Returns a string containing the serialized dictionary
    @discussion Returns a string containing the serialized dictionary
*/
-(NSString *)serializeDictionary:(NSDictionary *)aDictionary;

/*!
 @method     
 @abstract   Returns a dictionary unserialized from the given string
 @discussion Returns a dictionary unserialized from the given string
 */
-(NSDictionary *)unserializeDictionary:(NSString *)serializedDictString;

// Ports
@property (assign) NSDictionary * inputStructure;
@property (assign) NSString		* outputString;

@property (assign) NSString		* inputString;
@property (assign) NSDictionary * outputStructure;

// Properties
@property (retain) NSDictionary * cunddOutputDictionaryCache;
@property (retain) NSString * cunddOutputStringCache;

@end
