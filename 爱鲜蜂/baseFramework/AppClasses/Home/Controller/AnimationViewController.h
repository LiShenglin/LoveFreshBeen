//
//  AnimationViewController.h
//  baseFramework
//
//  Created by chenangel on 16/6/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "BaseViewController.h"

@interface AnimationViewController : BaseViewController
//小图layers动画数组
@property(nonatomic,strong)NSMutableArray * animationLayers;
//大图layers动画数组
@property(nonatomic,strong)NSMutableArray * animationBigLayers;
//添加商品到购物车动画
- (void)addProductsAnimation:(UIImageView *)imageView ;
//添加大图商品到购物车动画
- (void)addProductsToBigShopCarAnimation:(UIImageView *)imageView;
//停止购物车动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end
