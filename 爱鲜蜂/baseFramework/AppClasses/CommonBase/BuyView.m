//
//  BuyView.m
//  baseFramework
//
//  Created by chenangel on 16/7/2.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "BuyView.h"

@interface BuyView()
//增加
@property(nonatomic,strong)UIButton * addGoodButton;
//减持
@property(nonatomic,strong)UIButton * reduceGoodButton;
//购买数量文本
@property(nonatomic,strong)UILabel * buyCountLabel;

//补货中
@property(nonatomic,strong)UILabel * supplementLabel;

//购买的数量
@property(nonatomic,assign )NSInteger buyNumber;

@end
@implementation BuyView
#pragma mark -- 懒加载
- (UIButton *)addGoodButton{//添加按钮
    if (_addGoodButton == nil) {
        
        _addGoodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addGoodButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
        [_addGoodButton sizeToFit];
        [_addGoodButton addTarget:self action:@selector(addGoodButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addGoodButton;
}
- (UIButton *)reduceGoodButton{//减持按钮
    if (_reduceGoodButton == nil) {
        _reduceGoodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceGoodButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
        [_reduceGoodButton sizeToFit];
        [_reduceGoodButton addTarget:self action:@selector(reduceGoodButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _reduceGoodButton.hidden = NO;

    }
    return _reduceGoodButton;
}
- (UILabel *)buyCountLabel{
    if (_buyCountLabel == nil) {
        _buyCountLabel = [[UILabel alloc]init];
        _buyCountLabel.hidden = YES;
        _buyCountLabel.text = @"0";
        _buyCountLabel.textColor = [UIColor blackColor];
        _buyCountLabel.textAlignment = NSTextAlignmentCenter;
        _buyCountLabel.font = HomeCollectionTextFont;
        [_buyCountLabel sizeToFit];
        
    }
    return _buyCountLabel;
}

- (UILabel *)supplementLabel{
    if (_supplementLabel == nil) {
        _supplementLabel = [[UILabel alloc]init];
        _supplementLabel.hidden = YES;
        _supplementLabel.text = @"补货中";
        _supplementLabel.textColor = [UIColor redColor];
        _supplementLabel.textAlignment = NSTextAlignmentCenter;
        _supplementLabel.font = HomeCollectionTextFont;
        [_supplementLabel sizeToFit];
    }
    return _supplementLabel;
}

- (void)setBuyNumber:(NSInteger)buyNumber{
    _buyNumber = buyNumber;
    if (buyNumber > 0) {
        self.reduceGoodButton.hidden = NO;
        self.buyCountLabel.hidden = NO;
        self.buyCountLabel.text = [NSString stringWithFormat:@"%ld",buyNumber];
        self.buyCountLabel.hidden = NO;
        [self.buyCountLabel sizeToFit];
    }else{
        self.reduceGoodButton.hidden = YES;
        self.buyCountLabel.hidden = YES;
        self.buyCountLabel.text = @"0";
        [self.buyCountLabel sizeToFit];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self addSubview:self.addGoodButton];
        [self addSubview:self.reduceGoodButton];
        [self addSubview:self.buyCountLabel];
        [self addSubview:self.supplementLabel];
        
        self.zearIsShow = NO;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buyCountWidth = 25;
    self.addGoodButton.frame = CGRectMake(self.width - self.height -2, 0, self.height, self.height);
    self.buyCountLabel.frame = CGRectMake(CGRectGetMinX(self.addGoodButton.frame) - buyCountWidth, 0, buyCountWidth,self.height);
    self.reduceGoodButton.frame = CGRectMake(CGRectGetMinX(self.buyCountLabel.frame) - self.height, 0, self.height, self.height);
    self.supplementLabel.frame = CGRectMake(CGRectGetMinX(self.reduceGoodButton.frame), 0, self.height + buyCountWidth + self.height, self.height);
    
}


#pragma mark -- 购物车功能
//赋予商品操作对象
-(void)setGood:(Good *)good{
    _good = good;
    _buyNumber = _good.userBuyNumber;
    //商品数量等于0则显示补货
    if (_good.number <= 0) {//显示补货
        [self showSupplementLabel];
    }else{//隐藏补货
        [self hideSupplementLabel];
    }
    
    //购买数量为零则隐藏减持按钮
    if (_buyNumber == 0) {
     self.reduceGoodButton.hidden = YES && !self.zearIsShow;
     self.buyCountLabel.hidden = YES && !self.zearIsShow;
 //       self.reduceGoodButton.hidden = true;
   //     self.buyCountLabel.hidden = true;

    }else{
        self.reduceGoodButton.hidden = NO;
        self.buyCountLabel.hidden = NO;
        self.buyCountLabel.text = [NSString stringWithFormat:@"%ld",_buyNumber];
    }
}



#pragma mark -- 商品增删减持逻辑
//显示补货中
- (void)showSupplementLabel{
    self.supplementLabel.hidden = NO;
    self.addGoodButton.hidden = YES;
    self.reduceGoodButton.hidden = YES;
    self.buyCountLabel.hidden = YES;
}
//隐藏补货中，显示添加按钮
- (void)hideSupplementLabel{
    self.supplementLabel.hidden = YES;
    self.addGoodButton.hidden = NO;
    self.reduceGoodButton.hidden = NO;
    self.buyCountLabel.hidden = NO;
}
//添加商品的执行事件
- (void)addGoodButtonClick{
    if(_buyNumber >= self.good.number){
        [AINotiCenter postNotificationName:HomeGoodsInventoryProblem object:self.good.name];
        return;
    }
    
    self.reduceGoodButton.hidden = NO;
    _buyNumber++;
    
    //让商品的模型记录当前用户的购买数量
    self.good.userBuyNumber = _buyNumber;
    
    CHLog(@"新增数量----%ld-----%ld",self.good.userBuyNumber,self.buyNumber);
    
    self.buyCountLabel.text = [NSString stringWithFormat:@"%ld",_buyNumber];
    self.buyCountLabel.hidden = NO;
    
    if (self.clickAddShopCar != nil) {
        //执行外界的代码
        self.clickAddShopCar();
    }
    
    //让购物车添加商品
    [[ShopCarRedDotView shareShopCarRedDotView] addProductToRedDotView:true];
    //让闪电超市记录购买的商品
    [[UserShopCarTool shareUserShopCarTool] addSupermarkProductToShopCar:self.good];
    [AINotiCenter postNotificationName:LFBShopCarBuyPriceDidChangeNotification object:nil];
}
//减持商品的执行事件
- (void)reduceGoodButtonClick{
    if (_buyNumber <= 0) {
        self.reduceGoodButton.hidden = YES;
        return;
    }
    _buyNumber--;
    self.good.userBuyNumber = _buyNumber;
    
    if (_buyNumber == 0) {
        self.reduceGoodButton.hidden = YES && !_zearIsShow;
        self.buyCountLabel.hidden = YES && !_zearIsShow;
        self.buyCountLabel.text = self.zearIsShow ? @"0" : @"";
        
        [[UserShopCarTool shareUserShopCarTool] removeSupermarketProduct:self.good];
    }else{
        self.buyCountLabel.text = [NSString stringWithFormat:@"%ld",_buyNumber];
    }
    [[ShopCarRedDotView shareShopCarRedDotView] reduceProductToRedDotView:YES];
    [AINotiCenter postNotificationName:LFBShopCarBuyPriceDidChangeNotification object:nil];
}




@end
