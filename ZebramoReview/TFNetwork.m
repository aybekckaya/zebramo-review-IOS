//
//  TFNetwork.m
//  NetWork
//
//  Created by aybek can kaya on 5/8/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "TFNetwork.h"


//#import "EPPZReachability.h"



#define TIME_OUT 10


typedef void (^ TimeOutBlock)(NSURLRequest *, id , float);

@implementation TFNetwork




-(void)jsonQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
   /*
  [Reachability reachabilityWithBlock:^(BOOL isReachable) {
     
     if(isReachable)
     {
         NSLog(@"Reachable");
     }
      else
      {
           NSLog(@"UN Reachable");
      }
      
  }];
    */
    
    // network connection tipine gorre degisecek
    float timeOutValue=TIME_OUT;
    
    TimeOutBlock blockTimeOut=timeOut;
   
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeOutValue target:self selector:@selector(timeOutSelector:) userInfo:@{@"block": blockTimeOut} repeats:NO];
    
    // make URL
   // url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlObj=[NSURL URLWithString:url];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlObj];
    
  [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable)
        {
            //**network reachable**
            
            AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                
                //**On Success**
                [timer invalidate];
                timer=nil;
                
                NSLog(@"JSON Parse Edilmis: %@", JSON);
                success(request,response,JSON);
                
                
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                // **On Error**
                    [timer invalidate];
                    timer=nil;
                failure(request,response,error,JSON);
                
             }];
            [operation start];

        }
        else
        {
            // **network unreachable**
            [timer invalidate];
            timer=nil;
            reachabilityError(nil,nil,timeOutValue,nil);
        }
        
    }];
    
    
    
    
}


-(void)sourceQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSData *, NSString *))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
    

    
    // network connection tipine gorre degisecek
    float timeOutValue=TIME_OUT;
    
    TimeOutBlock blockTimeOut=timeOut;
    
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeOutValue target:self selector:@selector(timeOutSelector:) userInfo:@{@"block": blockTimeOut} repeats:NO];
    
    // make URL
   //  url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlObj=[NSURL URLWithString:url];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlObj];
    
      [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable)
        {
            //**network reachable**
            
            AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                // ** success **
                [timer invalidate];
                timer = nil;
                NSString *strData = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                success(urlRequest,nil,responseObject,strData);
                
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //**failure **
                 [timer invalidate];
                 timer = nil;
                 failure(urlRequest,nil,error,nil);
            }];
            [operation start];
        }
        else
        {
            // **network unreachable**
            [timer invalidate];
            timer=nil;
            reachabilityError(nil,nil,timeOutValue,nil);
        }
        
    }];
    

}

-(void)postQueryWithBlock:(NSString *)url postDictionary:(NSDictionary *)postDct success:(void (^)(NSString *, NSHTTPURLResponse *, NSString *))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
    
  //   url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    // split string
    NSArray *splitURL=[url componentsSeparatedByString:@"/"];
    
    NSString *baseURLOnQuery=@"";
    NSString *extensionURLOnQuery;
    
    for(int i=0 ; i< splitURL.count-1 ; i++)
    {
        baseURLOnQuery=[NSString stringWithFormat:@"%@/%@",baseURLOnQuery,splitURL[i]];
    }
    baseURLOnQuery=[baseURLOnQuery substringWithRange:NSMakeRange(1, baseURLOnQuery.length-1)];
    baseURLOnQuery=[NSString stringWithFormat:@"%@/",baseURLOnQuery];
    baseURLOnQuery=[baseURLOnQuery stringByReplacingOccurrencesOfString:@" " withString:@""];
    extensionURLOnQuery = splitURL[splitURL.count-1];
    
    NSDictionary *params = postDct;
    
    [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable == YES)
         {
             //**reachable**
             AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                                     [NSURL URLWithString:baseURLOnQuery]];
             
             [client postPath:extensionURLOnQuery parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 // ** success **
                 NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                 success (url,responseObject,jsonStr);
                 
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                  // ** failure **
                 
                 failure(nil,nil,error,nil);
                 
             }];
         }
         else
         {
             //** unreachable **
             reachabilityError(nil,nil,TIME_OUT,nil);
         }
         
     }];


}

- (void)timeOutSelector:(NSTimer *)timer
{
    NSDictionary *userDct = [timer userInfo];
     TimeOutBlock b=[userDct objectForKey:@"block"];
    b(nil,nil,0);
   
}


+(NSString *)connectionType
{
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    //NSLog(@"Current Radio Access Technology: %@", telephonyInfo.currentRadioAccessTechnology);
    return telephonyInfo.currentRadioAccessTechnology;
}




@end
