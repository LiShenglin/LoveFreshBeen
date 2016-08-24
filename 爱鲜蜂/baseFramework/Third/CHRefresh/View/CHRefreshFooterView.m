//
//  CHRefreshFooterView.m
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHRefreshFooterView.h"

@interface CHRefreshFooterView()
@property (nonatomic,assign)NSInteger lastRefreshCount;
@end
@implementation CHRefreshFooterView
//重写刷新状态
-(void)setState:(CHRefreshState)State{
    self.oldState = State;
    
   
    switch (self.State) {
            //普通状态
        case RefreshStateNormal:
        {if(self.oldState == RefreshStateRefreshing){
    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            
    [UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
       UIEdgeInsets inset = self.scrollView.contentInset;
        inset.bottom = self.scrollViewOriginalInset.bottom;
        self.scrollView.contentInset = inset;
    }];
        }else{
                [UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            
            CGFloat deltaH = [self heightForContentBreakView];
            NSInteger currentCount = [self totalDataCountInScrollView];
            
            if (RefreshStateRefreshing == self.oldState && deltaH > 0  && currentCount != self.lastRefreshCount) {
                if (self.viewDirection == CHRefreshDirectionHorizontal){
                    CGPoint offset = self.scrollView.contentOffset;
                    offset.x = self.scrollView.contentOffset.x - self.width + SCREEN_WIDTH;
                    [self.scrollView setContentOffset:offset animated:YES];
                } else {
                    CGPoint offset = self.scrollView.contentOffset;
                    offset.y = self.scrollView.contentOffset.y;
                    self.scrollView.contentOffset = offset;
                }
            }
            break;
        }
            
            //释放加载更多
        case RefreshStatePulling:
        {[UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            }];
            break;}
            
            //正在加载更多
        case RefreshStateRefreshing:
        {if(self.viewDirection == CHRefreshDirectionHorizontal){
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width-SCREEN_WIDTH+self.width, 0) animated:YES];
            } else {
                self.lastRefreshCount = [self totalDataCountInScrollView];
                [UIView animateWithDuration:CHRefreshSlowAnimationDuration animations:^{
                    CGFloat bottom = self.height + self.scrollViewOriginalInset.bottom;
                    CGFloat deltaH = [self heightForContentBreakView];
                    if (deltaH < 0){
                        bottom = bottom - deltaH;
                    }
                    UIEdgeInsets inset = self.scrollView.contentInset;
                    inset.bottom = bottom;
                    self.scrollView.contentInset = inset;
                }];
            }
        
            break;
        }
        default:
            
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.superview != nil) {
        [self.superview removeObserver:self forKeyPath:CHRefreshContentSize context:nil];
    
    }
    if (newSuperview != nil) {
        //监听contentSize
        [newSuperview addObserver:self forKeyPath:CHRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        //重新调整frame
        [self resetFrameWithContentSize];
        
    }
}
//接收监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.hidden) return;
    
    // 这里分两种情况 1.contentSize 2.contentOffset
    
    if ([CHRefreshContentSize isEqualToString: keyPath]){
        [self resetFrameWithContentSize];
    } else if ([CHRefreshContentOffset isEqualToString:keyPath]) {
        // 如果不是刷新状态
        if (self.State == RefreshStateRefreshing){
            return;
        }
        
        if (self.viewDirection == CHRefreshDirectionHorizontal) {
            
            CGFloat currentOffsetX = self.scrollView.contentOffset.x;
            CGFloat happenOffsetX = [self happenOffsetX];
            
            if (currentOffsetX <= happenOffsetX) {
                return;
            }
            
            if (self.scrollView.dragging) {
                CGFloat normal2pullingOffsetY =  happenOffsetX + self.width;
                if (self.State == RefreshStateNormal && currentOffsetX > normal2pullingOffsetY){
                    self.State = RefreshStatePulling;
                } else if (self.State == RefreshStatePulling && currentOffsetX <= normal2pullingOffsetY) {
                    self.State = RefreshStateNormal;
                }
            } else if (self.State == RefreshStatePulling) {
                self.State = RefreshStateRefreshing;
            }
        } else {
            CGFloat currentOffsetY = self.scrollView.contentOffset.y;
            CGFloat happenOffsetY = [self happenOffsetX];
            
            if (currentOffsetY <= happenOffsetY) {
                return;
            }
            
            if (self.scrollView.dragging) {
                CGFloat normal2pullingOffsetY =  happenOffsetY + self.frame.size.height;
                if (self.State == RefreshStateNormal && currentOffsetY > normal2pullingOffsetY) {
                    self.State = RefreshStatePulling;
                } else if (self.State == RefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
                    self.State = RefreshStateNormal;
                }
            } else if (self.State == RefreshStatePulling) {
                self.State = RefreshStateRefreshing;
            }
        }
    }


}

#pragma mark -- 相关工具
/**
 *  重新设置frame
 */
- (void)resetFrameWithContentSize{
    if(self.viewDirection == CHRefreshDirectionHorizontal){
        CGFloat contentHeight = self.scrollView.contentSize.width;
        CGFloat scrollHeight = self.scrollView.width  - self.scrollViewOriginalInset.left - self.scrollViewOriginalInset.right;
        CGRect rect = self.frame;
        rect.origin.x =  contentHeight > scrollHeight ? contentHeight : scrollHeight;
        self.frame = rect;
        
    }else{
        CGFloat contentHeight = self.scrollView.contentSize.height;
        CGFloat scrollHeight = self.scrollView.height  - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
        
        CGRect rect = self.frame;
        rect.origin.y =  contentHeight > scrollHeight ? contentHeight : scrollHeight;
        self.frame = rect;
    }
}

- (CGFloat)heightForContentBreakView{
    if (self.viewDirection == CHRefreshDirectionHorizontal) {
        CGFloat h = self.scrollView.width - self.scrollViewOriginalInset.right - self.scrollViewOriginalInset.left;
        return self.scrollView.contentSize.width - h;
    } else {
        CGFloat h = self.scrollView.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
        return self.scrollView.contentSize.height - h;
    }
}

- (CGFloat)happenOffsetX{
    if (self.viewDirection == CHRefreshDirectionHorizontal) {
        
        CGFloat deltaH = [self heightForContentBreakView ];
        
        if (deltaH > 0) {
            return   deltaH - self.scrollViewOriginalInset.left;
        } else {
            return  -self.scrollViewOriginalInset.left;
        }
        
    }else{
        CGFloat deltaH = [self heightForContentBreakView ];
        
        if (deltaH > 0) {
            return   deltaH - self.scrollViewOriginalInset.top;
        } else {
            return  -self.scrollViewOriginalInset.top;
        }
    }
}

/**
 获取cell的总个数
 */
- (NSInteger)totalDataCountInScrollView{
    NSInteger totalCount = 0;
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        
        for (NSInteger i = 0 ; i <  tableView.numberOfSections ; i++){
            
            totalCount = totalCount + [tableView numberOfRowsInSection:i];
        }
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView*)self.scrollView;
        
        for (NSInteger i = 0 ; i < [collectionView numberOfSections] ; i++){
            totalCount = totalCount + [collectionView numberOfItemsInSection:i];
        }
    }
    return totalCount;
}
- (void)dealloc{
    [self endRefreshing];
}

@end
