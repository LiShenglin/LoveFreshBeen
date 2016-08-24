//
//  ViewController.m
//  baseFramework
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ViewController.h"
#import "CHNetWorking.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ADTool loadADData:^(NSArray<AD *> *data, NSError *error) {
        CHLog(@"------data--%@",data);
    }];
}
- (void)test{
    [AddressTool loadMyAddressData:^(NSArray *AddressData, NSError *error) {
        CHLog(@"-----data--%@",AddressData);
    }];
    [UserShopCarTool loadFreshHotData:^(NSArray<Good *> *HotData, NSError *error) {
        CHLog(@"---hotdata---%@",HotData);
    }];

}
//运行时测试的方法
- (void)runtimeTest{
        //[self runtimeObj:[UITabBarItem class]];
        NSDictionary *arr = [UITabBar objcPropertiesOfClass:[UIButton class] stepController:nil];
        CHLog(@"arr---%@",arr);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
