//
//  ShopCartGoodsListView.h
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
//商品列表
@interface ShopCartGoodsListView : UIView
@property(nonatomic,assign)CGFloat goodsHeight;
- (instancetype)initWithFrame:(CGRect)frame;

@end

//商品列表项模板
@interface PayGoodsDetailView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)Good *goods;


@end