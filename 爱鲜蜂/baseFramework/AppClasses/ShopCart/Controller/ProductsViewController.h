//
//  ProductsViewController.h
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "AnimationViewController.h"
/**
 *  产品列表控制器：展示产品-产品点击购买
 */
@class LFBTableView;
@protocol ProductsViewControllerDelegate <NSObject>
- (void)didEndDisplayingHeaderView:(NSInteger)section;
- (void)willDisplayHeaderView:(NSInteger)section;
@end

typedef void(^RefreshUpPull)();
@interface ProductsViewController : AnimationViewController
@property(nonatomic,strong)SupermarketResouce *supermarketResouce;
@property(nonatomic,strong)NSArray<NSArray*>* goodsArr;

@property(nonatomic,strong)LFBTableView *prodcutsTableView;

@property(nonatomic,strong)RefreshUpPull refreshUpPull;
@property(nonatomic,weak)id<ProductsViewControllerDelegate>delegate;
//选中的组
@property(nonatomic,strong)NSIndexPath *categortsSelectedIndexPath;
@end
