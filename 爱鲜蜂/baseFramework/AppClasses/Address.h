//
//  Address.h
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject
/**收货人名称*/
@property (nonatomic ,copy) NSString *accept_name;
@property (nonatomic ,copy) NSString *telphone;
@property (nonatomic ,copy) NSString *province_name;
@property (nonatomic ,copy) NSString *city_name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *lng;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *gender;


@end
