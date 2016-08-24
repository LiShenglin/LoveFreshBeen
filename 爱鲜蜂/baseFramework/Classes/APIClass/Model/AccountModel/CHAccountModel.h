//
//  CHAccountModel.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  账号基础类模型数据--所有的整形数据要归档都得改成nsstring调用的时候再强转整型
 */
@class OAuthAccountModel;
typedef enum : NSUInteger {
    CHAccountZsType = 1,//钻石用户
    CHAccountHjType = 2,//黄金用户
    CHAccountByType = 3,//白银用户
} CHAccountType;
@interface CHAccountModel : NSObject <NSCoding>
/** 用户userid */
@property (nonatomic ,copy) NSNumber *userid;
//模型转字符记得替换成对应的userid
/** name用户昵称 */
@property (nonatomic ,copy) NSString *name;
/** 用户头像 */
@property (nonatomic, copy) NSString *avatar;
/** 手机号码 */
@property (nonatomic ,copy) NSString *phonenumber;
/** 密码 */
@property (nonatomic ,strong) NSString *password;

/** userToken信息交流的秘钥，每次重新登录的时候更换一次 */
@property (nonatomic ,strong) NSString *userToken;
/**	token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;
/**	账号登陆的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;


/** 用户等级或者身份-CHAccountType转档后内部再私下转类型*/
@property (nonatomic ,copy) NSNumber *type;
/** 用户等级显示 */
@property (nonatomic , assign) CHAccountType accountType;
/** 关联账号的模型 */
@property (nonatomic ,strong) OAuthAccountModel *OAuthAccount;

/** 上一次登陆时间 */
@property (nonatomic ,strong) NSDate* last_date;
/** 账号锁定状态，每次登陆密码连续错误超过5次即会封锁,隔天本地自动解锁 */
@property (nonatomic ,strong) NSString* yokecount;
/** 所在城市 */
@property (nonatomic ,strong) NSString *cityname;
/** 城市ID */
@property (nonatomic ,strong) NSNumber *cityid;


/** 维度 */
@property (nonatomic ,assign) CGFloat latitude;
/** 经度 */
@property (nonatomic ,assign) CGFloat longitude;
/** 精度 */
@property (nonatomic ,assign) CGFloat precision;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
