//
//  Good.h
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject
//*************************商品模型默认属性**********************************
/// 商品ID
@property(nonatomic,copy) NSString * id;
/// 商品姓名
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * brand_id;
/// 超市价格
@property(nonatomic,copy) NSString * market_price;
@property(nonatomic,copy) NSString * cid;
@property(nonatomic,copy) NSString * category_id;
/// 当前价格
@property(nonatomic,copy) NSString * partner_price;
@property(nonatomic,copy) NSString * brand_name;
@property(nonatomic,copy) NSString * pre_img;

@property(nonatomic,copy) NSString * pre_imgs;
/// 参数
@property(nonatomic,copy) NSString * specifics;
@property(nonatomic,copy) NSString * product_id;
@property(nonatomic,copy) NSString * dealer_id;
/// 当前价格
@property(nonatomic,copy) NSString * price;
/// 库存
@property(nonatomic,assign) NSInteger number;
/// 买一赠一
@property(nonatomic,copy) NSString * pm_desc;
@property(nonatomic,assign) NSInteger had_pm;
/// urlStr
@property(nonatomic,copy) NSString * img;
/// 是不是精选 0 : 不是, 1 : 是
@property(nonatomic,assign) NSInteger is_xf;

//*************************商品模型辅助属性**********************************
// 记录用户对商品添加次数
@property(nonatomic,assign) NSInteger userBuyNumber;

@end
