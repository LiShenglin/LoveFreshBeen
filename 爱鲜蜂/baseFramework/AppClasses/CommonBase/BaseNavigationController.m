//
//  BaseNavigationController.m
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    
    NSArray *targets = [self.interactivePopGestureRecognizer valueForKeyPath:@"_targets"];
    id objc = [targets firstObject];
    id target = [objc valueForKeyPath:@"_target"];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:LFBNavigationYellowColor] forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //两种选其一
//    return (self.topViewController != [self.viewControllers firstObject]);
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
