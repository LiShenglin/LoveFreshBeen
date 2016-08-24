//
//  UITabBarController+CHTabBar.h
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (CHTabBar)
//配置子控制器tabbar按钮的方法
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;
//全局配置tabbar按钮的色调
- (void)setupItemTitleTextAttributes:(NSInteger)num normalTextColor:(UIColor *)color selTextColor:(UIColor *)selColor;
//更换某个tabbar类型
- (void)setupTabBar:(Class)tabBarName;

@end
