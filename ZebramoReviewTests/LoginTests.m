//
//  LoginTests.m
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginVC.h"
#import "DAL.h"
#import "User.h"
#import "TFJson.h"
#import "NSObject+KJSerializer.h"

@interface LoginTests : XCTestCase

@property(nonatomic,strong) LoginVC *viewController;

@end

@interface LoginVC(Test)

-(BOOL)validateInputsEmail:(NSString *)emailAddress password:(NSString *)passwordString;

@end


@implementation LoginTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
    self.viewController = [[LoginVC alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark TESTS 

-(void)testInputValidation
{
    NSString *email;
    NSString *password;
    BOOL isValid;
    
    // valid mail
    
    email =  @"aybekcankaya@icloud.com";
    password = @"abcabc";
    
    isValid = [self.viewController validateInputsEmail:email password:password];
    XCTAssertEqual(isValid, YES);
    
    
    // invalid mail
    
    email =  @"aybekcankayaicloudcom";
    password = @"abcabc";
    
    isValid = [self.viewController validateInputsEmail:email password:password];
    XCTAssertEqual(isValid, NO);
    
    
    email = @"adskdjs";
    isValid = [self.viewController validateInputsEmail:email password:password];
    XCTAssertEqual(isValid, NO);
    
    email = @"";
    isValid = [self.viewController validateInputsEmail:email password:password];
    XCTAssertEqual(isValid, NO);
    
    
    
    
    
    // valid pass
    
    email =  @"aybekcankaya@icloud.com";
    password = @"asd";
    
    isValid = [self.viewController validateInputsEmail:email password:password];
    XCTAssertEqual(isValid, YES);
    
    
    
    // invalid pass
    
    email =  @"aybekcankaya@icloud.com";
    password = @"";
    
    isValid = [self.viewController validateInputsEmail:email password:password];
    XCTAssertEqual(isValid, NO);
}



-(void)testHandleLoginDataString
{
    DAL *oo =[[DAL alloc]initwithPlistName:@"JsonDataString"];
    NSString *json= [oo ReadFromPlistWithKey:@"correctJSON"];
    
    NSDictionary *dctAll = [TFJson JsonToObject:json];
    NSDictionary *dctUser = dctAll[@"user"];
    User *user = [[User alloc]initWithDictionary:dctUser];
    
    NSDictionary *dctFromUserObject = [user getDictionary];
    
    NSArray *keys = [dctFromUserObject allKeys];
    
    XCTAssertNotEqual(keys.count , 0);
    
    
    
    
    
    
}


-(void)testHandleLoginDataStringUncorrectInputs
{
    
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
