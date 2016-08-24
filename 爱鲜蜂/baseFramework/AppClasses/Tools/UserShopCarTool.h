//
//  UserShopCarTool.h
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Good;
@interface UserShopCarTool : NSObject
SingleH(UserShopCarTool)
+ (void)loadFreshHotData:(void(^)(NSArray<Good*>* HotData,NSError * error))completion;

//返回购物车商品数量--因为其他专题的商品不一定放在闪电超市里，所以以购物车实际数量为准
- (NSInteger)userShopCarProductsNumber;
//闪电超市里的商品购物车是否为空
- (BOOL)isEmpty;

//添加商品到闪电超市的购物车
- (void)addSupermarkProductToShopCar:(Good *)good;

//获取闪电超市购物车商品的数组
- (NSArray*)getShopCarProduct;
//获取购物车商品的数量
- (NSInteger)getShopCarProductClassifNumber;
//删除闪电超市购物车商品的数量
- (void)removeSupermarketProduct:(Good*)good;
- (NSString*)getAllProductPrice;

@end
