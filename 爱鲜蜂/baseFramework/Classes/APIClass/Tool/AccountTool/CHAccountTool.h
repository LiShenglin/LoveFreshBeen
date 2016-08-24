//
//  CHAccountTool.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CHAccountModel;
@interface CHAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(CHAccountModel *)account;
/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (CHAccountModel *)account;

/** 清空数据 */
+ (void)clearAccount;
/** 设置账号过期 */
+ (void)setoutdateAccount;
/** 获取历史登录记录的账号基本资料 */
+ (CHAccountModel *)getoutdateAccount;

/** 是否登陆 */
+ (BOOL)isLogined;
/** 信息是否完善 */
+ (BOOL)isFullInfo;
/** 获得当前版本 */
+ (NSString *)currentVersionString;
/** 保存当前版本号 */
+ (void)saveVersionString;

/** 判断版本是否一致 */
+ (BOOL)isEqualVersion;

/** 选择跳转控制器 */
+ (void)chooseRootViewController:(UIWindow *)window needLogin:(BOOL)islogin;

//还可以做全局未登录的样式页

@end
