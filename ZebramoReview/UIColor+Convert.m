//
//  UIColor+Convert.m
//  mstmd
//
//  Created by aybek can kaya on 8/29/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "UIColor+Convert.h"

@implementation UIColor (Convert)



+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}




@end
