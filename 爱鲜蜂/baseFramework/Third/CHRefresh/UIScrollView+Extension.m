//
//  UIScrollView+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIScrollView+Extension.h"


@implementation UIScrollView (Extension)

/**
 下拉刷新 第一个参数是方向
 */
- (void)headerViewPullToRefresh:(CHRefreashDirection)direction callback:(void(^)())callback{
    // 创建headerview
    CHRefreshHeaderView * headerView = [CHRefreshHeaderView headerView];
    headerView.viewDirection = direction;
    [self addSubview:headerView];
    headerView.beginRefreshingCallback = callback;
    headerView.State = RefreshStateNormal;
}

/**
 开始下拉刷新
 */
- (void)headerViewBeginRefreshing{
    for (UIView* ve in self.subviews) {
        if ([ve isKindOfClass:[CHRefreshHeaderView class]]) {
           CHRefreshHeaderView * view = (CHRefreshHeaderView *)ve;
            [view beginRefreshing];
        }
    }
}

/**
 *  结束下拉刷新
 */
- (void)headerViewStopPullToRefresh{
    for (UIView *ve in self.subviews){
        if([ve isKindOfClass:[CHRefreshHeaderView class]]){
            CHRefreshHeaderView *view = (CHRefreshHeaderView*)ve;
            [view endRefreshing];
        }
    }
}

/**
 移除下拉刷新
 */
-(void)removeHeaderView{
    for(UIView *ve in self.subviews){
        if ([ve isKindOfClass:[CHRefreshHeaderView class]]){
            [ve removeFromSuperview];
        }
    }
}

-(void)setHeaderHidden:(BOOL)hidden
{
    for(UIView *ve in self.subviews){
        if ([ve isKindOfClass:[CHRefreshHeaderView class]]){
            CHRefreshHeaderView* view = (CHRefreshHeaderView*)ve;
            view.hidden = hidden;
        }
    }
    
}

-(BOOL)isHeaderHidden
{
    for(UIView *ve in self.subviews){
        if ([ve isKindOfClass:[CHRefreshHeaderView class]]){
            CHRefreshHeaderView *view = (CHRefreshHeaderView*)ve;
            return view.hidden;
        }
    }
    return nil;
}

/**
 上拉加载更多
 */
-(void)footerViewPullToRefresh:(CHRefreashDirection)direction callback:(void(^)())callback {
    CHRefreshFooterView *footView = [[CHRefreshFooterView alloc]init];
    if (direction == CHRefreshDirectionHorizontal){
        footView.frame = CGRectMake(0, 0, CHRefreshViewHeight, SCREEN_HEIGHT);
        
    } else {
        footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CHRefreshViewHeight);
    }
    footView.viewDirection = direction;
    [self addSubview:footView];
    
    footView.beginRefreshingCallback = callback;
    footView.State = RefreshStateNormal;
}

/**
 开始上拉加载更多
 */
-(void)footerBeginRefreshing {
    for (UIView *ve in self.subviews) {
        if ([ve isKindOfClass:[CHRefreshFooterView class]]){
            CHRefreshFooterView *view = (CHRefreshFooterView*)ve;
            [view beginRefreshing];
        }
    }
}


/**
 结束上拉加载更多
 */
-(void)footerEndRefreshing
{
    for (UIView *ve in self.subviews){
        if ([ve isKindOfClass:[CHRefreshFooterView class]]){
            CHRefreshFooterView *view = (CHRefreshFooterView*)ve;
            [view beginRefreshing];
        }
    }
}

/**
 移除脚步
 */
-(void)removeFooterView{
    for(UIView *ve in self.subviews){
        if([ve isKindOfClass:[CHRefreshFooterView class]]){
            [ve removeFromSuperview];
        }
    }
}

-(void)setFooterHidden:(BOOL)hidden
{
    for(UIView *ve in self.subviews){
        if ([ve isKindOfClass: [CHRefreshFooterView class]]){
            CHRefreshFooterView *view = (CHRefreshFooterView*)ve;
            view.hidden = hidden;
        }
    }
    
}

-(BOOL)isFooterHidden
{
    for(UIView *ve in self.subviews){
        if ([ve isKindOfClass: [CHRefreshFooterView class]]){
            CHRefreshFooterView *view = (CHRefreshFooterView*)ve;
            return view.hidden;
        }
    }
    return nil;
}
@end
