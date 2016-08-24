//
//  CategoryCell.m
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell()
//分类名字
@property(nonatomic,strong)UILabel *nameLabel;
//背景图
@property(nonatomic,strong)UIImageView *backImageView;
//黄色指示器
@property(nonatomic,strong)UIView * yellowView;
//间隔线
@property(nonatomic,strong)UIView *lineView;
@end
@implementation CategoryCell
static NSString * identifier = @"CategoryCell";
#pragma mark -- 懒加载属性
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor darkGrayColor];
        _nameLabel.highlightedTextColor = [UIColor blackColor];
    }
    return _nameLabel;
}
-(UIImageView *)backImageView{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc]init];
        //全灰背景
        [_backImageView setImage:[UIImage imageNamed:@"llll"]];
        //全白背景
        [_backImageView setHighlightedImage:[UIImage imageNamed:@"kkkkkkk"]];
        
    }
    return _backImageView;
}
-(UIView *)yellowView{
    if (_yellowView == nil) {
        _yellowView = [[UIView alloc] init];
        _yellowView.backgroundColor = LFBNavigationYellowColor;
    }
    return _yellowView;
}
-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}
-(void)setCategorie:(Categorie *)categorie{
    _categorie = categorie;
    _nameLabel.text = categorie.name;
}
//创建必经过的方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.backImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.yellowView];
    }
    return self;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    CategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//cell选中的动画
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.nameLabel.highlighted = selected;
    self.backImageView.highlighted = selected;
    self.yellowView.hidden = !selected;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.frame = self.bounds;
    self.backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    self.yellowView.frame = CGRectMake(0, self.height * 0.1, 5, self.height*0.8);
    self.lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
}



@end
