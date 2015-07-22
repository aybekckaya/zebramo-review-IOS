//
//  TFJson.m
//  TechTest1
//
//  Created by aybek can kaya on 6/5/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "TFJson.h"

@implementation TFJson

+(id)JsonToObject:(NSString *)Json
{
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    
    
   
    id jsonObject = [jsonParser objectWithString:Json];
    
    return  jsonObject;
}


+(NSString *)ObjectToJson:(id)Object
{
    if(!([Object isKindOfClass:[NSArray class]] || [Object isKindOfClass:[NSDictionary class]] ))
    {
        return nil;
    }
    
    SBJsonWriter *sw=[[SBJsonWriter alloc]init];
    NSString *json=[sw stringWithObject:Object];
    
    return json;
}


@end
