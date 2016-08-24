//
//  HomeHeadView.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//
/**
 *  首页头部广告、和热点按钮
 */
#import <UIKit/UIKit.h>
@class PageScrollView;
@class HotView;
@class HomeHeadView;
@protocol HomeHeadViewDelegate <NSObject>
@optional
//广告焦点图点击
- (void)tableHeadView:(HomeHeadView *)headView focusImageViewClick:(NSInteger)index;
//图标按钮点击
- (void)tableHeadView:(HomeHeadView *)headView iconClick:(NSInteger)index;
@end

@interface HomeHeadView : UIView
@property(nonatomic,strong)PageScrollView * pageScrollView;
@property(nonatomic,strong)HotView *hotView;
@property(nonatomic,weak)id<HomeHeadViewDelegate>delegate;
@property(nonatomic,assign)CGFloat tableHeadViewHeight;

@property(nonatomic,strong)HomeHeadData * headData;
@end
