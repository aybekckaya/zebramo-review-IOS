//
//  NSString+Regex.h
//  NsPredicateRegex
//
//  Created by aybek can kaya on 8/2/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)


-(NSString *)replaceWithRegex:(NSString *)expression Replacement:(NSString *)replacement;

-(NSMutableArray *) GetMatchWithRegex:(NSString *) Exp;

-(BOOL)isMatching:(NSString *)expression;

@end
