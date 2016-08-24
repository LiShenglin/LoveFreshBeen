//
//  HomeCollectionHeaderView.m
//  baseFramework
//
//  Created by chenangel on 16/6/29.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HomeCollectionHeaderView.h"

@interface HomeCollectionHeaderView ()
@property(nonatomic,weak)UILabel *titleLabel;
@end
@implementation HomeCollectionHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"新鲜热卖";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        label.frame = CGRectMake(10, 0, self.width, 25);
        //label.backgroundColor = [UIColor orangeColor];
        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
        self.titleLabel = label;
    }
    return self;
}


@end
