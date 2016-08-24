//
//  HomeCell.m
//  baseFramework
//
//  Created by chenangel on 16/7/2.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HomeCell.h"
#import "DiscountPriceView.h"
#import "BuyView.h"

@interface HomeCell()
//广告背景图---》水平的时候cell显示
@property(nonatomic,strong)UIImageView* backImageView;

/** cell垂直显示 */
//商品图片
@property(nonatomic,strong)UIImageView*goodsImageView;
//商品标题
@property(nonatomic,strong)UILabel*nameLabel;
//精选
@property(nonatomic,strong)UIImageView*fineImageView;
//买一送一
@property(nonatomic,strong)UIImageView*giveImageView;
//份量
@property(nonatomic,strong)UILabel*specificsLabel;
//价格
@property(nonatomic,strong)DiscountPriceView*discountPriceView;
//增减组件
@property(nonatomic,strong)BuyView * buyView;
//Cell类型
@property(nonatomic,assign)HomeCellType type;
@end
@implementation HomeCell
#pragma mark -- 懒加载
-(UIImageView *)backImageView{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc]init];
    }
    return _backImageView;
}

- (UIImageView *)goodsImageView{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = HomeCollectionTextFont;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UIImageView *)fineImageView{
    if (_fineImageView == nil) {
        _fineImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jingxuan.png"]];
    }
    return _fineImageView;
}
- (UIImageView *)giveImageView{
    if (_giveImageView == nil) {
        _giveImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"buyOne.png"]];
    }
    return _giveImageView;
}

- (UILabel *)specificsLabel{
    if (_specificsLabel == nil) {
        _specificsLabel = [[UILabel alloc]init];
        _specificsLabel.textColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1.0];
        _specificsLabel.font = [UIFont systemFontOfSize:12];
        _specificsLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _specificsLabel;
}
//销售价和市场价格视图
//- (DiscountPriceView *)discountPriceView{
//    if (_discountPriceView == nil) {
//        _discountPriceView = [[DiscountPriceView alloc]init];
//    }
//    return _discountPriceView;
//}

//增减购买组件
- (BuyView *)buyView{
    if (_buyView == nil) {
        _buyView = [[BuyView alloc]init];
    }
    return _buyView;
}

- (void)setType:(HomeCellType)type{
    if (type == HomeCellTypeHorizontal) {
        self.backImageView.hidden = NO;
        self.goodsImageView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.fineImageView.hidden = YES;
        self.giveImageView.hidden = YES;
        self.specificsLabel.hidden = YES;
        self.discountPriceView.hidden = YES;
        self.buyView.hidden = YES;
    }else{
        self.goodsImageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.fineImageView.hidden = NO;
        self.giveImageView.hidden = NO;
        self.specificsLabel.hidden = NO;
        self.discountPriceView.hidden = NO;
        self.buyView.hidden = NO;
        self.backImageView.hidden = YES;
    }

}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.backImageView];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.fineImageView];
        [self.contentView addSubview:self.giveImageView];
        [self.contentView addSubview:self.specificsLabel];
        [self.contentView addSubview:self.buyView];
        
        __weak typeof(self)weakSelf = self;
        
        self.buyView.clickAddShopCar = ^(){
            if (weakSelf.addButtonClick != nil) {//保存这段block，让外界执行这个图片的点击
                weakSelf.addButtonClick(weakSelf.goodsImageView);
            }
        };
        
    }
    return self;
}

#pragma mark -- 设置模型数据
//加入设置的是广告模型
- (void)setActivities:(Activities *)activities{
    _activities = activities;
    self.type = HomeCellTypeHorizontal;

    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:activities.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];

    
    self.backImageView.hidden = NO;
    self.goodsImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.fineImageView.hidden = YES;
    self.giveImageView.hidden = YES;
    self.specificsLabel.hidden = YES;
    _discountPriceView.hidden = YES;
    self.buyView.hidden = YES;

}
//加入设置的是商品模型
-(void)setGood:(Good *)good{
    _good = good;
    
    self.type = HomeCellTypeVertical;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:good.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    
    self.nameLabel.text = self.good.name;
    if ([self.good.pm_desc isEqualToString: @"买一送一"]) {
        self.giveImageView.hidden = NO;
    }else{
        self.giveImageView.hidden = YES;
    }
    

    if (_discountPriceView != nil) {
        [_discountPriceView removeFromSuperview];
    }
    
    
    self.discountPriceView = [[DiscountPriceView alloc]initWithPrice:self.good.price marketPrice:self.good.market_price];
    [self addSubview:self.discountPriceView];
    
    //[self.contentView bringSubviewToFront:self.discountPriceView];
    //[self layoutIfNeeded];
    
    
    self.specificsLabel.text = self.good.specifics;
    self.specificsLabel.textColor = [UIColor grayColor];
    
    self.buyView.good = good;
    
    self.goodsImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.fineImageView.hidden = NO;
    self.giveImageView.hidden = NO;
    self.specificsLabel.hidden = NO;
    self.discountPriceView.hidden = NO;
    self.buyView.hidden = NO;
    self.backImageView.hidden = YES;

    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backImageView.frame = self.bounds;
    
    self.goodsImageView.frame = CGRectMake(0, 0, self.width, self.width);
    self.nameLabel.frame = CGRectMake(5, self.width, self.width - 15, 20);
    
    self.fineImageView.frame = CGRectMake(5, CGRectGetMaxY(self.nameLabel.frame), 30, 15);
    self.giveImageView.frame = CGRectMake(CGRectGetMaxX(self.fineImageView.frame) + 3, self.fineImageView.y, 35, 15);
    //份量
    self.specificsLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.fineImageView.frame), self.width, 20);
    //市场价和销售价
    _discountPriceView.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.specificsLabel.frame), 60,self.height - CGRectGetMaxY(self.specificsLabel.frame));
    
    
    self.buyView.frame = CGRectMake(self.width - 85, self.height - 30, 80, 25);
}


@end
