//
//  UINavigationController+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)<UIGestureRecognizerDelegate>

/** 设置当前导航条滑动手势代理 和 背景图 */
- (void)setInteractivePopGestureRecognizerTarget:(UINavigationController*)nav navbgImage:(NSString *)bgimg;
/** 开启全屏滑动 和 背景图 */
- (void)setPanInteractivePopGestureRecognizerTarget:(UINavigationController*)nav navbgImage:(NSString *)bgimg;

/** push状态重写,输入转场控制器、返回按钮的配置、按钮文字和图片偏离位置一般负数、返回按钮监听*/
-(void)setupPushConfig:(UIViewController *)viewController target:(UINavigationController *)nav btnImage:(NSString *)btnImg btnHighImg:(NSString*)btnhighImg btnTitle:(NSString *)title offright:(CGFloat)offright;
@end
