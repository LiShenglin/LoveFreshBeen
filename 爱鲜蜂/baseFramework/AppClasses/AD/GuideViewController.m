//
//  GuideViewController.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideCell.h"
static NSString *CellIdentifier = @"GuideCell";
@interface GuideViewController()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * imageNames;
@property(nonatomic,assign)BOOL isHiddenNextButton;
@property(nonatomic,strong)UIPageControl *pageControl;
@end
@implementation GuideViewController
-(NSArray *)imageNames{
    if(_imageNames == nil){
        _imageNames = [NSArray array];
    }
    return _imageNames;
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.imageNames = @[@"guide_40_1", @"guide_40_2", @"guide_40_3", @"guide_40_4"];
    CHLog(@"%ld",self.imageNames.count);
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [self buildCollectionView];
    [self buildPageControl];
}

- (void)buildCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0 ;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = ScreenBounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:ScreenBounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:CellIdentifier];
    [self.view addSubview:self.collectionView];
    
}
- (void)buildPageControl{
    self.pageControl.numberOfPages = self.imageNames.count;
    self.pageControl.currentPage = 0 ;
    [self.view addSubview:self.pageControl];
}

#pragma mark -- collectionView--代理和数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.newimage = [UIImage imageNamed:self.imageNames[indexPath.row]];
    
    
    if (indexPath.row != (self.imageNames.count -1)) {
        [cell setNextButtonHidden:YES];
    }
    
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    BOOL isShowNextBtn = scrollView.contentOffset.x == (self.imageNames.count - 1)*SCREEN_WIDTH;
    if (isShowNextBtn) {
        GuideCell *cell = (GuideCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(self.imageNames.count-1) inSection:0]];
        [cell setNextButtonHidden:NO];
        self.isHiddenNextButton = NO;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //不等于最后一个cell，当前下一步按钮阴藏了，偏移量大于最有一个，则显示下一步按钮
    if (scrollView.contentOffset.x != SCREEN_WIDTH * (self.imageNames.count - 1) && !self.isHiddenNextButton && scrollView.contentOffset.x > SCREEN_WIDTH * (self.imageNames.count - 2)) {
        GuideCell *cell = (GuideCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(self.imageNames.count - 1) inSection:0]];
        [cell setNextButtonHidden:YES];
        self.isHiddenNextButton = YES;
    }
    
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / SCREEN_WIDTH + 0.5);
    
}



@end
