//
//  CunddITunesTrack.m
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddITunesTrack.h"

@implementation CunddITunesTrack

+ (CunddITunesTrack *)trackWithDictionary:(NSDictionary *)track {
    return [[self alloc]initWithDictionary:track];
}

-(CunddITunesTrack *)initWithDictionary:(NSDictionary *)track {
	if([super init]){
		trackinfo = track;
		[self.trackinfo retain];
	}
    

    return self;
}

-(id) valueForKey:(NSString *)key {
    if(self.ifDebug)NSLog(@"CunddITunesTrack valueForKey:%@", key);
    key = [self prepareKey:key];
    id returnValue;
    if (key == @"trackinfo") {
        returnValue = self.trackinfo;
    } else {
        returnValue = [[self.trackinfo valueForKey:key] copy];
    }

    return [self applyFormatterToValue:returnValue forKey:key];
}

-(void) setValue:(id)value forKey:(NSString *)key {
	NSString * lock = @"locked";
	@synchronized(lock){
		if (key == @"trackinfo") {
			self.trackinfo = value;
		} else {
			[self.trackinfo setValue:value forKey:key];
			[self.trackinfo retain];
		}
	}
    return;
}

-(id) applyFormatterToValue:(id)value forKey:(NSString *)key {
	id returnValue = value;
	
	if(self.ifDebug)NSLog(@"applyFormatterToValue:%@ forKey:%@", value, key);
	if ([key isLike : @"Total Time"]) {
		if(self.ifDebug)NSLog(@"MWMWMWMWMWM");
		double durationSeconds = [value doubleValue];
		NSDate * duration = [[NSDate alloc] initWithTimeIntervalSince1970:durationSeconds];
		//		NSDate * duration = [[NSDate alloc] initWithString:@"0000-00-00 00:00:00 +0000"];
		///		[duration addTimeInterval:durationSeconds];
		if(self.ifDebug)NSLog(@"%@ , double %i %d", [duration description], durationSeconds, durationSeconds);
		returnValue = [duration description];

		//		NSDateComponents* dateComponent = [[[NSDateComponents alloc] init] autorelease];
		//		[dateComponent setSecond:value];
		//
		//		NSCalendar* cal = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
		//						   autorelease];
		//
		//		NSDate* d = [cal dateFromComponents:dateComponent];
		//
		//		NSDateComponents* result = [cal components:NSHourCalendarUnit |
		//									NSMinuteCalendarUnit |
		//									NSSecondCalendarUnit
		//										  fromDate:d];
		//
		//		NSLog(@"%d hours, %d minutes, %d seconds",
		//		[result hour], [result minute], [result second]);
    }
    if(self.ifDebug)NSLog(@"after applyFormatterToValue");
    return returnValue;
}

-(id) valueForUndefinedKey:(NSString *)key{
	if(self.ifDebug)NSLog(@"CunddITunesTrack valueForUndefinedKey:%@", key);
	return [self valueForKey:key];
}

-(NSString *) prepareKey:(NSString *)key {
	NSMutableString *keyTemp = [NSMutableString stringWithString:key];
	[keyTemp replaceOccurrencesOfString:@"_"
							 withString:@" "
								options:NSLiteralSearch
								  range:NSMakeRange(0, [keyTemp length])
	 ];
	return [NSString stringWithString:keyTemp];
}


-(BOOL)ifDebug{
	if([[CunddConfig valueForKeyPath:@"Debug.CunddITunes.Track"]boolValue] == 0){
		return NO;
	} else {
		return YES;
	}
}


+(CunddITunesTrack *) emptyTrack{
	static CunddITunesTrack * theEmptyTrack;
	
	if(!theEmptyTrack){
		NSDictionary * emptyTrackinfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"Name",@"",@"Artist",[NSNumber numberWithInt:0],@"Total Time",@"",@"BPM",@"",@"Year",@"",@"Location",@"",@"Kind",nil];
		theEmptyTrack = [self trackWithDictionary:emptyTrackinfo];
	}
	return theEmptyTrack;
}


+(CunddITunesTrack *) emptyTrackWithMovieLocation:(NSString *)theLocation{
	NSLog(@"%@",theLocation);
	NSDictionary * emptyTrackinfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"Name",@"",@"Artist",[NSNumber numberWithInt:0],@"Total Time",@"",@"BPM",@"",@"Year",theLocation,@"Location",@"",@"Kind",nil];
	CunddITunesTrack * newEmptyTrack = [self trackWithDictionary:emptyTrackinfo];
	NSLog(@"%@",newEmptyTrack.trackinfo);
	return newEmptyTrack;
}

+(CunddITunesTrack *)liveVideoTrack{
	static CunddITunesTrack * theLiveVideoTrack;
	
	if(!theLiveVideoTrack){
		NSDictionary * trackinfo = [NSDictionary dictionaryWithObjectsAndKeys:
									@"Cundd live video",@"Name",
									NSUserName(),@"Artist",
									[NSNumber numberWithInt:0],@"Total Time",
									@"",@"BPM",
//									[NSNumber numberWithInt:[[NSDate date] year]],@"Year",
									@"2011",@"Year",
									@"cunddlivevideo:/",@"Location",
									@"",@"Kind",
									@"9999999",@"Track ID",
									nil];
		theLiveVideoTrack = [self trackWithDictionary:trackinfo];
	}
	return theLiveVideoTrack;
}

@synthesize trackinfo;
@end
