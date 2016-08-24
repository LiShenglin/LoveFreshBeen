//
//  ShopCarRedDotView.h
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarRedDotView : UIView
SingleH(ShopCarRedDotView)
@property(nonatomic,assign)NSInteger buyNumber;

//增加商品的视图
- (void)addProductToRedDotView:(BOOL)animaton;
//减持商品的视图
- (void)reduceProductToRedDotView:(BOOL)animation;

@end
