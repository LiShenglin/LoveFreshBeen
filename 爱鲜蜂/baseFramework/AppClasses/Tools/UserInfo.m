//
//  UseInfo.m
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UserInfo.h"
@interface UserInfo()

@end
@implementation UserInfo
SingleM(UserInfo)

- (NSMutableArray<Address *> *)allAddress{
    if (_allAddress == nil) {
        _allAddress = [NSMutableArray array];
    }
    return _allAddress;
}
//判断用户是否有默认地址信息
- (BOOL)hasDefalutAdress{
    if (self.allAddress.count <= 0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)cleanAllAddress{
    self.allAddress = nil;
}
//一开始获取当前的默认地址
- (Address *)defaultAddress{
    if (self.allAddress.count <= 0){
        __weak typeof(self)weakSelf = self;
        [AddressTool loadMyAddressData:^(NSArray<Address*>* AddressData, NSError *error) {
            if (AddressData.count > 0) {
                NSArray<Address*>* allAddress = AddressData;
                [weakSelf.allAddress addObjectsFromArray:allAddress];
            }else {//如果服务器没有数据，则删除本地用户的数据
                [weakSelf.allAddress removeAllObjects];
            }
            
        }];
        return self.allAddress.count > 1 ? self.allAddress[0] : nil;
    }else {
        return self.allAddress[0];
    }
}
//设置填写默认地址
- (void)setDefaultAddress:(Address *)address{
        [self.allAddress insertObject:address atIndex:0];
}





@end
