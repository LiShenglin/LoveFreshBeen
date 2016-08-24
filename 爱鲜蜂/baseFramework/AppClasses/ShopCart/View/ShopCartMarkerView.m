//
//  ShopCartMarkerView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCartMarkerView.h"

@implementation ShopCartMarkerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat marketHeight = 60;
    
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:[self lineView:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)]];
        UIImageView *rocketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lighting"]];
        rocketImageView.frame = CGRectMake(15, 5, 20, 20);
        [self addSubview:rocketImageView];
    
        UIImageView *redDotImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red"]];
        redDotImageView.frame = CGRectMake(15, (marketHeight - CGRectGetMaxY(rocketImageView.frame) - 4) * 0.5 + CGRectGetMaxY(rocketImageView.frame), 4, 4);
        [self addSubview:redDotImageView];
    
        UILabel *marketTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rocketImageView.frame) + 10, 5, SCREEN_WIDTH * 0.6, 20)];
        marketTitleLabel.text = @"闪电超市";
        marketTitleLabel.font = [UIFont systemFontOfSize:12];
        marketTitleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:marketTitleLabel];
    
        UILabel *marketLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(redDotImageView.frame) + 5, CGRectGetMaxY(rocketImageView.frame), SCREEN_WIDTH* 0.7, 60 - CGRectGetMaxY(rocketImageView.frame))];
        
        marketLabel.text = @"   22:00前满$30免运费,22:00后满$50面运费";
        marketLabel.textColor = [UIColor lightGrayColor];
        marketLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:marketLabel];
        [self addSubview:[self lineView:CGRectMake(0, marketHeight - 0.5, SCREEN_WIDTH, 0.5)]];
    
    }
    return self;
}

- (UIView*)lineView:(CGRect)frame {
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}


@end
