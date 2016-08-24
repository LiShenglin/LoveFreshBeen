//
//  DiscountPriceView.h
//  baseFramework
//
//  Created by chenangel on 16/7/2.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountPriceView : UIView
@property(nonatomic,strong)UIColor*priceColor;
@property(nonatomic,strong)UIColor*marketPriceColor;
- (instancetype)initWithPrice:(NSString*)price marketPrice:(NSString*)marketPrice;
@end
