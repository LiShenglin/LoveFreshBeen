//
//  ShopCartGoodsListView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCartGoodsListView.h"

@interface ShopCartGoodsListView()
@property(nonatomic,assign)CGFloat lastViewY;

@end
@implementation ShopCartGoodsListView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *goodses = [[UserShopCarTool shareUserShopCarTool] getShopCarProduct];
        
        for (NSInteger i = 0 ; i < goodses.count; i++) {
            Good * good = goodses[i];
            [self buildlineView:CGRectMake(15, self.lastViewY + 0, SCREEN_WIDTH - 15, 0.5)];
            if (![good.pm_desc isEqualToString:@"买一赠一"]) {
                PayGoodsDetailView * goodDetailView = [[PayGoodsDetailView alloc]initWithFrame:CGRectMake(0, self.lastViewY + 10, SCREEN_WIDTH, 20)];
                goodDetailView.goods = good;
                [self addSubview:goodDetailView];
                self.lastViewY += 40;
                self.goodsHeight += 40;
                
            }else{//有赠品，则显示赠品详情
                PayGoodsDetailView * goodsDetailView = [[PayGoodsDetailView alloc]initWithFrame:CGRectMake(0, self.lastViewY + 10, SCREEN_WIDTH, 20)];
                good.pm_desc = @"";
                goodsDetailView.goods = good;
                [self addSubview:goodsDetailView];
                self.lastViewY += 30;
                
                PayGoodsDetailView * giftView = [[PayGoodsDetailView alloc]initWithFrame:CGRectMake(0, self.lastViewY, SCREEN_WIDTH, 20)];
                good.pm_desc = @"买一赠一";
                giftView.goods = good;
                [self addSubview:giftView];
                self.lastViewY += 30;
                self.goodsHeight += 60;
                
            }
        }
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, self.lastViewY - 0.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.alpha = 0.1;
        [self addSubview:lineView];
        
        self.goodsHeight += 40;
        
        UILabel *finePriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, self.lastViewY, SCREEN_WIDTH - 60, 40)];
        finePriceLabel.textAlignment = NSTextAlignmentRight;
        finePriceLabel.textColor = [UIColor redColor];
        finePriceLabel.font = [UIFont systemFontOfSize:14];
        finePriceLabel.text = [NSString stringWithFormat:@"合计:$%@",[[UserShopCarTool shareUserShopCarTool] getAllProductPrice]];
        [self addSubview:finePriceLabel];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.goodsHeight - 1, SCREEN_WIDTH , 1)];
        lineView1.backgroundColor = [UIColor blackColor];
        lineView1.alpha = 0.1;
        [self addSubview:lineView1];
        
        
    }
    return self;
}

- (UIView*)buildlineView:(CGRect)frame {
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}

@end


@interface PayGoodsDetailView()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView * giftImageView;

@property(nonatomic,assign)BOOL isShowImageView;

@end
@implementation PayGoodsDetailView
#pragma mark -- PayGoodsDetailView 懒加载
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc]init];
    }
    return _numberLabel;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]init];
    }
    return _priceLabel;
}
-(UIImageView *)giftImageView{
    if (_giftImageView == nil) {
        _giftImageView = [[UIImageView alloc]init];
    }
    return _giftImageView;
}

- (void)setGoods:(Good *)goods{
    _goods = goods;
    
    if (_goods.is_xf == 1) {
        self.titleLabel.text = [NSString stringWithFormat:@"[精选]%@",goods.name];
    }else{
        self.titleLabel.text = goods.name;
    }
    
    self.numberLabel.text = [NSString stringWithFormat:@"x%ld",goods.userBuyNumber];
    self.priceLabel.text = [NSString stringWithFormat:@"$%@",[goods.price cleanDecimalPointZear]];
    
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        self.giftImageView.hidden = YES;
        self.isShowImageView = NO;
        [self layoutSubviews];
    }else{
        self.giftImageView.hidden = false;
        self.isShowImageView = YES;
        self.priceLabel.hidden = YES;
        self.titleLabel.text = [NSString stringWithFormat:@"[精选]%@[赠]",goods.name];
    }
    
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
        self.numberLabel.font = [UIFont systemFontOfSize:13];
        self.numberLabel.textColor = [UIColor blackColor];
        self.numberLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.numberLabel];
        
        self.priceLabel.font = [UIFont systemFontOfSize:13];
        self.priceLabel.textColor = [UIColor blackColor];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.priceLabel];
        
        self.giftImageView.hidden = YES;
        self.giftImageView.image = [UIImage imageNamed:@"zengsong"];
        [self addSubview:self.giftImageView];
        
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.isShowImageView) {
        self.giftImageView.frame = CGRectMake(15, (self.height - 20) * 0.5, 40, 20);
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.giftImageView.frame) + 5, 0, self.width * 0.5, self.height);
        self.numberLabel.frame = CGRectMake(SCREEN_WIDTH * 0.7, 0, 50, self.height);
    }else{
        self.titleLabel.frame = CGRectMake(15, 0, self.width * 0.6, self.height);
        self.numberLabel.frame = CGRectMake(SCREEN_WIDTH * 0.7, 0, 50, self.height);
    }
    
}

@end
