//
//  UIScrollView+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRefreshConst.h"
#import "CHRefreshHeaderView.h"
#import "CHRefreshFooterView.h"
@interface UIScrollView (Extension)

/**
 下拉刷新 第一个参数是方向
 */
- (void)headerViewPullToRefresh:(CHRefreashDirection)direction callback:(void(^)())callback;

/**
 开始下拉刷新
 */
- (void)headerViewBeginRefreshing;

/**
 *  结束下拉刷新
 */
- (void)headerViewStopPullToRefresh;

/**
 移除下拉刷新
 */
-(void)removeHeaderView;

-(void)setHeaderHidden:(BOOL)hidden;

-(BOOL)isHeaderHidden;

/**
 上拉加载更多
 */
-(void) footerViewPullToRefresh:(CHRefreashDirection)direction callback:(void(^)())callback;

/**
 开始上拉加载更多
 */
-(void)footerBeginRefreshing;


/**
 结束上拉加载更多
 */
-(void)footerEndRefreshing;

/**
 移除脚步
 */
-(void)removeFooterView;

-(void)setFooterHidden:(BOOL)hidden;

-(BOOL)isFooterHidden;


@end
