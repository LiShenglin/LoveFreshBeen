//
//  HomeViewController.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadView.h"
#import "LFBCollectionView.h"
#import "MainTabBarController.h"
//广告焦点图加载
#import "HeadResoureTool.h"
#import "HomeHeadData.h"

//热门商品加载
#import "FreshHotTool.h"

#import "HomeCell.h"
#import "HomeCollectionHeaderView.h"
#import "HomeCollectionFooterView.h"

#import "LFBRefreshHeader.h"

#import "WebViewController.h"


@interface HomeViewController()<HomeHeadViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,strong)HomeHeadView *headView;
@property(nonatomic,strong)HomeHeadData *headData;
@property(nonatomic,strong)LFBCollectionView *collectionView;
@property(nonatomic,strong)NSArray<Good *> * freshHots;
@property(nonnull,strong)LFBRefreshHeader *freshHeader;
@property(nonatomic,assign)CGFloat lastContentOffsetY;

@end
@implementation HomeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self addHomeNotification];
    [self buildCollectionView];
    [self bulidTableHeadView];
    [self buildProessHud];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = LFBNavigationYellowColor;
    
    if (self.collectionView != nil) {
        [self.collectionView reloadData];
    }
//    发送通知搜索框销毁控制器
    
    
    
}

#pragma mark -- 创建UI
//创建头部广告和按钮
- (void)bulidTableHeadView{
    
    self.headView = [[HomeHeadView alloc]init];
    self.headView.delegate = self;
    __weak typeof(self)weakSelf = self;
    [HeadResoureTool loadHomeHeadData:^(HomeHeadData *data , NSError *error) {
        if (error == nil) {
            weakSelf.headView.headData = data;
            weakSelf.headData = data;
            
            [weakSelf.collectionView reloadData];
        }
    }];
    
    //直接加入头部
    [self.collectionView addSubview:self.headView];
    self.freshHeader.y -= 40;
    self.freshHeader.x -= self.view.width*0.4;
    [self.headView addSubview:self.freshHeader];
    //有点问题，位置不对- - - 另外
    //CHLog(@"freshheader --- %@",NSStringFromCGRect(self.freshHeader.frame));
    
    
    [FreshHotTool loadFreshHotData:^(NSArray<Good *> *HotData, NSError *error) {
        weakSelf.freshHots = HotData;
        [weakSelf.collectionView reloadData];
        weakSelf.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    }];
    
}


