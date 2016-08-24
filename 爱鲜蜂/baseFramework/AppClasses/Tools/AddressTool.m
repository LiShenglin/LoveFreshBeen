//
//  AddressTool.m
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "AddressTool.h"
@implementation AddressTool

+ (void)loadMyAddressData:(void(^)(NSArray<Address*>* AddressData,NSError * error))completion{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyAdress" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        CHWriteToPlist(dict, @"dict地址");
        NSArray *dataArr = dict[@"data"];
        NSArray<Address*> *result = [Address mj_objectArrayWithKeyValuesArray:dataArr];
        completion(result,nil);
    }
    
}

@end
