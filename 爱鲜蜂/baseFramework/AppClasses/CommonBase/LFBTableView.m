
//
//  LFBTableView.m
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "LFBTableView.h"

@implementation LFBTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    if ([view isKindOfClass:[UIControl class]]) {//优先响应按钮的点击
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}


@end
