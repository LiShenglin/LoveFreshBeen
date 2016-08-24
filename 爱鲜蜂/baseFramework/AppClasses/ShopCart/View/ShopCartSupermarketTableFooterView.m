//
//  ShopCartSupermarketTableFooterView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCartSupermarketTableFooterView.h"



@interface ShopCartSupermarketTableFooterView()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *determineButton;
@property(nonatomic,strong)UIView *backView;


@end
@implementation ShopCartSupermarketTableFooterView
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]init];
    }
    return _priceLabel;
}

-(UIButton *)determineButton{
    if (_determineButton == nil) {
        _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _determineButton;
}
-(UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
    }
    return _backView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ShopCartRowHeight);
        self.backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        
        self.titleLabel.text = @"共$ ";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.titleLabel sizeToFit];
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.frame = CGRectMake(15, 0, self.titleLabel.width, ShopCartRowHeight);
        [self addSubview:self.titleLabel];
        
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, SCREEN_WIDTH * 0.5, ShopCartRowHeight);
        self.priceLabel.text = [[UserShopCarTool shareUserShopCarTool] getAllProductPrice];
        [self addSubview:self.priceLabel];
        
        self.determineButton.frame = CGRectMake(SCREEN_WIDTH - 90, 0, 90, ShopCartRowHeight);
        self.determineButton.backgroundColor = LFBNavigationYellowColor;
        [self.determineButton setTitle:@"选好了" forState:UIControlStateNormal];
        [self.determineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.determineButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.determineButton addTarget:self action:@selector(determineButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.determineButton];
        
        [self addSubview:[self lineView:CGRectMake(0, ShopCartRowHeight - 0.5, SCREEN_WIDTH, 0.5)]];
        
    }
    return self;
}

- (void)setpriceLabel:(CGFloat)price{
    self.priceLabel.text = [[NSString stringWithFormat:@"%f",price] cleanDecimalPointZear];
    
}
- (void)determineButtonClick{
    if ([self.delegate respondsToSelector:@selector(supermarketTableFooterDetermineButtonClick)]) {
        [self.delegate supermarketTableFooterDetermineButtonClick];
    }
}




- (UIView*)lineView:(CGRect)frame {
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}

@end
