//
//  InputsToStructurePlugIn.h
//  InputsToStructure
//
//  Created by Daniel Corn on 26.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface InputsToStructurePlugIn : QCPlugIn
{
	NSDictionary * _outputDict;
}

@property (assign) NSString		* inputKey1, * inputKey2, * inputKey3, * inputKey4, * inputKey5, * inputKey6, * inputKey7, * inputKey8;
@property (assign) double		inputNumber1,inputNumber2,inputNumber3,inputNumber4,inputNumber5,inputNumber6,inputNumber7,inputNumber8;
@property (assign) NSString		* inputString1, * inputString2, * inputString3, * inputString4, * inputString5, * inputString6, * inputString7, * inputString8;
@property (assign) CGColorRef	inputColor1,inputColor2,inputColor3,inputColor4,inputColor5,inputColor6,inputColor7,inputColor8;
@property (assign) NSUInteger	inputInt1,inputInt2,inputInt3,inputInt4,inputInt5,inputInt6,inputInt7,inputInt8;
@property (assign) BOOL			inputBool1,inputBool2,inputBool3,inputBool4,inputBool5,inputBool6,inputBool7,inputBool8;
@property (assign) NSDictionary	* inputStruct1, * inputStruct2, * inputStruct3, * inputStruct4, * inputStruct5, * inputStruct6, * inputStruct7, * inputStruct8;

@property (assign) NSDictionary * outputOutput;

@end
