//
//  Created by chenangel on 16/5/20.
//  Copyright © 2016年 chuhan. All rights reserved.
//
//计算字符串尺寸

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

/** 字符串MD5简单加密 */
+ (NSString *)string_md5:(NSString *)string;

/**
 *  清楚字符串小数点末尾的零
 */
- (NSString *)cleanDecimalPointZear;
@end
