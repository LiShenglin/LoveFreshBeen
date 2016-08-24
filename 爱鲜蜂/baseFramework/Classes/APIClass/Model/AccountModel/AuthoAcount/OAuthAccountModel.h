//
//  OAuthAccountModel.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHAccountModel.h"
/**
 *  该子模型暂时兼容微博
 */
@interface OAuthAccountModel : NSObject<NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用u户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

/** OAuth关联用户原本的昵称 */
@property (nonatomic, copy) NSString *OAuth_name;

+ (instancetype)OAuthAccountWithDict:(NSDictionary *)dict;

@end
