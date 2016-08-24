//
//  SupermarketTool.h
//  baseFramework
//
//  Created by chenangel on 16/7/5.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Good;
@class Categorie;
@class Products;
@class SupermarketResouce;

@interface SupermarketTool : NSObject

+ (void)loadSupermarketData:(void(^)(SupermarketResouce *supermarket,NSError*error))completion;

+ (NSMutableArray*)searchCategoryMatchProducts:(SupermarketResouce*)supermarketResouce;

@end

//全部数据模型
@interface SupermarketResouce : NSObject
@property(nonatomic,strong)NSArray<Categorie*>*categories;
@property(nonatomic,strong)Products *products;
//点击的分类ID
@property(nonatomic,copy)NSString * trackid;
@end

//超市分类
@interface Categorie : NSObject
@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * sort;
@end

//所有商品模型数据
@interface Products : NSObject
@property(nonatomic,strong)NSArray<Good*>*a82;
@property(nonatomic,strong)NSArray<Good*>*a96;
@property(nonatomic,strong)NSArray<Good*>*a99;
@property(nonatomic,strong)NSArray<Good*>*a106;
@property(nonatomic,strong)NSArray<Good*>*a134;
@property(nonatomic,strong)NSArray<Good*>*a135;
@property(nonatomic,strong)NSArray<Good*>*a136;
@property(nonatomic,strong)NSArray<Good*>*a137;
@property(nonatomic,strong)NSArray<Good*>*a141;
@property(nonatomic,strong)NSArray<Good*>*a143;
@property(nonatomic,strong)NSArray<Good*>*a147;
@property(nonatomic,strong)NSArray<Good*>*a151;
@property(nonatomic,strong)NSArray<Good*>*a152;
@property(nonatomic,strong)NSArray<Good*>*a158;

@end


