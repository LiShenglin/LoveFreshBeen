//
//  ReceiptAddressView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ReceiptAddressView.h"
#import "Address.h"

@interface ReceiptAddressView()
@property(nonatomic,strong)UIImageView * topImageView;
@property(nonatomic,strong)UIImageView * bottomImageView;

@property(nonatomic,strong)UILabel * consigneeLabel;
@property(nonatomic,strong)UILabel * phoneNumLabel;
@property(nonatomic,strong)UILabel *receiptAdressLabel;
@property(nonatomic,strong)UILabel *consigneeTextLabel;
@property(nonatomic,strong)UILabel *phoneNumTextLabel;
@property(nonatomic,strong)UILabel *receiptAdressTextLabel;

@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UIButton * modifyButton;
@property(nonatomic,weak)dispatch_block_t modifyButtonClickCallBack;

@end

@implementation ReceiptAddressView
-(UIImageView *)topImageView{
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
        [self addSubview:_topImageView];
    }
    return _topImageView;
}

-(UIImageView *)bottomImageView{
    if (_bottomImageView == nil) {
        _bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
        [self addSubview:_bottomImageView];
    }
    return _bottomImageView;
}
-(UILabel *)consigneeLabel{
    if (_consigneeLabel == nil) {
        _consigneeLabel = [[UILabel alloc]init];
        [self addSubview:_consigneeLabel];
    }
    return _consigneeLabel;
}
-(UILabel *)phoneNumLabel{
    if (_phoneNumLabel == nil) {
        _phoneNumLabel = [[UILabel alloc]init];
        [self addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}
-(UILabel *)receiptAdressLabel{
    if (_receiptAdressLabel == nil) {
        _receiptAdressLabel = [[UILabel alloc]init];
        [self addSubview:_receiptAdressLabel];
    }
    return _receiptAdressLabel;
}

-(UILabel *)consigneeTextLabel{
    if (_consigneeLabel == nil) {
        _consigneeLabel = [[UILabel alloc]init];
        [self addSubview:_consigneeLabel];
    }
    return _consigneeLabel;
}
-(UILabel *)phoneNumTextLabel{
    if (_phoneNumTextLabel == nil) {
        _phoneNumTextLabel = [[UILabel alloc]init];
        [self addSubview:_phoneNumTextLabel];
    }
    return _phoneNumTextLabel;
}

-(UILabel *)receiptAdressTextLabel{
    if (_receiptAdressTextLabel == nil) {
        _receiptAdressTextLabel = [[UILabel alloc]init];
        [self addSubview:_receiptAdressTextLabel];
    }
    return _receiptAdressTextLabel;
}
-(UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}



-(void)setAddress:(Address *)address{
    _address = address;
    if(_address != nil) {
        self.consigneeTextLabel.text = [NSString stringWithFormat:@"%@%@",self.address.accept_name,([address.gender isEqual: @"1"] ? @" 先生" : @" 女士")];
        
        self.phoneNumTextLabel.text = self.address.telphone;
        self.receiptAdressTextLabel.text = self.address.address;
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
//        [self addSubview:self.topImageView];
//        [self addSubview:self.bottomImageView];
//        [self addSubview:self.arrowImageView];
        

        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame modifyButtonClickCallBack:(dispatch_block_t) modifyButtonClickCallBack{
    if (self = [super initWithFrame:frame]) {
        [self.modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        [self.modifyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.modifyButton addTarget:self action:@selector(modifyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.modifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.modifyButton];
        
        [self initLabel:self.consigneeLabel text:@"收货人"];
        [self initLabel:self.phoneNumLabel text:@"电   话"];
        [self initLabel:self.receiptAdressLabel text:@"收货地址"];
        [self initLabel:self.consigneeTextLabel text:@""];
        [self initLabel:self.phoneNumTextLabel text:@""];
        [self initLabel:self.receiptAdressTextLabel text:@""];
        
        self.modifyButtonClickCallBack = modifyButtonClickCallBack;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = 15;
    
    self.topImageView.frame = CGRectMake(0, 0, self.width, 2);
    self.bottomImageView.frame = CGRectMake(0, self.height - 2, self.width, 2);
    
    self.consigneeLabel.frame = CGRectMake(leftMargin, 10, self.consigneeLabel.width, self.consigneeLabel.height);
    self.consigneeTextLabel.frame = CGRectMake(CGRectGetMaxX(self.consigneeLabel.frame) + 5, self.consigneeLabel.y, 150, self.consigneeLabel.height);
    
    self.phoneNumLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.consigneeLabel.frame) + 5, self.phoneNumLabel.width, self.phoneNumLabel.height);
    self.phoneNumTextLabel.frame = CGRectMake(CGRectGetMaxX(self.phoneNumLabel.frame),self.phoneNumLabel.y, 150, self.phoneNumLabel.height);
    
    self.receiptAdressLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.phoneNumTextLabel.frame) + 5, self.receiptAdressLabel.width, self.receiptAdressLabel.height);
    self.receiptAdressTextLabel.frame = CGRectMake(CGRectGetMaxX(self.receiptAdressLabel.frame), self.receiptAdressLabel.y, 150, self.receiptAdressLabel.height);
    
    self.modifyButton.frame = CGRectMake(self.width - 60, 0, 30, self.height);
    self.arrowImageView.frame = CGRectMake(self.width - 15, (self.height - self.arrowImageView.height) * 0.5, self.arrowImageView.width, self.arrowImageView.height);
    
}

-(void)initLabel:(UILabel*)label text:(NSString*)text{
    label.text = text;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    [self addSubview:label];
}

-(void)modifyButtonClick{
    if (self.modifyButtonClickCallBack != nil) {
        self.modifyButtonClickCallBack();
    }
}


@end
