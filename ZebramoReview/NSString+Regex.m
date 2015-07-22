//
//  NSString+Regex.m
//  NsPredicateRegex
//
//  Created by aybek can kaya on 8/2/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)


-(NSString *)replaceWithRegex:(NSString *)expression Replacement:(NSString *)replacement
{
    NSString *string = self;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
   
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:replacement];

    return modifiedString;
}



-(NSMutableArray *)GetMatchWithRegex:(NSString *)Exp
{
    NSMutableArray *MatchStrArr=[[NSMutableArray alloc] init];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:Exp options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *str = self;
    
    NSTextCheckingResult *AllMatches=(NSTextCheckingResult *)[regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    //int NumMatches=[match numberOfRanges];
    
    NSMutableArray *ArrayOfMatches=[[NSMutableArray alloc] init]; // Final Array
    
    for (NSTextCheckingResult *match in AllMatches)
    {
        int NumMatches=[match numberOfRanges];
        NSMutableArray *InlineArr=[[NSMutableArray alloc] init];
        
        for(int i=0; i<NumMatches ; i++)
        {
            NSMutableArray *matchStr= [str substringWithRange:[match rangeAtIndex:i]] ;
            
            [InlineArr addObject:matchStr];
            
            //   NSLog(@"Matched Str %d: %@",i,matchStr);
        }
        
        [ArrayOfMatches addObject:InlineArr];
    }
    
    return ArrayOfMatches;

}


-(BOOL)isMatching:(NSString *)expression
{
    NSString *pattern=expression;
    NSString *string =self;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
    {
        didValidate = YES;
    }
    
    return didValidate;
}


@end
