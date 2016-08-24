//
//  HomeCollectionFooterView.m
//  baseFramework
//
//  Created by chenangel on 16/6/29.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HomeCollectionFooterView.h"

@interface HomeCollectionFooterView ()
@property(nonatomic,weak)UILabel *titleLabel;
@end
@implementation HomeCollectionFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"点击查看更多>";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor darkGrayColor];
        label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        [self addSubview:label];
        self.titleLabel = label;
    }
    return self;
}

- (void)hideLabel{
    self.titleLabel.hidden = YES;
}
- (void)showLabel{
    self.titleLabel.hidden = NO;
}
- (void)setFooterTitle:(NSString*)text textColor:(UIColor*)textColor{
    self.titleLabel.text = text;
    self.titleLabel.textColor = textColor;
}

@end
