//
//  NSString+Size.h
//  sq580.com.user
//
//  Created by hjw119 on 15/11/13.
//  Copyright © 2015年 hjw. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  NSString类别扩展
 *  作用：
 *  获取NSString文本内容自适应的大小
 *  历史：
 *  1.2015-11-13：新创建。
 */
@interface NSString (Size)

- (CGSize)boundingSizeWithFont:(UIFont*)font maxBoundingSize:(CGSize)maxBoundingSize;

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

@end
