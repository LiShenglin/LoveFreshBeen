//
//  UINavigationController+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (void)setInteractivePopGestureRecognizerTarget:(UINavigationController*)nav navbgImage:(NSString *)bgimg{

    self.interactivePopGestureRecognizer.delegate = nav;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:bgimg] forBarMetrics:UIBarMetricsDefault];
    
}
/** 设置全屏滑动 */
- (void)setPanInteractivePopGestureRecognizerTarget:(UINavigationController*)nav navbgImage:(NSString *)bgimg{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:nav.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [nav.view addGestureRecognizer:pan];
    // 控制器手势什么时候触发
    pan.delegate = self;
    // Bug:假死状态:程序一直在跑,但是界面死了
    
    // 在根控制器下,滑动返回, 不应该在跟控制器的view上滑动返回
    
    // 清空手势代理,恢复滑动返回功能
    self.interactivePopGestureRecognizer.enabled =NO;
}
#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}

/**输入转场控制器、返回按钮的配置、按钮文字和图片偏离位置一般负数、返回按钮监听*/
-(void)setupPushConfig:(UIViewController *)viewController target:(UINavigationController *)nav btnImage:(NSString *)btnImg btnHighImg:(NSString*)btnhighImg btnTitle:(NSString *)title offright:(CGFloat)offright{
    if (self.childViewControllers.count > 0) { // 如果viewController不是最早push进来的子控制器
        // 左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:btnhighImg] forState:UIControlStateHighlighted];
        [backButton setTitle:title forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        //back方法是在总nav里面重写一次返回即可
        [backButton addTarget:nav action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 这句代码放在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, offright, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
}


@end
