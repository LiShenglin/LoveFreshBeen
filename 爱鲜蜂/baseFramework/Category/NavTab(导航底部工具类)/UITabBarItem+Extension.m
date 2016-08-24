//
//  UITabBarItem+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UITabBarItem+Extension.h"
#import "UIView+Extension.h"

@implementation UITabBarItem (Extension)

+ (instancetype)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)sImage{
    
    UIImage *bbImage = [sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:bbImage];
    
    return item;
}


@end
