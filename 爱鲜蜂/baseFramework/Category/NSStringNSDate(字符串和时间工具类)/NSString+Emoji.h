//
//  Created by chenangel on 16/5/20.
//  Copyright © 2016年 chuhan. All rights reserved.
//  Emoji表情字符串解析

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
@end
