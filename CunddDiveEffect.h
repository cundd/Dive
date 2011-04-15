//
//  CunddEffect.h
//  Dive
//
//  Created by Daniel Corn on 30.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h"
#import "CunddDiveEffectSettings.h"
#import "CunddDiveEffectInfo.h"
#import "CunddDiveEffectArgument.h"
#import "CunddDiveEffectLibraryValueTransformer.h"


@interface CunddDiveEffect : CunddObject {
	IBOutlet NSView * view;
	IBOutlet NSView * targetView;
	CunddDiveEffectInfo * info;
	NSNumber * index;
	NSString * name;
	NSString * desc;
	CunddDiveEffectArgument * arg0;
	CunddDiveEffectArgument * arg1;
	CunddDiveEffectArgument * arg2;
	CunddDiveEffectArgument * arg3;
	CunddDiveEffectArgument * arg4;
	CunddDiveEffectArgument * arg5;
	CunddDiveEffectArgument * arg6;
	NSMutableArray * arguments;
	id owner;
}


/*!
    @method     
    @abstract   Returns a new instance with a given view
    @discussion Returns a new instance with a given view
*/
+(CunddDiveEffect *)effectWithTargetView:(NSView *)aView andOwner:(id)theOwner;


/*!
    @method     
    @abstract   Returns a new instance with a given view
    @discussion Returns a new instance with a given view
*/
-(CunddDiveEffect *)initWithTargetView:(NSView *)aView andOwner:(id)theOwner;


/*!
    @method     
    @abstract   Returns an array containing all the values of the effects arguments
    @discussion Returns an array containing all the values of the effects arguments
*/
-(NSMutableArray *)collectArgumentValues;


/*!
    @method     
    @abstract   Reloads the data of the effect from the effect-library
    @discussion Reloads the data of the effect from the effect-library
*/
-(void)refreshEffectInfo;


/*!
    @method     
    @abstract   Resets the effect settings back to the defaults.
    @discussion Resets the effect settings back to the defaults.
*/
-(void)resetEffectArguments;

/*!
    @method     
    @abstract   Load the corresponding Nib-file
    @discussion Load the corresponding Nib-file, whoose file-name is the name of the effect with whitespaces (" ") replaced with an underscore ("_").
*/
-(void)loadNib;


//@property (retain) CunddDiveEffectSettings * settings;
@property (retain) CunddDiveEffectInfo * info;
@property (retain) NSNumber * index;
@property (retain) NSView * view, * targetView;

@property (retain) NSString * name;
@property (retain) NSString * desc;
@property (retain) NSMutableArray * arguments;
@property (retain) CunddDiveEffectArgument *  arg0;
@property (retain) CunddDiveEffectArgument *  arg1;
@property (retain) CunddDiveEffectArgument *  arg2;
@property (retain) CunddDiveEffectArgument *  arg3;
@property (retain) CunddDiveEffectArgument *  arg4;
@property (retain) CunddDiveEffectArgument *  arg5;
@property (retain) id owner;
@end
