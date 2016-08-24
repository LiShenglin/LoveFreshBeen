//
//  LFBCollectionView.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "LFBCollectionView.h"

@implementation LFBCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        //设置为不用延迟的话，无论滚动多快，都会把触摸事件传递给内部控件
        self.delaysContentTouches = NO;
        //让内容滚动的时候，依然保持触摸事件
        self.canCancelContentTouches = YES;
        
        UIView *wrapView = self.subviews.firstObject;
        //如果wrapView不为空，且是collectionView的所有cell的容器（该容器含有WrapperView字符串命名）
        if (wrapView != nil && [NSStringFromClass([wrapView class]) hasPrefix:@"WrapperView"]) {
            for(UIGestureRecognizer * gesture in wrapView.gestureRecognizers){
                if ([NSStringFromClass([gesture class]) containsString:@"DelayedTouchesBegan"]) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    
    if ([view isKindOfClass:[UIControl class]]) {//滚动的时候优先响应按钮的点击
        return true;
    }
    return [super touchesShouldCancelInContentView:view];
}


@end
