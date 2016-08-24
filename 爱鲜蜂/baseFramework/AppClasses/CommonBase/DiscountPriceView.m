//
//  DiscountPriceView.m
//  baseFramework
//
//  Created by chenangel on 16/7/2.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "DiscountPriceView.h"

@interface DiscountPriceView()
@property(nonatomic,strong)UILabel*marketPriceLabel;
@property(nonatomic,strong)UILabel*priceLabel;
@property(nonatomic,strong)UIView*lineView;
//是否显示市场价格
@property(nonatomic,assign)BOOL hasMarketPrice;

@end
@implementation DiscountPriceView

-(UILabel *)marketPriceLabel{
    if (_marketPriceLabel == nil) {
        _marketPriceLabel = [[UILabel alloc]init];
    }
    return _marketPriceLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]init];
    }
    return _priceLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}

-(void)setPriceColor:(UIColor *)priceColor{
    _priceColor = priceColor;
    self.priceLabel.textColor = priceColor;
}
- (void)setMarketPriceColor:(UIColor *)marketPriceColor{
    _marketPriceColor = marketPriceColor;
    if (self.marketPriceLabel.text != nil) {
        self.marketPriceLabel.textColor = marketPriceColor;
        if (self.lineView != nil) {
            self.lineView.backgroundColor = marketPriceColor;
        }
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.marketPriceLabel.textColor = [UIColor colorWithRed:80 green:80 blue:80 alpha:1];
        self.marketPriceLabel.font = HomeCollectionTextFont;
        [self addSubview:self.marketPriceLabel];
        
        self.lineView.backgroundColor = [UIColor colorWithRed:80 green:80 blue:80 alpha:1];
        [self.marketPriceLabel addSubview:self.lineView];
        
        self.priceLabel.font = HomeCollectionTextFont;
        self.priceLabel.textColor = [UIColor redColor];
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (instancetype)initWithPrice:(NSString*)price marketPrice:(NSString*)marketPrice{
    if (self = [super init]) {
        
        if (price != nil) {
            self.priceLabel.text = [NSString stringWithFormat:@"$%@",[price cleanDecimalPointZear]];
            [self.priceLabel sizeToFit];
        }
        
        if (marketPrice != nil) {
            self.marketPriceLabel.text = [NSString stringWithFormat:@"$%@",[marketPrice cleanDecimalPointZear]];
            [self.marketPriceLabel sizeToFit];
        }else{
            self.hasMarketPrice = NO;
        }
        
        if (marketPrice == price) {
            self.hasMarketPrice = NO;
        }else{
            self.hasMarketPrice = YES;
        }
        
        if (self.hasMarketPrice) {
            self.marketPriceColor = [UIColor darkGrayColor];
            
        }
        
        self.marketPriceLabel.hidden = NO;
    }
    return self;
}

- (void)layoutSubviews{
    self.priceLabel.x = 0;
    self.priceLabel.y = 0;
    self.priceLabel.width = self.priceLabel.width;
    self.priceLabel.height = self.height;
    
    if (self.hasMarketPrice) {
        CGRect frame = self.marketPriceLabel.frame;
        frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+5, 0, frame.size.width, self.height);
        self.marketPriceLabel.frame = frame;
        
        self.lineView.width = self.marketPriceLabel.width;
        self.lineView.height = 2;
        self.lineView.x = 0;
        self.lineView.y = self.marketPriceLabel.height *0.45;

    }
    
}


@end
