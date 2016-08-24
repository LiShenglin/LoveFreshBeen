//
//  AnimationTabBarController.h
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconItem.h"
@interface AnimationTabBarController : UITabBarController
//自定义按钮
@property(nonatomic,strong) NSMutableArray<IconItem*>* iconViews;
@property(nonatomic,strong) NSMutableArray * iconsImageName;
@property(nonatomic,strong) NSMutableArray * iconsSelectedImageName;

//购物车徽章
@property(nonatomic,weak)UIImageView * shopCarIcon;
//tabbar按钮数据
@property(nonatomic,strong)NSMutableArray * items;
//创建tabbar数组
- (NSMutableArray *)createViewcontainers;
//创建tababr按钮具体细节，并返回数组
- (void)createCustomIcons:(NSMutableArray *)containersDict;
@end
