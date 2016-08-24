//
//  ApiManager.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Api模型调用管理器，用于声明新增的各类API接口
 */
@interface CHDataManager : NSObject
//配置用户全局请求的token-服务端每个用户对应一个token做信息秘钥
/** userToken */
@property (nonatomic ,strong) NSString *userToken;
- (NSString *)getUserToken;
@property (nonatomic ,strong) NSString *baseUrl;

#pragma mark -- 登陆注册接口,是否开启令牌访问、登录信息、请求成功是否跳转
- (void)loginWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isLogin))finished error:(void(^)(NSError *error))errored;
- (void)registerWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isRegister))finished error:(void(^)(NSError *error))errored;
- (void)logoutWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isLogout))finished error:(void(^)(NSError *error))errored;
//修改密码则重新登录
- (void)changePasswordWith:(NSMutableDictionary *)dict isToken:(BOOL)isToken finished:(void(^)(BOOL isLogout))finished error:(void(^)(NSError *error))errored;

#pragma mark -- 帖子请求接口


@end
