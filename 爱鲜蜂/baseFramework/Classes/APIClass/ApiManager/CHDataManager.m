//
//  ApiManager.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHDataManager.h"
#import "CHAccountModel.h"
#import "CHAccountTool.h"

@implementation CHDataManager
/** 是否开启请求缓存 */
static BOOL refreshCached = YES;
#pragma mark -- 用户消息接口token秘钥配置
-(void)setUserToken:(NSString *)userToken{
    _userToken = userToken;
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:CHUserToken];
}
-(NSString *)getUserToken{
    if (self.userToken) {
        return self.userToken;
    }else{
        return [[NSUserDefaults standardUserDefaults] stringForKey:CHUserToken];
    }
}

#pragma mark -- 设置基本地址
-(void)setBaseUrl:(NSString *)baseUrl{
    [CHNetWorking updateBaseUrl:baseUrl];
}

#pragma mark -- 登陆注册接口
/**
 *  登录:每次登录更换令牌
 *  注册:每次注册更换令牌
 *  注销:每次注销用原先的令牌，然后注销成功则注销令牌
 *  修改密码:每次用原先的令牌访问，修改成功后则注销令牌此时需要重新登录
 *  @return <#return value description#>
 */
//登录
- (void)loginWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isLogin))finished error:(void(^)(NSError *error))errored{//登录默认不能用token令牌，此时令牌需要刷新
    self.userToken = nil;
    [CHNetWorking postWithUrl:@"api/auth/login" refreshCache:refreshCached params:dict success:^(id response) {
        if (response[@"success"]) {        //服务端返回成功则登录成功
            [SVProgressHUD showSuccessWithStatus:@"登录成功,正在跳转"];
            CHAccountModel *account = response[@"account"];
            [CHAccountTool saveAccount:account];
            self.userToken = account.userToken;
            finished(YES);
        }else{
            [SVProgressHUD showErrorWithStatus:@"用户或者账号密码错误"];
            finished(NO);
        }
        
    } fail:^(NSError *error) {
        errored(error);
    }];
}
//注册
- (void)registerWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isRegister))finished error:(void(^)(NSError *error))errored{
    self.userToken = nil;
    [CHNetWorking postWithUrl:@"api/account/register" refreshCache:refreshCached params:dict success:^(id response) {
        if (response[@"success"]) {//注册成功
            finished(YES);
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            CHAccountModel *account = response[@"account"];
            self.userToken = account.userToken;
            [CHAccountTool saveAccount:account];
            
        }else{
            finished(NO);
            [SVProgressHUD showErrorWithStatus:@"账号已经被注册了"];
        }
    } fail:^(NSError *error) {
        errored(error);
    }];
}
//退出成功
- (void)logoutWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isLogout))finished error:(void(^)(NSError *error))errored{
    if (isToken) {//开启令牌访问
        dict[@"token"] = self.userToken;
        [CHNetWorking postWithUrl:@"api/account/logoutWith" refreshCache:refreshCached params:dict success:^(id response) {
            if (response[@"success"]) {//注销成功
                finished(YES);
                self.userToken = nil;
                [CHAccountTool setoutdateAccount];
                //----->跳转
            }else{
                finished(NO);
                [SVProgressHUD showErrorWithStatus:@"网络开小差,请稍后退出"];
            }
        } fail:^(NSError *error) {
            errored(error);
        }];
    }else{//直接访问令牌
        [CHNetWorking postWithUrl:@"api/account/logoutWith" refreshCache:refreshCached params:dict success:^(id response) {
            if (response[@"success"]) {//退出成功
                finished(YES);
                self.userToken = nil;
                [CHAccountTool setoutdateAccount];
                
            }else{
                finished(NO);
                [SVProgressHUD showErrorWithStatus:@"网络开小差,请稍后退出"];
            }
        } fail:^(NSError *error) {
            errored(error);
        }];
    }
}
//修改密码则重新登录
- (void)changePasswordWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isLogout))finished error:(void(^)(NSError *error))errored{
    if (isToken) {//开启令牌访问
        dict[@"token"] = self.userToken;
        [CHNetWorking postWithUrl:@"api/account/changePassword" refreshCache:refreshCached params:dict success:^(id response) {
            if (response[@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"密码修改成功,请重新登录..."];
                finished(YES);
                self.userToken = nil;
                //直接设置账号过期,退出重新登录
                [CHAccountTool setoutdateAccount];
                
            }
        } fail:^(NSError *error) {
            errored(error);
        }];
    }else{//直接访问令牌
        [CHNetWorking postWithUrl:@"api/account/changePassword" refreshCache:refreshCached params:dict success:^(id response) {
            if (response[@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"密码修改成功,请重新登录..."];
                finished(YES);
                self.userToken = nil;
                //直接设置账号过期,退出重新登录
                [CHAccountTool setoutdateAccount];
                
            }
        } fail:^(NSError *error) {
            errored(error);
        }];
    }
}
#pragma mark -- 帖子请求接口

@end
