//
//  AppDelegate.m
//  baseFramework
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "AppDelegate.h"
#import "ADViewController.h"
#import "CHAccountTool.h"
#import "AD.h"
#import "GuideViewController.h"
#import "MainTabBarController.h"

@interface AppDelegate ()
@property(nonatomic,strong)ADViewController *ADViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:ScreenBounds];
    [self setAppSubject];
    [self bulidKeyWindow];
    [self addNotiEvents];
    return YES;
}
//设置主题
- (void)setAppSubject{
    UITabBar *tabBarAppearance = [UITabBar appearance];
    tabBarAppearance.backgroundColor = [UIColor whiteColor];
    tabBarAppearance.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.translucent = NO;
}
#pragma mark -- 设置根控制器
- (void)bulidKeyWindow {
    [self.window makeKeyAndVisible];
    BOOL isEqualVersion = [CHAccountTool isEqualVersion];
    if (!isEqualVersion) {
        GuideViewController * guideViewController = [[GuideViewController alloc]init];
        self.window.rootViewController = guideViewController;
        [CHAccountTool saveVersionString];
    }else{
        [self loadADViewController];
        //self.window.rootViewController = [[MainTabBarController alloc]init];
    }
    
}

- (void)loadADViewController{
    self.ADViewController = [[ADViewController alloc]init];
    CHLog(@"广告-----%@",self.ADViewController);
    __weak typeof(self)weakSelf = self;
    [ADTool loadADData:^(NSArray<AD*>* data, NSError *error) {
        AD *aditem = data[0];
        if (aditem.img_name) {
            weakSelf.ADViewController.imageName = aditem.img_name;
            weakSelf.window.rootViewController = self.ADViewController;
        }
    }];
}

#pragma mark -- 监听的方法事件
- (void)addNotiEvents{
    [AINotiCenter addObserver:self selector:@selector(ADImageLoadSecussedEvent:) name:ADImageLoadSecussed object:nil];
    [AINotiCenter addObserver:self selector:@selector(ADImageLoadFailEvent) name:ADImageLoadFail object:nil];
    [AINotiCenter addObserver:self selector:@selector(GuideViewControllerDidFinishEvent) name:GuideViewControllerDidFinish object:nil];
}
//AD广告加载成功后跳转事件
- (void)ADImageLoadSecussedEvent:(NSNotification *)noti{
    UIImage *image = noti.object;
    //把广告图片传给tabbar控制器，然后动画消失
    MainTabBarController * mainVC = [[MainTabBarController alloc]init];
    mainVC.adImage = image;
    //进入tabbar控制器
    self.window.rootViewController = mainVC;
}
//AD广告加载失败后跳转事件
- (void)ADImageLoadFailEvent{
    self.window.rootViewController = [[MainTabBarController alloc]init];
}
//引导页加载到最后一页跳转
- (void)GuideViewControllerDidFinishEvent{
    self.window.rootViewController = [[MainTabBarController alloc]init];
}





@end
