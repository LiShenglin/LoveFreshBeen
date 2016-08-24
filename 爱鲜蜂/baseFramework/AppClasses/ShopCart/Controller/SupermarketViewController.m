//
//  SupermarketViewController.m
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "SupermarketViewController.h"
#import "LFBTableView.h"
#import "ProductsViewController.h"
#import "CategoryCell.h"
@interface SupermarketViewController()<UITableViewDelegate,UITableViewDataSource,ProductsViewControllerDelegate>
//商店超市全部数据
@property(nonatomic,strong)SupermarketResouce *supermarketData;

@property(nonatomic,strong)LFBTableView *categoryTableView;
@property(nonatomic,strong)ProductsViewController *productVC;

@property(nonatomic,assign)BOOL categoryTableViewIsLoadFinish;
@property(nonatomic,assign)BOOL productTableViewIsLoadFinish;

@end

@implementation SupermarketViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.categoryTableViewIsLoadFinish = NO;
    self.productTableViewIsLoadFinish = NO;
    //添加通知
    [self addNotification];
    //展示指示器
    //[self showProgressHUD];
    //创建分类列表
    [self bulidCategoryTableView];
    //创建商品列表
    [self bulidProductsTableView];
    //加载商品
    [self loadSupermarketData];
}

- (void)dealloc{
    [AINotiCenter removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.productVC.prodcutsTableView != nil) {
        [self.productVC.prodcutsTableView reloadData];
    }
    
}
#pragma mark -- 系列方法
//添加通知
- (void)addNotification{
    [AINotiCenter addObserver:self selector:@selector(shopCarBuyProductNumberDidChange) name:LFBShopCarBuyPriceDidChangeNotification object:nil];
}
- (void)shopCarBuyProductNumberDidChange{
    if (self.productVC.prodcutsTableView != nil) {
        [self.productVC.prodcutsTableView reloadData];
    }
}
//展示指示器
- (void)showProgressHUD{
    [ProgressHUBManager setBackgroundColor:[UIColor grayColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!ProgressHUBManager.isVisible) {
        [ProgressHUBManager showWithStatus:@"正在加载中"];
    }
}
#pragma mark -- 创建UI
//创建分类列表
- (void)bulidCategoryTableView {
    self.categoryTableView = [[LFBTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.25, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.categoryTableView.backgroundColor = LFBGlobalBackgroundColor;
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.categoryTableView.showsVerticalScrollIndicator = NO;
    self.categoryTableView.showsHorizontalScrollIndicator = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.categoryTableView.hidden = YES;
    [self.view addSubview:self.categoryTableView];
}
//创建商品列表
- (void)bulidProductsTableView{
    self.productVC = [[ProductsViewController alloc]init];
    self.productVC.delegate = self;
    self.productVC.view.hidden = YES;
    [self addChildViewController:self.productVC];
    [self.view addSubview:self.productVC.view];
    
    __weak typeof(self)weakSelf = self;
    self.productVC.refreshUpPull = ^{
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SupermarketTool loadSupermarketData:^(SupermarketResouce *supermarket, NSError *error) {
                if (error == nil) {
                    weakSelf.supermarketData = supermarket;
                    weakSelf.productVC.supermarketResouce = supermarket;
                    [weakSelf.productVC.prodcutsTableView.mj_header endRefreshing];
                    [weakSelf.categoryTableView reloadData];
                    [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                }
            }];
        });
    };
}
//加载商品
- (void)loadSupermarketData{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SupermarketTool loadSupermarketData:^(SupermarketResouce *supermarket, NSError *error) {
            
            weakSelf.supermarketData = supermarket;
            [weakSelf.categoryTableView reloadData];
            [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            weakSelf.productVC.supermarketResouce = supermarket;
            weakSelf.categoryTableViewIsLoadFinish = YES;
            weakSelf.categoryTableViewIsLoadFinish = YES;
            weakSelf.categoryTableView.hidden = NO;
            weakSelf.productVC.prodcutsTableView.hidden = NO;
            weakSelf.productVC.view.hidden = NO;
            weakSelf.categoryTableView.hidden = NO;
            [ProgressHUBManager dismiss];
            weakSelf.view.backgroundColor = LFBGlobalBackgroundColor;

            
            if (error == nil) {
                weakSelf.supermarketData = supermarket;
                [weakSelf.categoryTableView reloadData];
                [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                weakSelf.productVC.supermarketResouce = supermarket;
                weakSelf.categoryTableViewIsLoadFinish = YES;
                weakSelf.categoryTableViewIsLoadFinish = YES;
                if (weakSelf.categoryTableViewIsLoadFinish && weakSelf.productTableViewIsLoadFinish) {
                    weakSelf.categoryTableView.hidden = NO;
                    weakSelf.productVC.prodcutsTableView.hidden = NO;
                    weakSelf.productVC.view.hidden = NO;
                    weakSelf.categoryTableView.hidden = NO;
                    [ProgressHUBManager dismiss];
                    weakSelf.view.backgroundColor = LFBGlobalBackgroundColor;
                }
            }
        }];
    });
}

#pragma mark -- 分类的tableView代理实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.supermarketData.categories.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell * cell = [CategoryCell cellWithTabelView:tableView];
    cell.categorie = self.supermarketData.categories[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.productVC != nil) {
        self.productVC.categortsSelectedIndexPath = indexPath;
    }
}

#pragma mark -- ProdcutsViewControllerDelegate代理方法
-(void)didEndDisplayingHeaderView:(NSInteger)section{
    //当前产品列表对应组滚动结束，则让分类跳到下一组
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:(section+1) inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}
-(void)willDisplayHeaderView:(NSInteger)section{
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}



@end
