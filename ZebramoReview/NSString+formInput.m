//
//  NSString+formInput.m
//  TechnoTest
//
//  Created by aybek can kaya on 1/4/14.
//  Copyright (c) 2014 aybek can kaya. All rights reserved.
//

#import "NSString+formInput.h"
#import "NSString+Regex.h"


#define Numerics_Disallowed @"Digits are not allowed"
#define NonAlphanumerics_Disallowed @"Only alphanumeric"

@implementation NSString (formInput)

ValidationBlock successBlockGlobal;

+(NSDictionary *)reasonsDisallowenceFormInput
{
    NSDictionary *dct=@{@"Numerics_Disallowed": Numerics_Disallowed , @"NonAlphanumerics_Disallowed":NonAlphanumerics_Disallowed};
    return dct;
}

-(NSString *)trimWhitespacesFromEnd
{
    NSUInteger location = 0;
    unichar charBuffer[[self length]];
    [self getCharacters:charBuffer];
    int i = 0;
    for ( i = [self length]; i >0; i--){
        if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:charBuffer[i - 1]]){
            break;
        }
    }
    return  [self substringWithRange:NSMakeRange(location, i  - location)];

}


-(NSString *)encodeString
{
    NSString *encodedString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedString;
}



-(NSString *)trimWhitespacesFromBegin
{
    NSString *finalStr=self;
    for(int i=0 ; i<self.length ; i++)
     {
         if([finalStr characterAtIndex:i] == ' ')
         {
             finalStr=[self substringWithRange:NSMakeRange(i, self.length-i)];
         }
         else
         {
             return finalStr;
         }
     }
    return finalStr;
}


-(NSString *)trimWhitespacesFromBeginAndEnd
{
    NSString *finalStr;
    finalStr=[self trimWhitespacesFromBegin];
    finalStr=[finalStr trimWhitespacesFromEnd];
    return finalStr;
}

-(NSString *)trimWhitespacesInString
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(BOOL)isValidNameBasic
{
    NSString *strToControl=[self trimWhitespacesFromBeginAndEnd];
    NSCharacterSet *theSet=[NSString letterSetAll];
    BOOL checkResult=[NSString checkWithSet:theSet String:strToControl];
    return  checkResult;
}

+(NSCharacterSet *)letterSetAll
{
    NSString *letters = @"qwxQWXığüşçöabcdefghijklmnoprstuvyzIĞÜŞÇÖABCDEFGHIJKLMNOPRSTUVYZ";
    NSCharacterSet *Letters = [NSCharacterSet characterSetWithCharactersInString:letters];
    return Letters;
}



+(NSCharacterSet *)letterSet
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSCharacterSet *Letters = [NSCharacterSet characterSetWithCharactersInString:letters];
    return Letters;
}

+(NSCharacterSet *)letterSetTurkish
{
    NSString *letters = @"ığüşçöabcdefghijklmnoprstuvyzIĞÜŞÇÖABCDEFGHIJKLMNOPRSTUVYZ";
    NSCharacterSet *Letters = [NSCharacterSet characterSetWithCharactersInString:letters];
    return Letters;
}

+(NSCharacterSet *)numericSet
{
    NSString *numeric=@"0123456789";
    NSCharacterSet *numerics=[NSCharacterSet characterSetWithCharactersInString:numeric];
    return numerics;
}



+(BOOL)checkWithSet:(NSCharacterSet *)theSet String:(NSString *)str
{
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *strControl=[str stringByTrimmingCharactersInSet:theSet];
    
    if([strControl isEqualToString:@""] == YES)
    {
        return YES;
    }
    return NO;
}


-(BOOL)isValidName:(NSString **)invalidReason TurkishCharacterSet:(BOOL) isTurkish
{
    *invalidReason=nil;
    NSString *strToControl=[self trimWhitespacesFromBeginAndEnd];
    NSCharacterSet *checkSet;
    if(isTurkish == YES)
    {
        checkSet=[NSString letterSetTurkish];
    }
    else
    {
        checkSet=[NSString letterSet];
    }
    
    if([NSString checkWithSet:checkSet String:strToControl] == NO)
    {
        // invalid reasons
        NSMutableCharacterSet *allowanceSet=[[NSMutableCharacterSet alloc]init];
        [allowanceSet formUnionWithCharacterSet:[NSString numericSet]];
        [allowanceSet formUnionWithCharacterSet:[NSString letterSet]];
        
        if([NSString checkWithSet:[NSString numericSet] String:strToControl] == NO)
        {
            *invalidReason=Numerics_Disallowed;
        }
        else if([NSString checkWithSet:allowanceSet String:strToControl] == NO)
        {
            *invalidReason = NonAlphanumerics_Disallowed;
        }
        return NO;
    }
    
    return YES;
}

-(BOOL)isValidURL
{
    // url with http regex : http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?
    
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    BOOL matching=[self isMatching:urlRegEx];
    
    if(matching == NO)
    {
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:self];
    if (!url) {
        return NO;
    }
    
    
    return YES;
}


-(void)isValidURLWithBlock:(ValidationBlock)successBlock
{
    if([self isValidURL] == NO)
    {
        successBlock(NO);
        return;
    }
    
    NSString *urlStr = self;
    
    successBlockGlobal=successBlock;
    /*
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"HEAD"];
    */
    
   // NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:9];
    [request setHTTPMethod:@"HEAD"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([(NSHTTPURLResponse *)response statusCode] == 200) {
        successBlockGlobal(YES);
    }
    else
    {
        successBlockGlobal(NO);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    successBlockGlobal(NO);
}

-(BOOL)isValidEmail
{
    NSString *emailRegex=@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    
    emailRegex = @"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
    
    BOOL matching=[self isMatching:emailRegex];
    
    return matching;

}

-(void)isValidEmailWithBlock:(ValidationBlock)successBlock
{
    
    NSString *pureStr = [self trimWhitespacesInString];
    NSString *strToCheck  = [pureStr stringByReplacingOccurrencesOfString:@"@" withString:@""];
    if(strToCheck.length == pureStr.length)
    {
        // @ yok
        successBlock(NO);
        return;
    }
    
    NSArray *arrString = [pureStr componentsSeparatedByString:@"@"];
    if(arrString.count != 2)
    {
        // there should be 1 @.
        successBlock(NO);
        return;
    }
    
    // get domain Part of string
    
    NSString *domain = arrString[1];
    
    NSString *domainer = [domain stringByReplacingOccurrencesOfString:@"." withString:@""];
    if(domainer.length == domain.length)
    {
        // . yok domain tarafinda
        
        successBlock(NO);
        return;
    }
    
    [EPPZReachability reachHost:domain completition:^(EPPZReachability *reachability) {
       
        if(reachability.reachable == YES)
        {
            successBlock(YES);
        }
        else
        {
            successBlock(NO);
        }
        
    }];
    
}


-(BOOL)isValidPhoneNumberWithNumDigits:(int)numDigits
{
    NSString *strToControl=[self trimWhitespacesInString];
    if(strToControl.length > numDigits || [NSString checkWithSet:[NSString numericSet] String:strToControl] == NO)
    {
        return NO;
    }
    return YES;
}

@end
