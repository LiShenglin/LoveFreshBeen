//
//  UITabBarController+CHTabBar.m
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UITabBarController+CHTabBar.h"

@implementation UITabBarController (CHTabBar)
/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes:(NSInteger)num normalTextColor:(UIColor *)color selTextColor:(UIColor *)selColor
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:num];
    normalAttrs[NSForegroundColorAttributeName] = color;
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = selColor;
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
}

/**
 *  更换TabBar类型
 */
- (void)setupTabBar:(Class)tabBarName
{
    [self setValue:[[tabBarName alloc] init] forKeyPath:@"tabBar"];
}
@end
