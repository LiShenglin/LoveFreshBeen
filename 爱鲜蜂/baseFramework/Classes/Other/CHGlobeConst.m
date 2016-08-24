//
//  CHGlobeConst.m
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHGlobeConst.h"

@implementation CHGlobeConst
#pragma mark - 需要根据类型切换的key
NSString* CHAPPName;
NSString* CHAPPURLScheme;
NSString* CHMapApiKey;
NSString* CHUmengKey;
NSString* CHWeixinKey;
NSString* CHWeixinAppSecret;

#pragma mark -- 客户端类型
NSUInteger applicationType;
NSUInteger applicationType = CHApplicationTypeStudent;

+ (void)initializeType{
    if (applicationType == CHApplicationTypeStudent) {
        CHAPPName = @"pingxingguostudent";
        CHAPPURLScheme = @"pingxingguostudent://";
        CHMapApiKey = @"61562ec12afdd44d918ec60516a1f7df";
        CHUmengKey = @"56580ed9e0f55a40cf000bb5";
        CHWeixinKey = @"wx0133131b95d64a38";
        CHWeixinAppSecret = @"2518473745925a6c219f749e01a8c142";
    }else{
        CHAPPName = @"pingospace";
        CHAPPURLScheme = @"pingospace://";
        CHMapApiKey = @"fb3e8937e1c91cedacd7d2f3608f500c";
        CHUmengKey = @"56580eb667e58e85ea002718";
        CHWeixinKey = @"wx9afad13faa419581";
        CHWeixinAppSecret = @"e3c1bc949b0378e6e58c05c523a1861d";
    }
}

#pragma mark - token系列接口设置
//普通消息token
NSString * const CHUserToken = @"CHUserToken";
NSString * const CHApplyToken = @"CHApplyToken";

#pragma mark - 通知
NSString * const CHNotification_icon = @"CHNotification_icon";
NSString * const CHNotification_login = @"CHNotification_login";
NSString * const CHNotification_push = @"CHNotification_push";
@end
