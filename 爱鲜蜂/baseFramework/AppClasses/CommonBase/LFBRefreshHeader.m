//
//  LFBRefreshHeader.m
//  baseFramework
//
//  Created by chenangel on 16/7/3.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "LFBRefreshHeader.h"

@implementation LFBRefreshHeader

-(void)prepare{
    [super prepare];
    self.stateLabel.hidden = NO;
    
    self.lastUpdatedTimeLabel.hidden = YES;
    
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh1"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh2"]] forState:MJRefreshStatePulling];
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh1"],[UIImage imageNamed:@"v2_pullRefresh2"]] forState:MJRefreshStateRefreshing];
    
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松手开始刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    
}

@end
