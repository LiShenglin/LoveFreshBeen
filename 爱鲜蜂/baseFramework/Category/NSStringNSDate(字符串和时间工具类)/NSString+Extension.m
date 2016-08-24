//
//  Created by chenangel on 16/5/20.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

+ (NSString *)string_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}
- (NSString *)cleanDecimalPointZear{
    NSString *newStr = self;
    NSMutableString *tempStr = [[NSMutableString alloc]init];
    NSInteger offset = newStr.length - 1;
    while (offset > 0) {
        tempStr = (NSMutableString*)[newStr substringWithRange:NSMakeRange(offset, 1)];
        if ([tempStr isEqualToString:@"0"] || [tempStr isEqualToString:@"."]) {
            offset--;
        }else{
            break;
        }
    }
    return [newStr substringToIndex:(offset + 1)];
}

@end
