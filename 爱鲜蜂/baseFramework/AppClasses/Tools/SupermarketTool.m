//
//  SupermarketTool.m
//  baseFramework
//
//  Created by chenangel on 16/7/5.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "SupermarketTool.h"

@implementation SupermarketTool
+ (void)loadSupermarketData:(void(^)(SupermarketResouce *supermarket,NSError*error))completion{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *superData = dict[@"data"];
        id mapping = SFConcatPropertyMappings(
        SFBeginPropertyMappingWithClass(SupermarketResouce)
        SFMappingPropertyToClass(categories, Categorie)
        SFMappingPropertyToClass(products, Products)
        SFEndPropertyMapping,
                                              
        SFBeginPropertyMappingWithClass(Categorie)
        SFMappingPropertyToKey(ID, @"id")
        SFEndPropertyMapping,
                                              
        SFBeginPropertyMappingWithClass(Products)
        SFMappingPropertyToClass(a106, Good)
        SFMappingPropertyToClass(a134, Good)
        SFMappingPropertyToClass(a135, Good)
        SFMappingPropertyToClass(a106, Good)
        SFMappingPropertyToClass(a136, Good)
        SFMappingPropertyToClass(a137, Good)
        SFMappingPropertyToClass(a141, Good)
        SFMappingPropertyToClass(a143, Good)
        SFMappingPropertyToClass(a147, Good)
        SFMappingPropertyToClass(a151, Good)
        SFMappingPropertyToClass(a152, Good)
        SFMappingPropertyToClass(a158, Good)
        SFMappingPropertyToClass(a82, Good)
        SFMappingPropertyToClass(a96, Good)
        SFMappingPropertyToClass(a99, Good)
        SFEndPropertyMapping
        ,nil);
        
        SupermarketResouce * superModel = [SupermarketResouce sf_objectFromDictionary:superData mapping:mapping];
        
        completion(superModel,nil);
        
        CHLog(@"superModel--%@",superModel.categories[0]);
    }
    
}

+ (NSMutableArray*)searchCategoryMatchProducts:(SupermarketResouce*)supermarketResouce {
    NSMutableArray *tempArrM = [NSMutableArray array];
    Products *products = supermarketResouce.products;
    for (Categorie *cate in supermarketResouce.categories) {
        NSArray<Good*>*tempGood = [products valueForKey:cate.ID];
        [tempArrM addObject:tempGood];
//        [tempArrM addObjectsFromArray:tempGood];
    }
    //返回的是商品的二维数组
    return tempArrM;
}

@end

//全部数据模型
@implementation SupermarketResouce

@end

//超市分类
@implementation Categorie

@end

//所有商品模型数据
@implementation Products

@end