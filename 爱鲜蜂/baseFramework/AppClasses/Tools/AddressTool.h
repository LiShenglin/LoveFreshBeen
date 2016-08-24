//
//  AddressTool.h
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Address;
@interface AddressTool : NSObject

//加载地址
+ (void)loadMyAddressData:(void(^)(NSArray<Address*>* AddressData,NSError * error))completion;
//修改地址

//设置默认地址传上服务器

@end
