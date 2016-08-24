//
//  MainViewController.m
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "MainViewController.h"
#import "RAMAnimatedTabBarItem.h"
#import "RAMItemAnimation.h"
@interface MainViewController()
@property(nonatomic,assign)BOOL fristLoadMainTabBarController;
@property(nonatomic,weak)UIImageView *adImageView;
@property(nonatomic,strong)NSMutableArray * tabBarItems;
@end
@implementation MainViewController
- (NSMutableArray *)tabBarItems{
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

-(void)setAdImage:(UIImage *)adImage{
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

- (void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
    [self buildMainTabBarChildViewController];
    self.items = self.tabBarItems;
    
    NSMutableArray *dict = [self createViewcontainers];
    [self createCustomIcons:dict];
        
    CHLog(@"222---count总数----%ld",self.items.count);
    CHLog(@"图标模型---%@",self.iconViews);

    
}
//运行时测试的方法
- (void)runtimeTest{
    //[self runtimeObj:[UITabBarItem class]];
   // NSDictionary *arr = [UITabBar objcPropertiesOfClass:[self.tabBar class] stepController:nil];

    //CHLog(@"arr---%@",arr);
}

#pragma mark -- 创建子控制器和按钮
- (void)buildMainTabBarChildViewController{
    [self tabBarControllerAddChildViewController:[[UIViewController alloc]init] title:@"首页" imageName:@"v2_home" selectedImageName:@"v2_home_r" tag:0];
    [self tabBarControllerAddChildViewController:[[UIViewController alloc]init] title:@"闪电超市" imageName:@"v2_order" selectedImageName:@"v2_order_r" tag:1];
    [self tabBarControllerAddChildViewController:[[UIViewController alloc]init] title:@"购物车" imageName:@"shopCart" selectedImageName:@"shopCart" tag:2];
    [self tabBarControllerAddChildViewController:[[UIViewController alloc]init] title:@"我的" imageName:@"v2_my" selectedImageName:@"v2_my_r" tag:3];
    
    
}

//配置子按钮
- (void)tabBarControllerAddChildViewController:(UIViewController*)childView title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName tag:(NSInteger)tag{
    
    RAMAnimatedTabBarItem *vcitem = [[RAMAnimatedTabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    //UITabBarItem *vcitem = [RAMAnimatedTabBarItem tabBarItemWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    vcitem.tag = tag;
    vcitem.animation = [[RAMItemAnimation alloc]init];
    childView.tabBarItem = vcitem;
    [self.tabBarItems addObject:vcitem];
    childView.view.backgroundColor = [UIColor orangeColor];
    CHLog(@"----%@",childView.tabBarItem);
    BaseNavigationController * baseNav = [[BaseNavigationController alloc] initWithRootViewController:childView];
    [self addChildViewController:baseNav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSArray * childArr = self.childViewControllers;
    NSInteger index = [childArr indexOfObject:viewController];
    if (index == 2) {
        return NO;
    }
    return YES;
}






@end
