//
//  ShopCartSupermarketTableFooterView.h
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopCartSupermarketTableFooterViewDelegate <NSObject>
- (void)supermarketTableFooterDetermineButtonClick;
@end

@interface ShopCartSupermarketTableFooterView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setpriceLabel:(CGFloat)price;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,weak)id<ShopCartSupermarketTableFooterViewDelegate>delegate;

@end
