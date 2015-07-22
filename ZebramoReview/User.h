//
//  User.h
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
}

@property(nonatomic) int ID;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *createdTimeString;
@property(nonatomic,strong) NSString *forename;
@property(nonatomic,strong) NSString *surname;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString *imageURL;
@property(nonatomic,strong) NSString *descriptionUser;
@property(nonatomic,strong) NSString *nationality;
@property(nonatomic,strong) NSString *country;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *username;
@property(nonatomic) BOOL displaySurname;
@property(nonatomic , strong) NSString *overgarments;
@property(nonatomic , strong) NSString *undergarments;
@property(nonatomic,strong) NSString *shoeSize;

-(id)initWithDictionary :(NSDictionary *)dct;



@end
