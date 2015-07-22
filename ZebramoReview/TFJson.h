//
//  TFJson.h
//  TechTest1
//
//  Created by aybek can kaya on 6/5/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface TFJson : NSObject

+(id)JsonToObject:(NSString *)Json;

+(NSString *)ObjectToJson:(id)Object;

@end
