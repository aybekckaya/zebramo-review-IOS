//
//  User.m
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "User.h"

@implementation User


-(id)initWithDictionary:(NSDictionary *)dct
{
    if(self = [super init])
    {
        self.ID = [dct[@"id"] intValue];
        self.status = dct[@"status"] ;
        self.createdTimeString = dct[@"created"];
        self.forename = dct[@"forename"];
        self.surname = dct[@"surname"];
        self.email = dct[@"email"];
        self.imageURL = dct[@"image"];
        self.descriptionUser = dct[@"description"];
        self.nationality = dct[@"nationality"];
        self.city = dct[@"city"];
        self.country = dct[@"country"];
        self.username = dct[@"username"];
        self.displaySurname = [dct[@"display_surname"] boolValue];
        self.overgarments = dct[@"overgarments"];
        self.undergarments = dct[@"undergarments"];
        self.shoeSize = dct[@"shoeSize"];
        
        
        
    }
    
    return self;
}

@end
