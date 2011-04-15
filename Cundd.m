#import <Cundd.h>

@implementation Cundd
+(void) die{
	[NSApp terminate:nil];
}
+(void) die:(NSString *)msg{
	NSLog(@"%s: %@",object_getClassName(self),msg);
	[self die];
}
+(void) die:(NSString *)msg o:(id)aObject{
	NSString * msgCombined = [NSString stringWithFormat:msg,aObject];
	NSLog(@"%s: %@",object_getClassName(self),msgCombined);
	[self die];
}

+(void) throw:(NSString *)exceptionName{
	[self throw:exceptionName reason:exceptionName];
}
+(void) throw:(NSString *)exceptionName reason:(NSString *)aReason{
	NSString * exceptionNameWithSender = [NSString stringWithFormat:@"%s: %@",object_getClassName(self),exceptionName];
	
	NSException* myException = [NSException
								exceptionWithName:exceptionNameWithSender
								reason:aReason
								userInfo:nil];
	@throw myException;
}
@end