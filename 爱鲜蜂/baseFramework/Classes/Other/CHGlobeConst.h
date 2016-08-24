//
//  CHGlobeConst.h
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

//全局配置面向客户类型
typedef NS_ENUM(NSUInteger, CHApplicationType) {
    CHApplicationTypeTeacher,
    CHApplicationTypeStudent,
};

@interface CHGlobeConst : NSObject
//初始化配置面向类型
+(void)initializeType;

extern NSUInteger applicationType;

#pragma mark - 需要根据类型切换的key
extern NSString* CHAPPName;
extern NSString* CHAPPURLScheme;
extern NSString* CHMapApiKey;
extern NSString* CHUmengKey;
extern NSString* CHWeixinKey;
extern NSString* CHWeixinAppSecret;

#pragma mark - 全局token配置
UIKIT_EXTERN NSString* const CHUserToken;
UIKIT_EXTERN NSString* const CHApplyToken;


#pragma mark - 通知
UIKIT_EXTERN NSString * const CHNotification_icon;

UIKIT_EXTERN NSString * const CHNotification_login;

UIKIT_EXTERN NSString * const CHNotification_push;

@end
