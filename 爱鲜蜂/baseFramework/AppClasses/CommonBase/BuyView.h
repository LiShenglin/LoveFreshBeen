//
//  BuyView.h
//  baseFramework
//
//  Created by chenangel on 16/7/2.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickAddShopCar)();
@interface BuyView : UIView
@property(nonatomic,strong)ClickAddShopCar clickAddShopCar;
@property(nonatomic,assign)BOOL zearIsShow;
//设置商品
@property(nonatomic,strong)Good *good;
- (void)addGoodButtonClick;
- (void)reduceGoodButtonClick;
@end
