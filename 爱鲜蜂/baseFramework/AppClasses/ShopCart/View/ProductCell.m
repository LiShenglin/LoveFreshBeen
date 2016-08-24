//
//  ProductCell.m
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ProductCell.h"
#import "DiscountPriceView.h"
#import "BuyView.h"
/**
 *  cell包含组件
 1、头像    2、精选
 3、买一送一   4、标题名
 5、灰色规格量   6、价格组合
 7、buyView购买按钮
 */

@interface ProductCell()
//头像
@property(nonatomic,strong)UIImageView *goodImageView;
//商品名称
@property(nonatomic,strong)UILabel *nameLabel;
//精选
@property(nonatomic,strong)UIImageView *fineImageView;
//买一送一
@property(nonatomic,strong)UIImageView *giveImageView;
//规格分类
@property(nonatomic,strong)UILabel *specificsLabel;
//价格组合
@property(nonatomic,strong)DiscountPriceView * discountPriceView;
//购买按钮
@property(nonatomic,strong)BuyView *buyView;

@property(nonatomic,strong)UIView *lineView;

@end
static NSString *identifier = @"ProductCell";
@implementation ProductCell
#pragma mark -- 懒加载
- (UIImageView *)goodImageView{
    if (_goodImageView == nil) {
        _goodImageView = [[UIImageView alloc]init];
    }
    return _goodImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = HomeCollectionTextFont;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView *)fineImageView{
    if (_fineImageView == nil) {
        _fineImageView = [[UIImageView alloc]init];
        _fineImageView.image =[UIImage imageNamed:@"jingxuan.png"];
    }
    return _fineImageView;
}

- (UIImageView *)giveImageView{
    if (_giveImageView == nil) {
        _giveImageView = [[UIImageView alloc]init];
        _giveImageView.image = [UIImage imageNamed:@"buyOne.png"];
    }
    return _giveImageView;
}

- (UILabel *)specificsLabel {
    if (_specificsLabel == nil) {
        _specificsLabel = [[UILabel alloc]init];
        _specificsLabel.textColor = [UIColor darkGrayColor];
        _specificsLabel.font = [UIFont systemFontOfSize:12];
        _specificsLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _specificsLabel;
}

- (BuyView *)buyView{
    if (_buyView == nil) {
        _buyView = [[BuyView alloc]init];
    }
    return _buyView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:0.9];
        _lineView.alpha = 0.6;
    }
    return _lineView;
}

#pragma mark -- 设置good商品模型
-(void)setGood:(Good *)good{
    _good = good;
    
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:_good.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    self.nameLabel.text = _good.name;
//    CHLog(@"商品名称---%@-----%@",_good.name,_good.pm_desc);
//    self.giveImageView.hidden = NO;
    if ([_good.pm_desc isEqualToString:@"买一赠一"]) {
        self.giveImageView.hidden = NO;
    } else {
        self.giveImageView.hidden = YES;
    }
    
    if (_good.is_xf == 1) {
        self.fineImageView.hidden = NO;
    }else {
        self.fineImageView.hidden = YES;
    }
    
    if (_discountPriceView != nil) {
        [_discountPriceView removeFromSuperview];
    }
    
    _discountPriceView = [[DiscountPriceView alloc]initWithPrice:_good.price marketPrice:_good.market_price];
    [self addSubview:_discountPriceView];
    
    self.specificsLabel.text = _good.specifics;
    self.buyView.good = good;
}


#pragma mark -- 设置构造函数和自动布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.goodImageView];
        [self addSubview:self.fineImageView];
        [self addSubview:self.giveImageView];
        [self addSubview:self.specificsLabel];
        [self addSubview:self.buyView];
        [self addSubview:self.lineView];
        __weak typeof(self)weakSelf = self;
        self.buyView.clickAddShopCar = ^{
            if (weakSelf.addProductClick != nil) {
                weakSelf.addProductClick(weakSelf.goodImageView);
            }
        };
        
    }
    return self;
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    ProductCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.goodImageView.frame = CGRectMake(0, 0, self.height, self.height);
    self.fineImageView.frame = CGRectMake(CGRectGetMaxX(self.goodImageView.frame), HotViewMargin, 30, 16);
    
    if (self.fineImageView.hidden) {
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.goodImageView.frame) + 3, HotViewMargin - 2, self.width - CGRectGetMaxX(self.goodImageView.frame), 20);
    }else{
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.fineImageView.frame), HotViewMargin - 2, self.width - CGRectGetMaxX(self.fineImageView.frame), 20);
    }
    
    self.giveImageView.frame = CGRectMake(CGRectGetMaxX(self.goodImageView.frame), CGRectGetMaxY(self.nameLabel.frame), 35, 15);
    self.specificsLabel.frame = CGRectMake(CGRectGetMaxY(self.goodImageView.frame), CGRectGetMaxY(self.giveImageView.frame), self.width, 20);
    self.discountPriceView.frame = CGRectMake(CGRectGetMaxX(self.goodImageView.frame), CGRectGetMaxY(self.specificsLabel.frame), 60, self.height - CGRectGetMaxY(self.specificsLabel.frame));
    self.lineView.frame = CGRectMake(HotViewMargin, self.height - 1, self.width - HotViewMargin, 1);
    self.buyView.frame = CGRectMake(self.width - 85, self.height - 30, 80, 25);
}


@end
