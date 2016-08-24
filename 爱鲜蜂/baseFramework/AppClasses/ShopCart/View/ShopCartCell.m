//
//  ShopCartCell.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCartCell.h"
#import "BuyView.h"

@interface ShopCartCell()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)BuyView *buyView;

@end
static NSString * identifier = @"ShopCarCell";
@implementation ShopCartCell
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

- (BuyView *)buyView{
    if (_buyView == nil) {
        _buyView = [[BuyView alloc]init];
    }
    return _buyView;
}

-(void)setGood:(Good *)good{
    _good = good;
    if (good.is_xf == 1) {
        _titleLabel.text = [NSString stringWithFormat:@"[精选]%@",good.name];
    }else {
        _titleLabel.text = good.name;
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"$%@",_good.price];
    
    _buyView.good = good;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH * 0.5, ShopCartRowHeight);
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.buyView.frame = CGRectMake(SCREEN_WIDTH - 85, (ShopCartRowHeight - 25)*0.55, 80, 25);
        
        [self.contentView addSubview:self.buyView];
        
        self.priceLabel.frame = CGRectMake(CGRectGetMinX(self.buyView.frame) - 100 - 5, 0, 100, ShopCartRowHeight);
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.priceLabel];
        
        CHLog(@"%@----%@",NSStringFromCGRect(self.buyView.frame),NSStringFromCGRect(self.priceLabel.frame));
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, ShopCartRowHeight - 0.5, SCREEN_WIDTH - 10, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.alpha = 0.1;
        [self.contentView addSubview:lineView];
        
        
    }
    return self;
}

+ (instancetype)shopCarCell:(UITableView*)tableView{
    ShopCartCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
