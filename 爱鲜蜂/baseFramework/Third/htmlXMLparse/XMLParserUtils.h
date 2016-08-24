//
//  XMLParserUtils.h
//  XMLParserDemo
//
//  Created by coder on 16/5/23.
//  Copyright © 2016年 coder. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  将html的字符串符号解析替换的工具
 *
 */
typedef void (^Complete)(NSArray *datas);

@class XMLParserContent;
@interface XMLParserUtils : NSObject

+ (instancetype)parserWithContent:(NSString *)content complete:(Complete)block;

- (instancetype)initParserWithContent:(NSString *)content complete:(Complete)block;

@end
