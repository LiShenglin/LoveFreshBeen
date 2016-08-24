//
//  CHRefreshBase.m
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHRefreshBase.h"

@implementation CHRefreshBase
- (instancetype)init{
    if (self = [super init]) {
        self.viewDirection = CHRefreshDirectionHorizontal;
        self.backgroundColor = [UIColor clearColor];
        
        //初始化箭头
          UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        arrowImage.image = [UIImage imageNamed:@"loading_1"];
        //添加图片
        NSMutableArray *imgArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 8; i++) {
            i++;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld",i]];
            [imgArray addObject:image];
        }
        arrowImage.animationImages = imgArray;
        arrowImage.animationDuration = 0.5;
        arrowImage.animationRepeatCount = MAXFLOAT;
        [self addSubview:arrowImage];
        self.arrowImage = arrowImage;
        
        if (self.viewDirection == CHRefreshDirectionHorizontal) {
            self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        } else {
            self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置箭头和菊花居中
    if(self.viewDirection == CHRefreshDirectionHorizontal){
        self.arrowImage.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 0.4);
    }else{
        self.arrowImage.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    }
}

//刷新视图重绘
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.State == WillRefreshing) {
        self.State = RefreshStateRefreshing;
    }
}

- (void)setState:(CHRefreshState)state{
    if (self.State == self.oldState) return;
    
    switch (state) {
            // 普通状态时 隐藏那个菊花
        case RefreshStateNormal:
            [self.arrowImage stopAnimating];
            break;
            // 释放刷新状态
        case RefreshStatePulling:
            break;
            // 正在刷新状态 1隐藏箭头 2显示菊花 3回调
        case RefreshStateRefreshing:
            [self.arrowImage startAnimating];
            //执行刷新回调
            if (self.beginRefreshingCallback) {
                self.beginRefreshingCallback();
            }
            
        default:
            break;
    }
}

#pragma mark -- 让子类重写的方法

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    //移除旧的父控件
    if(self.superview !=nil){
        [self.superview removeObserver:self forKeyPath:CHRefreshContentOffset];
    }
    //新的父控件添加监听器
    if (newSuperview !=nil) {
        [newSuperview addObserver:self forKeyPath:CHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        CGRect rect = self.frame;
        if (self.viewDirection == CHRefreshDirectionHorizontal) {
            rect.size.height = newSuperview.frame.size.height;
            rect.origin.y =0;
            self.frame = rect;
        }else{
            rect.size.width = newSuperview.frame.size.width;
            rect.origin.x = 0 ;
            self.frame = rect;
        }
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
}
//是否正在刷新
- (BOOL)isRefresh{
    return (self.State == RefreshStateRefreshing);
}

//开始刷新
- (void)beginRefreshing{
    if (self.window !=nil) {//在当前界面
        self.State = RefreshStateRefreshing;
    }else{//没在当前界面
        self.State = WillRefreshing;
        [super setNeedsDisplay];
    }
}

//结束刷新
- (void)endRefreshing{
    if (self.State == RefreshStateNormal)return;
    CGFloat delayInSeconds = 0.3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.State = RefreshStateNormal;
    });
    
    
}

@end
