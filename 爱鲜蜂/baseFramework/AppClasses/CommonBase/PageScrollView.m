//
//  PageScrollView.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "PageScrollView.h"
typedef void(^ImageClick)(NSInteger index);
@interface PageScrollView ()<UIScrollViewDelegate>
@property(nonatomic,assign)NSInteger imageViewMaxCount;
@property(nonatomic,weak)UIScrollView *imageScrollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,weak)NSTimer *timer;
@property(nonatomic,weak)UIImage *placeHolderImage;
@property(nonatomic,weak) ImageClick imageClick;
@end
@implementation PageScrollView
-(void)setHeadData:(HomeHeadData *)headData{
    _headData = headData;
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (headData.focus.count>0) {
        self.pageControl.numberOfPages = headData.focus.count;
        self.pageControl.currentPage = 0;
        //更新广告内容
        [self updatePageScrollView];
        //开启监听器
        [self startTimer];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //配置图片滚动器
        [self buildImageScrollView];
        //配置分页控制器
        [self buildPageControl];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(UIImage*)placeholder focusImageViewClick:(void(^)(NSInteger index))focusImageViewClick{
    
    if (self = [super init]) {
        self.imageViewMaxCount = 3;
        self.placeHolderImage = placeholder;
        self.imageClick = focusImageViewClick;
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageScrollView.frame = self.bounds;
    self.imageScrollView.contentSize = CGSizeMake(self.imageViewMaxCount*self.imageScrollView.width, 0);
    
    for (NSInteger i =0; i < self.imageViewMaxCount; i++) {
        UIImageView * imageView = self.imageScrollView.subviews[i];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(i *self.imageScrollView.width, 0, self.imageScrollView.width, self.imageScrollView.height);
    }
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.imageScrollView.width - pageW;
    CGFloat pageY = self.imageScrollView.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    [self updatePageScrollView];
    
}

#pragma mark -- 构建分页滑动容器
//搭建滑动器
- (void)buildImageScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    self.imageScrollView = scrollView;
    [self addSubview:scrollView];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        [self.imageScrollView addSubview:imageView];
    }
    
}
//搭建分页
- (void)buildPageControl{
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    pageControl.hidesForSinglePage = YES;
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_normal"]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_selected"]];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark -- 滚动广告更新内容 和监听器开发方法
- (void)updatePageScrollView{
    for (NSInteger i = 0; i < self.imageScrollView.subviews.count; i++) {
        UIImageView * imageView = self.imageScrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if (i == 0){
            index--;
        } else if (2 == i) {
            index++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        
        imageView.tag = index;
        if (self.headData.focus.count>0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.headData.focus[index].img] placeholderImage:self.placeHolderImage];
        }
    }
    self.imageScrollView.contentOffset = CGPointMake(self.imageScrollView.width, 0);
}
- (void)startTimer{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark -- 所有的监听执行方法
//tap点击按钮,传进block告诉外界点击了哪个图片
- (void)imageViewClick:(UITapGestureRecognizer*)tap{
    if (self.imageClick != nil) {
        self.imageClick(tap.view.tag);
    }
}
//下一页
- (void)next{
    [self.imageScrollView setContentOffset:CGPointMake(2.0*self.imageScrollView.frame.size.width, 0) animated:true];
}
#pragma mark -- 滚动器的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (NSInteger i = 0 ; i<self.imageScrollView.subviews.count;i++) {
        UIImageView * imageView = self.imageScrollView.subviews[i];
        CGFloat distance = fabs(imageView.x - scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updatePageScrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updatePageScrollView];
}



@end
