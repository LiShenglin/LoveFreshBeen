//
//  HomeHeadView.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HomeHeadView.h"
#import "PageScrollView.h"
#import "HotView.h"
@interface HomeHeadView ()

@end
@implementation HomeHeadView
-(void)setTableHeadViewHeight:(CGFloat)tableHeadViewHeight{
    _tableHeadViewHeight = tableHeadViewHeight;
    //通知外界tableHeadView的高度发生了变化
    [AINotiCenter postNotificationName:HomeTableHeadViewHeightDidChange object:@(tableHeadViewHeight)];
    
    self.frame = CGRectMake(0, -tableHeadViewHeight, SCREEN_WIDTH, tableHeadViewHeight);
    
}
//设置模型
- (void)setHeadData:(HomeHeadData *)headData{
    _headData = headData;
    self.pageScrollView.headData = headData;
    
    self.hotView.headData = headData;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建分页滚动视图
        [self buildPageScrollView];
        //创建焦点按钮
        [self buildHotView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.pageScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.31);
    CGRect frame = self.hotView.frame;
    CGPoint hotPoint = CGPointMake(0, CGRectGetMaxY(self.pageScrollView.frame));
    frame = CGRectMake(hotPoint.x, hotPoint.y, frame.size.width, frame.size.height);
    self.hotView.frame = frame;
    //不断调整更新tableHeadViewHeight高度值
    self.tableHeadViewHeight = CGRectGetMaxY(self.hotView.frame);
}

#pragma mark -- 初始化子控件
- (void)buildPageScrollView{

    
    __weak typeof(self)weakSelf = self;
    PageScrollView *pageScrollView = [[PageScrollView alloc]initWithFrame:CGRectZero placeholder:[UIImage imageNamed:@"v2_placeholder_full_size"] focusImageViewClick:^(NSInteger index) {
        if (weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(tableHeadView:focusImageViewClick:)]) {
            [weakSelf.delegate tableHeadView:weakSelf focusImageViewClick:index];
        }
    }];
    self.pageScrollView = pageScrollView;
    [self addSubview:pageScrollView];
}

-(void)buildHotView{
    if (self.hotView != nil) {
        [self.hotView removeFromSuperview];
        self.hotView = nil;
    }
    
    __weak typeof(self)weakSelf = self;
    HotView * hotView = [[HotView alloc]initWithFrame:CGRectZero iconClick:^(NSInteger index) {
        if (weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(tableHeadView:iconClick:)]) {
            [weakSelf.delegate tableHeadView:weakSelf iconClick:index];
        }
    }];
    hotView.backgroundColor = [UIColor whiteColor];
    self.hotView = hotView;
    [self addSubview:hotView];
}






@end