//创建collectionView
- (void)buildCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 5;
    //全局的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, HomeCollectionViewCellMargin , 0, HomeCollectionViewCellMargin);
    layout.headerReferenceSize = CGSizeMake(0, HomeCollectionViewCellMargin);
    
    self.collectionView = [[LFBCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = LFBGlobalBackgroundColor;
    

    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"homecell"];
    [self.collectionView registerClass:[HomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collectionView registerClass:[HomeCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    [self.view addSubview:self.collectionView];
    
    //创建自定义的头部刷新控件，并给collectionView 的头部刷新组件
    LFBRefreshHeader *freshHeader = [LFBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    freshHeader.gifView.frame = CGRectMake(0, 30, 100, 100);
    self.freshHeader = freshHeader;
    self.collectionView.mj_header = freshHeader;
    
}
- (void)buildProessHud{
    [ProgressHUBManager setBackgroundColor:[UIColor colorWithRed:240 green:240 blue:240 alpha:1.0]];
    [ProgressHUBManager setFont:[UIFont systemFontOfSize:16]];
    
}
#pragma mark -- 刷新事件
- (void)headRefresh{
    
    //self.headView.headData = nil;
    self.headData = nil;
    self.freshHots = nil;
    __block BOOL headDataLoadFinsih = NO;
    __block BOOL freshHotLoadFinish = NO;
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [HeadResoureTool loadHomeHeadData:^(HomeHeadData *data, NSError *error) {
            if (error == nil) {
                headDataLoadFinsih = YES;
                weakSelf.headView.headData = data;
                weakSelf.headData = data;
                if (headDataLoadFinsih && freshHotLoadFinish) {
                    [weakSelf.collectionView reloadData];
                    [weakSelf.collectionView.mj_header endRefreshing];
                }
            }
        }];
        
        [FreshHotTool loadFreshHotData:^(NSArray<Good *> *HotData, NSError *error) {
            freshHotLoadFinish = YES;
            weakSelf.freshHots = HotData;
            if (headDataLoadFinsih && freshHotLoadFinish) {
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView.mj_header endRefreshing];
            }
        }];

    });
}

- (void)dealloc{
    [AINotiCenter removeObserver:self];
}

#pragma mark -- 接收通知事件，处理通知事件
- (void)addHomeNotification{
    [AINotiCenter addObserver:self selector:@selector(homeTableHeadViewHeightDidChange:) name:HomeTableHeadViewHeightDidChange object:nil];
    
    
    [AINotiCenter addObserver:self selector:@selector(goodsInventoryProblem:) name:HomeGoodsInventoryProblem object:nil];
    [AINotiCenter addObserver:self selector:@selector(shopCarBuyProductNumberDidChange) name:LFBShopCarBuyPriceDidChangeNotification object:nil];
}
//头部高度变化
- (void)homeTableHeadViewHeightDidChange:(NSNotification*)noti{
    CGFloat top = [noti.object floatValue];
    self.collectionView.contentInset = UIEdgeInsetsMake(top, 0, NavigationH, 0);
    
    self.collectionView.contentOffset = CGPointMake(0, -(self.collectionView.contentInset.top));
    self.lastContentOffsetY = self.collectionView.contentOffset.y;
}

- (void)goodsInventoryProblem:(NSNotification*)noti{
    NSString *goodName = noti.object;
    if (goodName != nil) {
        [ProgressHUBManager showImage:[UIImage imageNamed:@"v2_orderSuccess"] status:[NSString stringWithFormat:@"%@  库存不足了\n先买这么多, 过段时间再来看看吧~",goodName]];
    }
}

//购物车数量变化，刷新collectionView
- (void)shopCarBuyProductNumberDidChange{
    //     [self.collectionView reloadData];
}

#pragma mark -- HomeHeadViewdelegate协议的方法
//广告焦点图点击方法
- (void)tableHeadView:(HomeHeadView *)headView focusImageViewClick:(NSInteger)index{
    if (self.headData.focus.count > 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FocusURL" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        WebViewController *webVc = [[WebViewController alloc] initWithNavTitle:self.headData.focus[index].name urlStr:array[index]];
        [self.navigationController pushViewController:webVc animated:YES];
    }
}
//icon按钮点击方法
- (void)tableHeadView:(HomeHeadView *)headView iconClick:(NSInteger)index{
    if (self.headData.icons.count > 0) {
        WebViewController *webVc = [[WebViewController alloc] initWithNavTitle:self.headData.icons[index].name urlStr:self.headData.icons[index].customURL];
        [self.navigationController pushViewController:webVc animated:YES];
    }
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.headData.activities.count <= 0 || self.freshHots.count <= 0 ) {
        return 0;
    }
    if (section == 0) {
        return self.headData.activities.count;
    }else if(section == 1){
        return self.freshHots.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homecell" forIndexPath:indexPath];
    if (self.headData.activities.count <= 0) {
        return cell;
    }
    
    if (indexPath.section == 0) {//横幅广告
        cell.activities = self.headData.activities[indexPath.row];
        
        
    }else if(indexPath.section == 1){//cell商品
        
        cell.good = self.freshHots[indexPath.row];
        
        __weak typeof(self)weakSelf = self;
        cell.addButtonClick = ^(UIImageView * imageView){
            [weakSelf addProductsAnimation:imageView];
        };
        
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.headData.activities.count <= 0 || self.freshHots.count <= 0) {
        return 0;
    }
    return 2;
}
//每个cell的size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    if (indexPath.section == 0) {
        itemSize = CGSizeMake(SCREEN_WIDTH - HomeCollectionViewCellMargin * 2, 140);
    }else if(indexPath.section == 1){
        itemSize = CGSizeMake((SCREEN_WIDTH - HomeCollectionViewCellMargin * 2) *0.5 - 4, 250);
    }
    return itemSize;
}

//组头部的size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin);
    }else if (section == 1){
        return CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin * 2);
    }
    return CGSizeZero;
}
//组的尾部size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin);
    }else if(section == 1){
        return CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin * 5);
    }
    return CGSizeZero;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1)) {
        return;
    };
    
    if (self.isAnimation) {
        [self startAnimation:cell offsetY:80 duration:1.0];
    }
    
}



//开启cell动画
- (void)startAnimation:(UIView*)view offsetY:(CGFloat)offsetY duration:(NSTimeInterval)duration{
    view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
}

//头部动画
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && self.headData != nil && self.freshHots != nil && _isAnimation) {
        [self startAnimation:view offsetY:60 duration:0.8];
    }
}
//头部的视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && kind == UICollectionElementKindSectionHeader ) {//头部
        HomeCollectionHeaderView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        return headView;
    }
    
    
    HomeCollectionFooterView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" withReuseIdentifier:@"footerView" forIndexPath:indexPath];
    
    if (indexPath.section == 1 && kind == UICollectionElementKindSectionFooter) {
        [footView showLabel];
        footView.tag = 100;
    }else{
        [footView hideLabel];
        footView.tag = 1;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreGoodsClick:)];
    [footView addGestureRecognizer:tap];
    return footView;
}

- (void)moreGoodsClick:(UITapGestureRecognizer*)tap{
    if (tap.view.tag == 100) {
        MainTabBarController * tabbarController = (MainTabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [tabbarController setSelectedIndex:1];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.animationLayers.count > 0) {
        CALayer * transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = true;
    }
    
    if (scrollView.contentOffset.y <= scrollView.contentSize.height) {
        self.isAnimation = self.lastContentOffsetY < scrollView.contentOffset.y;
        self.lastContentOffsetY = scrollView.contentOffset.y;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WebViewController *webVC = [[WebViewController alloc]initWithNavTitle:self.headData.activities[indexPath.row].name urlStr:self.headData.activities[indexPath.row].customURL];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        CHLog(@"点击产品进入详情页");
    }
}


@end
