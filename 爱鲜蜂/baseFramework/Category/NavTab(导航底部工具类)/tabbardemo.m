//
//  ViewController.m
//  CHTabbarDemo
//
//  Created by chenangel on 16/5/31.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "tabbardemo.h"

@interface tabbardemo ()

@end

@implementation tabbardemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];
    NSArray *imageArray = @[@"home", @"category", @"center", @"cart", @"mine"];
    NSArray *titleArray = @[@"首页", @"分类", @"", @"购物车", @"我"];
    for (int i = 0; i < imageArray.count; i++) {
        UIViewController *vc = [[UIViewController alloc]init];
        [vc.view setBackgroundColor:[UIColor whiteColor]];
        vc.tabBarItem.image = [[UIImage imageNamed:imageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[imageArray[i] stringByAppendingString:@"_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.title = titleArray[i];
        if (i == 3) {
            vc.tabBarItem.badgeValue = @"99";
        }
        [self addChildViewController:vc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
