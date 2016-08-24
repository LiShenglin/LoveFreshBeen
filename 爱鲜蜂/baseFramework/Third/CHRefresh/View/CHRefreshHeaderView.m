//
//  CHRefreshHeaderView.m
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHRefreshHeaderView.h"

@implementation CHRefreshHeaderView

- (void)setState:(CHRefreshState)State{
    self.oldState = State;
    
    switch (self.State) {
            //普通状态
        case RefreshStateNormal:
        {if (RefreshStateRefreshing == self.oldState){
                [UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
                [self.scrollView setContentOffset:CGPointZero animated:true];
            } else {
                [UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            self.scrollView.scrollEnabled = true;
            
            break;
        }
        case RefreshStatePulling:
        {
            [UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            }];
            
            break;
        }
        case RefreshStateRefreshing:
        {
            if (self.viewDirection == CHRefreshDirectionHorizontal) {
                [self.scrollView setContentOffset:CGPointMake(-self.width, 0) animated:NO];
            } else {
                [self.scrollView setContentOffset:(CGPointMake(0, -self.height)) animated:NO];
            }
            self.scrollView.scrollEnabled = NO;
            break;
        }
        default:
            break;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.viewDirection == CHRefreshDirectionHorizontal) {
        self.frame = CGRectMake(-CHRefreshViewHeight, 0, CHRefreshViewHeight, SCREEN_HEIGHT);
    }else{
        self.frame = CGRectMake(0, -CHRefreshViewHeight, SCREEN_WIDTH, CHRefreshViewHeight);
    }
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (self.viewDirection == CHRefreshDirectionHorizontal) {
        self.x = -CHRefreshViewHeight;
    }else{
        self.y = -CHRefreshViewHeight;
    }
    
}
- (void)dealloc{
    [self endRefreshing];
}
/**
 *  返回头部对象
 *  @return
 */
+ (CHRefreshHeaderView*) headerView{
    CHRefreshHeaderView *headerView = [[CHRefreshHeaderView alloc]initWithFrame:CGRectMake(-CHRefreshViewHeight, 0, CHRefreshViewHeight, SCREEN_HEIGHT)];
    return headerView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.hidden) {
        return;
    }
    
    //如果当前不是刷新状态
    if (self.State == RefreshStateRefreshing) return;
    
    //监听到的是contentOffset
    if (![keyPath  isEqualToString: CHRefreshContentSize]) return;
    
    // 拿到当前contentoffset的y值
    if (self.viewDirection == CHRefreshDirectionHorizontal) {
        CGFloat currentOffsetY = self.scrollView.contentOffset.x;
        CGFloat happenOffsetY = -self.scrollViewOriginalInset.left;

        if (currentOffsetY >= happenOffsetY) {
            return;
        }
        
        // 根据scrollview 滑动的位置设置当前状态
        if (self.scrollView.dragging) {
            CGFloat normal2pullingOffsetY = happenOffsetY - CHRefreshViewHeight;
            if (self.State == RefreshStateNormal && currentOffsetY < normal2pullingOffsetY ){
                self.State = RefreshStatePulling;
            } else if (self.State == RefreshStatePulling && currentOffsetY >= normal2pullingOffsetY){
                self.State = RefreshStateNormal;
            }
            
        } else if (self.State == RefreshStatePulling){
            self.State = RefreshStateRefreshing;
        }
    } else {
        CGFloat currentOffsetY = self.scrollView.contentOffset.y;
        CGFloat happenOffsetY  = -self.scrollViewOriginalInset.top;
        
        if (currentOffsetY >= happenOffsetY) {
            return;
        }
        // 根据scrollview 滑动的位置设置当前状态
        if (self.scrollView.dragging) {
            CGFloat normal2pullingOffsetY  = happenOffsetY - CHRefreshViewHeight;
            if (self.State == RefreshStateNormal && currentOffsetY < normal2pullingOffsetY) {
                self.State = RefreshStatePulling;
            } else if (self.State == RefreshStatePulling && currentOffsetY >= normal2pullingOffsetY){
                self.State = RefreshStateNormal;
            }
            
        } else if (self.State == RefreshStatePulling) {
            self.State = RefreshStateRefreshing;
        }
    }

    
    
}






@end
