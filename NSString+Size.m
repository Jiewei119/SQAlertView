//
//  NSString+Size.m
//  sq580.com.user
//
//  Created by hjw119 on 15/11/13.
//  Copyright © 2015年 hjw. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)boundingSizeWithFont:(UIFont*)font maxBoundingSize:(CGSize)maxBoundingSize {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:maxBoundingSize
                                             options:NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
