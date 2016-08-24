//
//  CHRefreshHeader.m
//  baseFramework
//
//  Created by chenangel on 16/6/5.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHRefreshHeader.h"

@interface CHRefreshHeader()
//滚动的图标
@property (nonatomic,weak) UIImageView *logo;
@end
@implementation CHRefreshHeader
/**
 *  初始化
 */
- (void)prepare{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    
    //隐藏最后更新时间
   // self.lastUpdatedTimeLabel.hidden = YES;
    
//    UIImageView *logo = [[UIImageView alloc]init];
//    logo.image = [UIImage imageNamed:@"bd_logo1"];
//    [self addSubview:logo];
//    self.logo = logo;
    
}
/**
 *  摆放子控件
 */
- (void)placeSubviews{
    [super placeSubviews];
    
    self.logo.width = self.width;
    self.logo.height = self.height;
    self.logo.x = 0;
    self.logo.y = -50;
}



@end
