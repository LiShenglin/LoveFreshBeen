//
//  CHRefreshBase.h
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRefreshConst.h"
// 控件的方向
typedef NS_ENUM(NSUInteger, CHRefreashDirection) {
    CHRefreshDirectionHorizontal,//水平
    CHRefreshDirectionVertical,//竖直
};
//控件的刷新状态
typedef NS_ENUM(NSUInteger, CHRefreshState) {
        RefreshStateNormal,               // 普通状态
        RefreshStatePulling,               // 松开就可以进行刷新的状态
        RefreshStateRefreshing,            // 正在刷新中的状态
        WillRefreshing
};
//控件的类型
typedef NS_ENUM(NSUInteger, CHRefreshViewType) {
        RefreshViewTypeHeader,             // 头部控件
        RefreshViewTypeFooter             // 尾部控件
};
//刷新回调的block
typedef void(^beginRefreshingBlock)();
@interface CHRefreshBase : UIView
//父控件
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,assign) UIEdgeInsets scrollViewOriginalInset;
//箭头图片
@property (nonatomic,weak) UIImageView *arrowImage;
//刷新后回调
@property (nonatomic,copy) beginRefreshingBlock beginRefreshingCallback;

//交给子类去实现和调用
@property (nonatomic,assign)CHRefreshState oldState;

//水平方向设置
@property (nonatomic,assign)CHRefreashDirection viewDirection;

@property (nonatomic,assign)CHRefreshState State;
//是否正在刷新
- (BOOL)isRefresh;
- (void)beginRefreshing;
- (void)endRefreshing;

@end
