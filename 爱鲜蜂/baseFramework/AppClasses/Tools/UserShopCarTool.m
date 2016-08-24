//
//  UserShopCarTool.m
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UserShopCarTool.h"


@interface UserShopCarTool()
@property(nonatomic,strong)NSMutableArray *supermarketProducts;
@end
@implementation UserShopCarTool
SingleM(UserShopCarTool)

-(NSMutableArray *)supermarketProducts{
    if (_supermarketProducts == nil) {
        _supermarketProducts = [[NSMutableArray alloc]init];
    }
    return _supermarketProducts;
}

//返回购物车商品数量--因为其他专题的商品不一定放在闪电超市里，所以以购物车实际数量为准
- (NSInteger)userShopCarProductsNumber{
    return [ShopCarRedDotView shareShopCarRedDotView].buyNumber;
}
//闪电超市里的商品购物车是否为空
- (BOOL)isEmpty{
    return self.supermarketProducts.count == 0;
}

//添加商品到闪电超市的购物车
- (void)addSupermarkProductToShopCar:(Good *)good{
    for (Good *everygood in self.supermarketProducts) {
        if (everygood.id == good.id) {//添加了就不重复加进数组了，按钮组件内部会自动增减商品
            
            return;
        }
    }
    [self.supermarketProducts addObject:good];
}

//获取闪电超市购物车商品的数组
- (NSArray*)getShopCarProduct{
    return self.supermarketProducts;
}
//获取购物车商品的数量
- (NSInteger)getShopCarProductClassifNumber{
    return self.supermarketProducts.count;
}
//删除闪电超市购物车商品的数量
- (void)removeSupermarketProduct:(Good*)good{
    for (NSInteger i = 0; i < self.supermarketProducts.count; i++) {
        Good *everygood = self.supermarketProducts[i];
        if (everygood.id == good.id) {
            [self.supermarketProducts removeObjectAtIndex:i];
            //告诉主购物车，闪电购物车删除了哪个商品
            [AINotiCenter postNotificationName:LFBShopCarDidRemoveProductNSNotification object:good];
            return;
        }
    }
}

- (NSString*)getAllProductPrice{
    CGFloat allPrice = 0.0;
    for (Good *good in self.supermarketProducts) {
        allPrice = allPrice + [good.partner_price floatValue] * good.userBuyNumber;
    }
    return [[NSString stringWithFormat:@"%f",allPrice] cleanDecimalPointZear];
}




+ (void)loadFreshHotData:(void(^)(NSArray<Good*>* HotData,NSError * error))completion{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页新鲜热卖" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArr = dict[@"data"];
        NSArray<Good*> *result = [Good mj_objectArrayWithKeyValuesArray:dataArr];
        completion(result,nil);
    }
}









@end
