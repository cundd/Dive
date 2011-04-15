//
//  CunddDiveMocMode.m
//  Dive
//
//  Created by Daniel Corn on 21.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveMocMode.h"


@implementation CunddDiveMocMode
+(CunddDiveMocMode *) mocModeWithScreen:(CunddDiveScreen)aScreen andEdgeMode:(CunddDiveEdgeMode)aEdgeMode inTheEnvironment:(CunddDiveScreen)aEnvironment{
	return [[[self alloc] initWithScreen:aScreen andEdgeMode:aEdgeMode inTheEnvironment:aEnvironment] autorelease];
}


-(CunddDiveMocMode *) initWithScreen:(CunddDiveScreen)aScreen andEdgeMode:(CunddDiveEdgeMode)aEdgeMode inTheEnvironment:(CunddDiveScreen)aEnvironment{
	if([self init]){
		screen = aScreen;
		edgeMode = aEdgeMode;
		environment = aEnvironment;
	}
	return self;
}


-(CunddDiveMocModes) mocMode{
	if(environment == 0){
		NSLog(@"CunddDiveMocMode: environment is not set");
		return CunddDiveMocModeNone;
	}
	if(edgeMode == 0){
		NSLog(@"CunddDiveMocMode: edgeMode is not set");
		return CunddDiveMocModeNone;
	}
	
	
	if(screen == CunddDiveScreenNone){
		return CunddDiveMocModeNone;
	}
	
	
	// If edgeMode is "clip" only the front-display will be drawed
	if(edgeMode == CunddDiveEdgeModeClip && screen == environment){
		mocMode = CunddDiveMocModeFront;
	} else if(edgeMode == CunddDiveEdgeModeClip && screen != environment){
		mocMode = CunddDiveMocModeNone;
	}
	// If edgeMode is "warp" the local mocMode is set corresponding to the current environment
	else if(edgeMode == CunddDiveEdgeModeWarp){
		mocMode = [self getRelationship];
	}
	
	return mocMode;
}


-(CunddDiveMocModes) getRelationship{
	switch(environment){
		// The environment is the front canvas
		case CunddDiveScreenFront:
			switch(screen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeFront;
					break;
				
				case CunddDiveScreenBack:
					return CunddDiveMocModeNone;
					break;
				
				case CunddDiveScreenLeft:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
				
				default:
					return CunddDiveMocModeNone;
					break;
			}
		
		// The environment is the back canvas
		case CunddDiveScreenBack:
			switch(screen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
		
		
		// The environment is the left canvas
		case CunddDiveScreenLeft:
			switch(screen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
		
		
		// The environment is the right canvas
		case CunddDiveScreenRight:
			switch(screen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
		
		
		// The environment is the top canvas
		case CunddDiveScreenTop:
			switch(screen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeBottom;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeNone;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
		
		
		// The environment is the bottom canvas
		case CunddDiveScreenBottom:
			switch(screen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeBottom;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeFront;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
		
		
		default:
			return CunddDiveMocModeNone;
	}
}
@synthesize environment,screen,edgeMode,mocMode;
@end
