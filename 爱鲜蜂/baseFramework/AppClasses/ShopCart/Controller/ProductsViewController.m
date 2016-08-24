//
//  ProductsViewController.m
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ProductsViewController.h"
#import "LFBTableView.h"
#import "SupermarketHeadView.h"
#import "ProductCell.h"
#import "LFBRefreshHeader.h"
/**
 *  1\定义tableView
    2\数据模型
    3、其他
 
    4、协议
 */
static NSString *HeadViewIdentifier = @"SupermarketHeadView";
@interface ProductsViewController() <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,assign)CGFloat lastOffsetY;
@property(nonatomic,assign)BOOL isScrollDown;

@end

@implementation ProductsViewController
#pragma mark -- 模型数值设置
//从外界加载商品，然后设置商品数组
-(void)setGoodsArr:(NSArray<NSArray*>*)goodsArr{
    _goodsArr = goodsArr;
    [self.prodcutsTableView reloadData];
}
- (void)setSupermarketResouce:(SupermarketResouce *)supermarketResouce{
    _supermarketResouce = supermarketResouce;
    //把所有商品重新放进二维数组
    self.goodsArr = [SupermarketTool searchCategoryMatchProducts:supermarketResouce];
    
}
- (void)setCategortsSelectedIndexPath:(NSIndexPath *)categortsSelectedIndexPath{
    _categortsSelectedIndexPath = categortsSelectedIndexPath;
    
    [self.prodcutsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:categortsSelectedIndexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark -- 重写构造函数和自动布局
- (void)viewDidLoad{
    [super viewDidLoad];
    [AINotiCenter addObserver:self selector:@selector(shopCarBuyProductNumberDidChange) name:LFBShopCarBuyProductNumberDidChangeNotification object:nil];
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, 0, SCREEN_WIDTH * 0.75, SCREEN_HEIGHT - 64)];
    //创建产品tableView
    [self buildProductsTabelView];
}

- (void)dealloc{
    [AINotiCenter removeObserver:self];
}

- (void)buildProductsTabelView {
    self.prodcutsTableView = [[LFBTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.prodcutsTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.prodcutsTableView.backgroundColor = LFBGlobalBackgroundColor;
    self.prodcutsTableView.delegate = self;
    self.prodcutsTableView.dataSource = self;
    [self.prodcutsTableView registerClass:[SupermarketHeadView class] forHeaderFooterViewReuseIdentifier:HeadViewIdentifier];
    self.prodcutsTableView.tableFooterView = [self buildProductsTableViewTableFooterView];
    
    LFBRefreshHeader *headView = [LFBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefreshUpPull)];
    self.prodcutsTableView.mj_header = headView;
    [self.view addSubview:self.prodcutsTableView];
}

- (UIImageView*)buildProductsTableViewTableFooterView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.prodcutsTableView.width, 70)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"v2_common_footer"];
    return imageView;
}

#pragma mark -- 刷新
- (void)startRefreshUpPull{
    if (self.refreshUpPull != nil) {
        [self refreshUpPull];
    }
}
- (void)shopCarBuyProductNumberDidChange {
    [self.prodcutsTableView reloadData];
}


#pragma mark -- 表格数据源和代理设置
//有多少行
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.supermarketResouce.categories.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//每组多少行
    if (self.goodsArr.count > 0) {
        return self.goodsArr[section].count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductCell *cell = [ProductCell cellWithTableView:tableView];
    Good *good = self.goodsArr[indexPath.section][indexPath.row];
    cell.good = good;
    
    __weak typeof(self)weakSelf = self;
    cell.addProductClick = ^(UIImageView * imageView){
        [weakSelf addProductsAnimation:imageView];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SupermarketHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadViewIdentifier];
    if (self.supermarketResouce.categories.count > 0 && self.supermarketResouce.categories[section].name != nil) {
        headView.titleLabel.text = self.supermarketResouce.categories[section].name;
    }
    return headView;
}
//将要显示头部组视图
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    if ([self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] && !self.isScrollDown) {
        [self.delegate willDisplayHeaderView:section];
    }
    
}
//已经结束显示头部组视图
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && self.isScrollDown) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CHLog(@"选中并跳转进商品");
}

#pragma mark -- 滚动区域代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.animationLayers.count > 0) {
        //每次滚动就把第一个而layer层隐藏
        CALayer * transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = YES;
    }
    //判断是否正在下滑
    self.isScrollDown = self.lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
}


@end
