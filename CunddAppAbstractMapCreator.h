//
//  CunddAppAbstractMapCreator.h
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddSingleton.h>
#import <CunddCore/NSControl+CunddAppMapCreator.h>


typedef enum{
	CunddAppAbstractMapCreatorControlTypeClick,
	CunddAppAbstractMapCreatorControlTypeValue
} CunddAppAbstractMapCreatorControlType;


@interface CunddAppAbstractMapCreator : CunddSingleton {
	NSControl * control;
	NSString * controlBinding;
	id controlController;
	CunddAppAbstractMapCreatorControlType * controlType;
	
	id caller;
	NSString * callerBinding;
	
	NSDictionary * newMapping;
	NSDictionary * map;
	
	BOOL recording;
}

extern NSString * const kCunddAppAbstractMapCreatorControlType;
extern NSString * const kCunddAppMapCreatorCurrent;
extern NSString * const kCunddAppMapCreatorRecording;


/*!
    @method     
    @abstract   Toggles the recording.
    @discussion Toggles the recording.
*/
-(IBAction)toggleRecording:(id)sender;


/*!
    @method     
    @abstract   Toggles the recording.
    @discussion Toggles the recording.
*/
-(void)toggleRecording;


/*!
    @method     
    @abstract   Invoked before the recording starts.
    @discussion Invoked before the recording starts.
*/
-(void)willStartRecording;


/*!
    @method     
    @abstract   Starts the actual recording.
    @discussion Starts the actual recording.
*/
-(BOOL)startRecording;


/*!
    @method     
    @abstract   Invoked after the recording did start.
    @discussion Invoked after the recording did start.
*/
-(void)didStartRecording;


/*!
    @method     
    @abstract   Invoked before the recording stops.
    @discussion Invoked before the recording stops.
*/
-(void)willStopRecording;


/*!
    @method     
    @abstract   Stops the actual recording.
    @discussion Stops the actual recording.
*/
-(BOOL)stopRecording;


/*!
    @method     
    @abstract   Invoked after the recording did stop.
    @discussion Invoked after the recording did stop.
*/
-(void)didStopRecording;


/*!
    @method     
    @abstract   Returns the path for the defaults.
    @discussion Returns the path for the defaults.
*/
-(NSString *)defaultsPath;


/*!
 @method     
 @abstract   Invoked before the first object of a mapping is recorded.
 @discussion Invoked before the first object of a mapping is recorded.
 */
-(void)willRecordControl;


/*!
    @method     
    @abstract   Prepares the first object of a mapping.
    @discussion Prepares all necessary data of the first object of the mapping.
*/
-(NSEvent *)recordControl:(NSControl *)theControl withEvent:(NSEvent *)theEvent;


/*!
    @method     
    @abstract   Checks the clicked-at control.
    @discussion Checks the clicked-at control.
*/
-(void)checkControl;


/*!
    @method     
    @abstract   Writes the mapping to the user defaults.
    @discussion Writes the mapping to the user defaults.
*/
-(BOOL)save;


/*!
    @method     
    @abstract   Reads the mapping from the user defaults.
    @discussion Reads the mapping from the user defaults.
*/
-(BOOL)open;

/*!
    @method     
    @abstract   Invoked afte the data is read from the user defaults.
    @discussion Invoked afte the data is read from the user defaults. This is the method to handle the read data.
*/
-(void)didOpen;


/*!
    @method     
    @abstract   Deletes the defaults.
    @discussion Deletes the defaults.
*/
-(BOOL) clearDefaults;




/*!
    @method     
    @abstract   Traverse the clicked-at objects bindings.
    @discussion Traverse the clicked-at objects bindings to get the relevant object and binding-string.
*/
-(NSDictionary *)traverseBindingsOfObject:(id)theObject;


/*!
    @method     
    @abstract   Gets the connection to the objects model.
    @discussion Gets the connection to the objects model.
*/
-(NSDictionary *)getModelForObject:(id)theObject;


/*!
    @method     
    @abstract   Invoked after the first object of a mapping is recorded.
    @discussion Invoked after the first object of a mapping is recorded.
*/
-(void)didRecordControl;


/*!
    @method     
    @abstract   Starts to wait for a caller to record.
    @discussion Starts to wait for a caller to record.
*/
-(void)waitForCaller;


/*!
    @method     
    @abstract   Invoked before the second object of a mapping is recorded.
    @discussion Invoked before the second object of a mapping is recorded.
*/
-(void)willRecordCaller;


/*!
    @method     
	@abstract   Prepares the second object of a mapping.
	@discussion Prepares all necessary data of the second object of the mapping.
*/
-(BOOL)recordCaller:(id)theCaller;


/*!
 @method     
 @abstract   Invoked after the first object of a mapping is recorded.
 @discussion Invoked after the first object of a mapping is recorded.
 */
-(void)didRecordCaller;

@property (retain) NSDictionary * map;
@property (retain) NSDictionary * newMapping;
@property (retain) NSControl * control;
@property (retain) NSString * callerBinding;
@property (retain) NSString * controlBinding;
@property (retain) id controlController;
@property (retain) id caller;
@property (assign) CunddAppAbstractMapCreatorControlType * controlType;
@property (assign) BOOL recording;
@end
