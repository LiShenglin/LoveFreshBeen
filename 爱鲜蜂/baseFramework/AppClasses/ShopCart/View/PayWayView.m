//
//  PayWayView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "PayWayView.h"

#pragma mark - - PayWayView

@interface PayWayView()
@property(nonatomic,assign)PayWayType payType;
@property(nonatomic,strong)UIImageView *payIconImageView;
@property(nonatomic,strong)UILabel *payTitleLabel;
@property(nonatomic,strong)SelectedCallback selectedCallback;
@property(nonatomic,strong)UIButton *selectedButton;
@end
@implementation PayWayView
#pragma mark -- UI懒加载
-(UIImageView *)payIconImageView{
    if (_payIconImageView == nil) {
        _payIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    }
    return _payIconImageView;
}
-(UILabel *)payTitleLabel{
    if (_payTitleLabel == nil) {
        _payTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 150, 40)];
    }
    return _payTitleLabel;
}
- (UIButton *)selectedButton{
    if (_selectedButton == nil) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.frame = CGRectMake(SCREEN_WIDTH - 10 - 16, (40 - 16) * 0.5, 16, 16);
    }
    return _selectedButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.payIconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.payIconImageView];
        
        self.payTitleLabel.textColor = [UIColor blackColor];
        self.payTitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.payTitleLabel];
        
        [self.selectedButton setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
        [self.selectedButton setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateSelected];
        self.selectedButton.userInteractionEnabled = NO;
        [self addSubview:self.selectedButton];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.alpha = 0.1;
        [self addSubview:lineView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedPayView)];
        [self addGestureRecognizer:tap];

        
    }
    return self;
}

- (void)selectedPayView{
    self.selectedButton.selected = YES;
    if (self.selectedCallback != nil) {
        self.selectedCallback(self.payType);
    }
}
- (instancetype)initWithFrame:(CGRect)frame payType:(PayWayType)payType selectedCallBack:(SelectedCallback)selectedCallback{
    if (self = [self initWithFrame:frame]) {
        
        
        self.payType = payType;
        switch (payType) {
            case WeChat:
                self.payIconImageView.image = [UIImage imageNamed:@"v2_weixin"];
                self.payTitleLabel.text = @"微信支付";
                break;
            case QQPurse:
                self.payIconImageView.image = [UIImage imageNamed:@"icon_qq"];
                self.payTitleLabel.text = @"QQ钱包";
                break;
            case AliPay:
                self.payIconImageView.image = [UIImage imageNamed:@"zhifubaoA"];
                self.payTitleLabel.text = @"支付宝支付";
                break;
            case Delivery:
                self.payIconImageView.image = [UIImage imageNamed:@"v2_dao"];
                self.payTitleLabel.text = @"货到支付";
                break;
            default:
                break;
        }
        self.selectedCallback = selectedCallback;
    }
    return self;
}

@end


#pragma mark - - PayView

@implementation PayView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        __weak typeof(self)weakSelf = self;
        
        self.weChatView = [[PayWayView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) payType:WeChat selectedCallBack:^(PayWayType type) {
            [weakSelf setSelectedPayView:WeChat];
        }];
        self.weChatView.selectedButton.selected = YES;
        
        self.qqPurseView = [[PayWayView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40) payType:QQPurse selectedCallBack:^(PayWayType type) {
            [weakSelf setSelectedPayView:QQPurse];
        }];
        
        self.alipayView = [[PayWayView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 40) payType:AliPay selectedCallBack:^(PayWayType type) {
            [weakSelf setSelectedPayView:AliPay];
        }];
        
        self.deliveryView = [[PayWayView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 40) payType:Delivery selectedCallBack:^(PayWayType type) {
            [weakSelf setSelectedPayView:Delivery];
        }];
        
        [self addSubview:self.weChatView];
        [self addSubview:self.qqPurseView];
        [self addSubview:self.alipayView];
        [self addSubview:self.deliveryView];
    }
    return self;
}

- (void)setSelectedPayView:(PayWayType)type{
    self.weChatView.selectedButton.selected = (type == WeChat);
    self.qqPurseView.selectedButton.selected = (type == QQPurse);
    self.alipayView.selectedButton.selected = (type == AliPay);
    self.deliveryView.selectedButton.selected = (type == Delivery);
}


@end