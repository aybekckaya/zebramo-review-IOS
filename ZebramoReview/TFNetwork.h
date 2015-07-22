//
//  TFNetwork.h
//  NetWork
//
//  Created by aybek can kaya on 5/8/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
//#import "NSString+Additions.h"
#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import "Reachability.h"
//#import "NSTimer+Blocks.h"




@interface TFNetwork : NSObject
{
    
}


-(void) jsonQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure timeOut:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds))timeOut reachabilityError:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds,NSError *err))reachabilityError;

-(void) sourceQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSData *rawData,NSString *source))success
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure timeOut:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds))timeOut reachabilityError:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds,NSError *err))reachabilityError;

-(void) postQueryWithBlock:(NSString *)url postDictionary:(NSDictionary *)postDct success:(void (^)(NSString *theUrlStr, NSHTTPURLResponse *response, NSString * JSONString))success
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure timeOut:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds))timeOut reachabilityError:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds,NSError *err))reachabilityError;


-(void) putQueryWithBlock:(NSString *)url putDictionary:(NSDictionary *)postDct success:(void (^)(NSString *theUrlStr, NSHTTPURLResponse *response, NSString * JSONString))success
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure timeOut:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds))timeOut reachabilityError:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds,NSError *err))reachabilityError;



-(void)setNewTimeOutValue: (float) time_outNew;


/*
     connection via 3G , wifi ...
 */
+(NSString *)connectionType;

@end
