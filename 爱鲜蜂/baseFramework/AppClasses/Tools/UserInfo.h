//
//  UseInfo.h
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleInstance.h"
@class Address;
@interface UserInfo : NSObject
SingleH(UserInfo)
@property (nonatomic,strong) NSMutableArray<Address*>* allAddress;

- (BOOL)hasDefalutAdress;

- (void)cleanAllAddress;
//一开始获取当前的默认地址
- (Address *)defaultAddress;//设置填写默认地址
- (void)setDefaultAddress:(Address *)address;
@end
