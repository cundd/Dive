//
//  CunddDiveScreenIndicatorController.h
//
//  Created by Daniel Corn on 17.07.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveScreen.h"
#import "CunddDiveScreenIndicatorView.h"

@interface CunddDiveScreenIndicatorController : NSObjectController {
    IBOutlet NSButton *back;
    IBOutlet NSButton *bottom;
    IBOutlet NSButton *front;
    IBOutlet NSButton *left;
    IBOutlet NSButton *right;
    IBOutlet NSButton *top;
	IBOutlet CunddDiveScreenIndicatorView * view;
}

/*!
    @method     
    @abstract   Receive a performed click.
    @discussion Receive a performed click.
*/
- (IBAction)performClick:(NSButton *)sender;

/*!
    @method     
    @abstract   Sets all buttons to off state.
    @discussion Sets all buttons to off state.
*/
-(void)setAllOff;

/*!
    @method     
    @abstract   Returns the CunddDiveScreen matching the sender.
    @discussion Returns the CunddDiveScreen matching the sender.
*/
-(CunddDiveScreen)determineStateFromSender:(id)sender;
/*!
    @method     
    @abstract   Performs a selector for each button.
    @discussion Performs a selector for each button.
*/
/*
-(void)performSelectorForAllButtons:(SEL)aSelector;
-(void)performSelectorForAllButtons:(SEL)aSelector withBool:(BOOL)flag;
-(void)performSelectorForAllButtons:(SEL)aSelector withObject:(id)anObject;
/* */

@property (retain) NSButton *back;
@property (retain) NSButton *bottom;
@property (retain) NSButton *front;
@property (retain) NSButton *left;
@property (retain) NSButton *right;
@property (retain) NSButton *top;

@property (retain) CunddDiveScreenIndicatorView * view;
@end
