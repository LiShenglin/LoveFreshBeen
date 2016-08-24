//
//  SelectedAddressViewController.m
//  baseFramework
//
//  Created by chenangel on 16/6/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "SelectedAddressViewController.h"
#import "UserInfo.h"
#import "UIBarButtonItem+DownUp.h"

@implementation SelectedAddressViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //搭建导航条
    [self buildNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserInfo * userinfo = [UserInfo shareUserInfo];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:[userinfo defaultAddress].address forState:UIControlStateNormal];
    
    
    
    UILabel * label = [[UILabel alloc]init];
    label.text = [userinfo defaultAddress].address;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [label sizeToFit];
    label.frame = CGRectMake(0, 0, label.width, 30);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleViewClick:)];
    self.navigationItem.titleView = label;
    [self.navigationItem.titleView addGestureRecognizer:tap];

}

- (void)buildNavigationItem{
    
    UIBarButtonItem * leftItem = [UIBarButtonItem barButton:@"扫一扫" titleColor:[UIColor blackColor] image:[UIImage imageNamed:@"icon_black_scancode"] hightLightImage:nil target:self action:@selector(leftItemClick) type:ItemButtonTypeLeft];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [UIBarButtonItem barButton:@"搜 索" titleColor:[UIColor blackColor] image:[UIImage imageNamed:@"icon_search"] hightLightImage:nil target:self action:@selector(rightItemClick) type:ItemButtonTypeRight];
   
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)leftItemClick{
    CHLog(@"跳转到扫一扫");
}

- (void)rightItemClick{
    CHLog(@"跳转到搜索");
}

- (void)titleViewClick:(UITapGestureRecognizer*)tap{
    CHLog(@"跳转到地址选择");
}



@end
