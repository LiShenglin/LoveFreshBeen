//
//  SupermarketHeadView.m
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "SupermarketHeadView.h"

@implementation SupermarketHeadView
- (void)buildTitleLabel{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:0.8];
    [self.contentView addSubview:self.titleLabel];
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIView alloc]init];
        //背景UIVIEW
        self.backgroundView.backgroundColor = [UIColor clearColor];
        //内容区域背景
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self buildTitleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 0, self.width - 10, self.height);
}





@end
