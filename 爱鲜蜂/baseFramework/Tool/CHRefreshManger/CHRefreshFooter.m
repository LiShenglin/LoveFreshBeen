//
//  CHRefreshFooter.m
//  baseFramework
//
//  Created by chenangel on 16/6/5.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHRefreshFooter.h"

@implementation CHRefreshFooter

-(void)prepare{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    [self setTitle:@"没有数据啦，不要再上啦了" forState:MJRefreshStateNoMoreData];
    
    //刷新控件出现一办就会进入刷新状态
    self.triggerAutomaticallyRefreshPercent = 0.5;
    //不要自动刷新
    self.automaticallyRefresh = NO;
    
}

@end
