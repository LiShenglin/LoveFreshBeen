//
//  MainTabBarController.m
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "MainTabBarController.h"
#import "CHTabBarView.h"

#import "HomeViewController.h"
#import "SupermarketViewController.h"
#import "ShopCartViewController.h"


@interface MainTabBarController()<CHTabBarViewDelegate>
//一开始的广告图片
@property(nonatomic,weak)UIImageView *adImageView;
@property(nonatomic,strong)NSMutableArray * tabbarItemArr;
@property(nonatomic,strong)NSMutableArray *iconsImageName;
@property(nonatomic,strong)NSMutableArray *iconsSelectedImageName;
@property(nonatomic,strong)ShopCartViewController *shopCartVC;
@end
@implementation MainTabBarController
//设置广告图
- (void)setAdImage:(UIImage *)adImage{
    UIImageView * adImageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
    adImageView.image = adImage;
    [self.view addSubview:adImageView];
    self.adImageView = adImageView;
    __weak typeof(self)weakSelf = self;
    [UIImageView animateWithDuration:2.0 animations:^{
        weakSelf.adImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        weakSelf.adImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.adImageView removeFromSuperview];
        weakSelf.adImageView = nil;
    }];
}
//tabbaritems的数组
- (NSMutableArray *)tabbarItemArr{
    if (_tabbarItemArr == nil) {
        _tabbarItemArr = [NSMutableArray array];
    }
    return _tabbarItemArr;
}
//默认图标
- (NSMutableArray *)iconsImageName{
    if (_iconsImageName == nil) {
        _iconsImageName = [NSMutableArray array];
        NSArray *iconsImage = @[@"v2_home", @"v2_order", @"shopCart", @"v2_my"];
        [_iconsImageName addObjectsFromArray:iconsImage];
    }
    return _iconsImageName;
}
//选中图标
- (NSMutableArray *)iconsSelectedImageName{
    if (_iconsSelectedImageName == nil) {
        _iconsSelectedImageName = [NSMutableArray array];
        NSArray *selectImage = @[@"v2_home_r", @"v2_order_r", @"shopCart_r", @"v2_my_r"];
        [_iconsSelectedImageName addObjectsFromArray:selectImage];
    }
    return _iconsSelectedImageName;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self buildMainTabBarChildViewController];
    
    [self setupTabBar];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView * childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[CHTabBarView class]]) {
            [childView removeFromSuperview];
        }
    }
    
}
- (void)setupTabBar{
    
    CHTabBarView *tabbar = [[CHTabBarView alloc]init];
    tabbar.TabBarItems = self.tabbarItemArr;
    tabbar.delegate = self;
    tabbar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    tabbar.frame = self.tabBar.bounds;

    [self.tabBar addSubview:tabbar];
}
#pragma mark -- 创建子控制器和按钮
- (void)buildMainTabBarChildViewController{
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    homeVc.isAnimation = YES;
    [self tabBarControllerAddChildViewController:homeVc title:@"首页" imageName:@"v2_home" selectedImageName:@"v2_home_r" tag:0];
    
    SupermarketViewController *supermarket = [[SupermarketViewController alloc]init];
    [self tabBarControllerAddChildViewController:supermarket title:@"闪电超市" imageName:@"v2_order" selectedImageName:@"v2_order_r" tag:1];
    
    ShopCartViewController *shopCartVC = [[ShopCartViewController alloc]init];
    self.shopCartVC = shopCartVC;
    [self tabBarControllerAddChildViewController:shopCartVC title:@"购物车" imageName:@"shopCart" selectedImageName:@"shopCart" tag:2];
    
    
    [self tabBarControllerAddChildViewController:[[UIViewController alloc]init] title:@"我的" imageName:@"v2_my" selectedImageName:@"v2_my_r" tag:3];
    
    
}
//配置子按钮
- (void)tabBarControllerAddChildViewController:(UIViewController*)childView title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName tag:(NSInteger)tag{
    UITabBarItem * vcitem = [[UITabBarItem alloc]init];
    vcitem.tag = tag;
    vcitem.title = title;
    childView.tabBarItem = vcitem;
    [self.tabbarItemArr addObject:vcitem];
    childView.view.backgroundColor = LFBGlobalBackgroundColor;
    
    BaseNavigationController * baseNav = [[BaseNavigationController alloc] initWithRootViewController:childView];
    [self addChildViewController:baseNav];
}

//代理--管理对应子控制器是否可以切换
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSArray * childArr = self.childViewControllers;
    NSInteger index = [childArr indexOfObject:viewController];
    if (index == 2) {
        return NO;
    }
    return YES;
}
#pragma mark -- 按钮跳转监听
- (void)tabBar:(CHTabBarView *)tabBar didClickBtn:(NSInteger)index{
    if (index == 2) {
        
        BaseNavigationController * baseNav = [[BaseNavigationController alloc] initWithRootViewController:self.shopCartVC];

        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    self.selectedIndex = index;
    
    
}


@end
