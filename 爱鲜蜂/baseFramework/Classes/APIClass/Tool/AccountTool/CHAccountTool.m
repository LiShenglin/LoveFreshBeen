//
//  CHAccountTool.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHAccountTool.h"
#import "CHAccountModel.h"
#import "LoginViewController.h"
@implementation CHAccountTool
// 账号的存储路径
#define CHAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
+ (void)saveAccount:(CHAccountModel *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:CHAccountPath];
}
+ (CHAccountModel *)account{
    // 加载模型
    CHAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CHAccountPath];
    
    /* 验证账号是否过期 */
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.last_date dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    return account;
}
/** 清空数据 */
+ (void)clearAccount{
    [CHFileManager removeItemAtPath:CHAccountPath error:nil];
}

/** 账号设置过期 */
+ (void)setoutdateAccount{
    CHAccountModel *account = [self account];
    account.expires_in = 0;
    [self saveAccount:account];
}
/** 获取历史登录记录的账号基本资料 */
+ (CHAccountModel *)getoutdateAccount{
    CHAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CHAccountPath];
    return account;
}

/** 是否登陆 */
+ (BOOL)isLogined{
    BOOL result = NO;
    CHAccountModel *account = [self account];
    if ([account.userid integerValue]!=0 && account.userid) {
        result = YES;
    }
    return result;
}

/** 用户信息是否完善 */
+ (BOOL)isFullInfo{
    BOOL result = NO;
    //添加需要完善信息的条件判断
    if ([self account]) {
        result = YES;
    }
    return result;
}

/** 获得系统最新当前版本 */
+ (NSString *)currentVersionString{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
/** 私有方法--获得用户以前登陆的版本 */
+ (NSString *)lastVersionString{
    return [[NSUserDefaults standardUserDefaults] objectForKey:CHVersionKey];
}
/** 保存当前版本 */
+ (void)saveVersionString{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CHVersionKey];
}
/** 版本是否一致 */
+ (BOOL)isEqualVersion{
    return [[self currentVersionString] isEqualToString:[self lastVersionString]];
}
/** 程序启动跳转控制器逻辑 */
+ (void)chooseRootViewController:(UIWindow *)window needLogin:(BOOL)islogin{
    if (islogin){//需要登陆直接跳转，先进入新特性，直接跳进登陆注册界面
        // 判断当前是否有新的版本
        if ([self isEqualVersion]) { // 没有最新的版本号
            if(![self isLogined]){//未登录直接进入登陆界面
                LoginViewController *lgVc = [[LoginViewController alloc]init];
                window.rootViewController = lgVc;
                
            }else{//已登录则进入首页
                // 创建tabBarVc
                UITabBarController *tabBarVc = [[UITabBarController alloc] init];
                // 设置窗口的根控制器
                window.rootViewController = tabBarVc;
            }
        }else{ // 有最新的版本号
            // 进入新特性界面
            UIViewController *vc = [[UIViewController alloc] init];
            window.rootViewController = vc;
            // 保持当前的版本，用偏好设置
            [self saveVersionString];
        }
        
    }else{//不需要登陆直接跳转，先进入新特性，直接跳进首页
        // 判断当前是否有新的版本
        if ([self isEqualVersion]) { // 没有最新的版本号
            // 创建tabBarVc
            UITabBarController *tabBarVc = [[UITabBarController alloc] init];
            // 设置窗口的根控制器
            window.rootViewController = tabBarVc;
            
        }else{ // 有最新的版本号
            // 进入新特性界面
            UIViewController *vc = [[UIViewController alloc] init];
            window.rootViewController = vc;
            // 保持当前的版本，用偏好设置
            [self saveVersionString];
        }
    }

}

@end
