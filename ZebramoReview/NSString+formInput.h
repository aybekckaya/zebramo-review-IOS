//
//  NSString+formInput.h
//  TechnoTest
//
//  Created by aybek can kaya on 1/4/14.
//  Copyright (c) 2014 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPPZReachability.h"

typedef void(^ValidationBlock)(BOOL validity);
//typedef void(^EmailFailureBlock)(NSError *err);

@interface NSString (formInput)

+(NSDictionary *)reasonsDisallowenceFormInput;

+(NSCharacterSet *)letterSet;

-(NSString *)trimWhitespacesFromBegin;

-(NSString *)trimWhitespacesFromEnd;

-(NSString *)trimWhitespacesFromBeginAndEnd;

-(NSString *)trimWhitespacesInString;

-(BOOL)isValidName:(NSString **)invalidReason TurkishCharacterSet:(BOOL) isTurkish;

/* 
    for real check make http request on class that imported this class
 */
-(BOOL)isValidURL;

-(BOOL)isValidEmail;

-(BOOL)isValidNameBasic;

-(BOOL)isValidPhoneNumberWithNumDigits:(int)numDigits;

-(void)isValidEmailWithBlock:(ValidationBlock) successBlock ;

-(void)isValidURLWithBlock:(ValidationBlock)successBlock;

-(NSString *)encodeString;

@end
