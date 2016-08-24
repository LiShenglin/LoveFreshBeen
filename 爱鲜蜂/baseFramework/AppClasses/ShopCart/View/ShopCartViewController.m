//
//  ShopCartViewController.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ReceiptAddressView.h"
#import "ShopCartCommentsView.h"
#import "LFBTableView.h"
#import "ShopCartSupermarketTableFooterView.h"
#import "ProgressHUBManager.h"
#import "UIBarButtonItem+DownUp.h"
#import "ShopCartMarkerView.h"
#import "ShopCartCell.h"

#import "OrderPayWayViewController.h"
#import "BaseNavigationController.h"

#define userShopCar [UserShopCarTool shareUserShopCarTool]
@interface ShopCartViewController ()<ShopCartSupermarketTableFooterViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *shopImageView;
@property(nonatomic,strong)UILabel *emptyLabel;
@property(nonatomic,strong)UIButton * emptyButton;
@property(nonatomic,strong)ReceiptAddressView * receiptAdressView;
@property(nonatomic,strong)UIView * tableHeadView;
@property(nonatomic,strong)UILabel *signTimeLabel;
@property(nonatomic,strong)UILabel *reserveLabel;
@property(nonatomic,strong)UIPickerView *signTimePickerView;
@property(nonatomic,strong)ShopCartCommentsView *commentsView;
@property(nonatomic,strong)LFBTableView *supermaketTableView;
@property(nonatomic,strong)ShopCartSupermarketTableFooterView *tableFooterView;
@property(nonatomic,strong)ShopCartMarkerView *markerView;
@property(nonatomic,assign)BOOL isFirstLoadData;

@end

@implementation ShopCartViewController
#pragma mark -- 懒加载
-(UIImageView *)shopImageView{
    if (_shopImageView == nil) {
        _shopImageView = [[UIImageView alloc] init];
    }
    return _shopImageView;
}
-(UILabel *)emptyLabel{
    if (_emptyLabel == nil) {
        _emptyLabel = [[UILabel alloc]init];
    }
    return _emptyLabel;
}
-(UIButton *)emptyButton{
    if (_emptyButton == nil) {
        _emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _emptyButton;
}
-(ReceiptAddressView *)receiptAdressView{
    if (_receiptAdressView == nil) {
        _receiptAdressView = [[ReceiptAddressView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 70) modifyButtonClickCallBack:^{
            
        }];
     //   _receiptAdressView.backgroundColor = [UIColor redColor];
    }
    return _receiptAdressView;
}

- (UIView *)tableHeadView{
    if (_tableHeadView == nil) {
        _tableHeadView = [[UIView alloc]init];
    }
    return _tableHeadView;
}
- (UILabel *)signTimeLabel{
    if (_signTimeLabel == nil) {
        _signTimeLabel = [[UILabel alloc]init];
    }
    return _signTimeLabel;
}
- (UILabel *)reserveLabel{
    if (_reserveLabel == nil) {
        _reserveLabel = [[UILabel alloc]init];
    }
    return _reserveLabel;
}
- (ShopCartCommentsView *)commentsView{
    if (_commentsView == nil) {
        _commentsView = [[ShopCartCommentsView alloc]initWithFrame:CGRectMake(0, 200, self.view.width, ShopCartRowHeight)];
    }
    return _commentsView;
}
-(LFBTableView *)supermaketTableView{
    if (_supermaketTableView == nil) {
        _supermaketTableView = [[LFBTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStylePlain];
    }
    return _supermaketTableView;
}
-(ShopCartMarkerView *)markerView{
    if (_markerView == nil) {
        _markerView = [[ShopCartMarkerView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 60)];
    }
    return _markerView;
}
-(ShopCartSupermarketTableFooterView *)tableFooterView{
    if (_tableFooterView == nil) {
        _tableFooterView = [[ShopCartSupermarketTableFooterView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50)];
    }
    return _tableFooterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNSNotification];
    [self buildNavigationItem];
    [self buildEmptyUI];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    __weak typeof(self)weakSelf = self;
    if ([userShopCar isEmpty]) {
        [self showShopCarEmptyUI];
        [self hideProductView];
    }else{
        
        if (![ProgressHUBManager isVisible]) {
            [ProgressHUBManager setBackgroundColor:[UIColor colorWithRed:230 green:230 blue:230 alpha:1.0]];
            [ProgressHUBManager showWithStatus:@"正在加载商品信息"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf showProductView];
            [ProgressHUBManager dismiss];
        });
    }
    
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -- 添加监听KVO action
- (void)addNSNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarProductsDidRemove) name:LFBShopCarDidRemoveProductNSNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBuyPriceDidChange) name:LFBShopCarBuyPriceDidChangeNotification object:nil];
}

- (void)shopCarProductsDidRemove{
    if ([userShopCar isEmpty]) {
        [self showShopCarEmptyUI];
    }
    
    [self.supermaketTableView reloadData];
}

- (void)shopCarBuyPriceDidChange{
    self.tableFooterView.priceLabel.text = [userShopCar getAllProductPrice];
}

#pragma mark -- buildUI
- (void)buildNavigationItem{
    self.navigationItem.title = @"购物车";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"v2_goback"] target:self action:@selector(leftNavigitonItemClick)];
}

- (void)buildEmptyUI{
   // self.shopImageView = [[UIImageView alloc]init];
    self.shopImageView.image = [UIImage imageNamed:@"v2_shop_empty"];
    self.shopImageView.contentMode = UIViewContentModeCenter;
    self.shopImageView.frame = CGRectMake((self.view.width - self.shopImageView.width)*0.5, self.view.height * 0.25, self.shopImageView.width, self.shopImageView.height);
    self.shopImageView.hidden = YES;
    [self.view addSubview:self.shopImageView];
    
   // self.emptyLabel = [[UILabel alloc]init];
    self.emptyLabel.text = @"亲,购物车空空的耶~赶紧挑好吃的吧";
    self.emptyLabel.textColor = [UIColor darkGrayColor];
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyLabel.frame = CGRectMake(0, CGRectGetMaxX(self.shopImageView.frame) + 55, self.view.width, 50);
    self.emptyLabel.font = [UIFont systemFontOfSize:16];
    self.emptyLabel.hidden = YES;
    [self.view addSubview:self.emptyLabel];
    
    //self.emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emptyButton.frame = CGRectMake((self.view.width - 150)*0.5, CGRectGetMaxY(self.emptyLabel.frame) + 15, 150, 30);
    [self.emptyButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"去逛逛" forState:UIControlStateNormal];
    [self.emptyButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.emptyButton addTarget:self action:@selector(leftNavigitonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.emptyButton.hidden = YES;
    [self.view addSubview:self.emptyButton];
    
}
- (void)showShopCarEmptyUI{
    self.shopImageView.hidden = NO;
    self.emptyButton.hidden = NO;
    self.emptyLabel.hidden = NO;
    self.supermaketTableView.hidden = YES;
}
- (void)showProductView{
    [self buildTableHeadView];
    
    [self buildSupermarketTableView];
    
    [self.supermaketTableView reloadData];
    
    if (!self.isFirstLoadData) {
        [self buildTableHeadView];
        
        [self buildSupermarketTableView];
        
        self.isFirstLoadData = YES;
        
    }
    self.tableHeadView.hidden = NO;
    self.tableFooterView.hidden = NO;
    self.supermaketTableView.hidden = NO;
    
}
- (void)hideProductView{
    self.tableHeadView.hidden = YES;
    self.tableFooterView.hidden = YES;
    self.supermaketTableView.hidden = YES;
}

- (void)buildSupermarketTableView{
    self.supermaketTableView.tableHeaderView = self.tableHeadView;
    [self.view addSubview:self.tableFooterView];
    
    self.tableFooterView.delegate = self;
    self.supermaketTableView.delegate = self;
    self.supermaketTableView.dataSource = self;
    self.supermaketTableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
    self.supermaketTableView.rowHeight = ShopCartRowHeight;
    self.supermaketTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.supermaketTableView];
    
}

- (void)buildTableHeadView{
    self.tableHeadView.backgroundColor = self.view.backgroundColor;
    
    self.tableHeadView.frame = CGRectMake(0, 0, self.view.width, 250);
    CHLog(@"%@",self.tableHeadView);
    
    [self.supermaketTableView addSubview:self.tableHeadView];
    //[self.view bringSubviewToFront:self.tableHeadView];
    
    [self buildReceiptAddress];
    [self buildMarketView];
    [self buildSignTimeView];
    [self buildSignComments];

}
//收货地址UI
- (void)buildReceiptAddress{
        
    [self.tableHeadView addSubview:self.receiptAdressView];
    
    if ([[UserInfo shareUserInfo] hasDefalutAdress]) {
        self.receiptAdressView.address = [[UserInfo shareUserInfo] defaultAddress];
    }else{
        __weak typeof(self)weakSelf = self;
        [AddressTool loadMyAddressData:^(NSArray<Address *> *AddressData, NSError *error) {
            if (error != nil) {
                if (AddressData.count > 0) {
                    [[UserInfo shareUserInfo]setAllAddress:(NSMutableArray*)AddressData];
                    weakSelf.receiptAdressView.address = [[UserInfo shareUserInfo] defaultAddress];
                }
            }
        }];
    }
    
    
}
//闪电超市
- (void)buildMarketView{
    
    
    [self.tableHeadView addSubview:self.markerView];

}
//收货时间
- (void)buildSignTimeView{
    UIView *signTimeView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.width, ShopCartRowHeight)];
    signTimeView.backgroundColor = [UIColor whiteColor];
    [self.tableHeadView addSubview:signTimeView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifySignTimeViewClick)];
    [signTimeView addGestureRecognizer:tap];
    
    UILabel *signTimeTitleLabel = [[UILabel alloc]init];
    signTimeTitleLabel.text = @"收货时间";
    signTimeTitleLabel.textColor = [UIColor blackColor];
    signTimeTitleLabel.font = [UIFont systemFontOfSize:15];
    [signTimeTitleLabel sizeToFit];
    signTimeTitleLabel.frame = CGRectMake(15, 0, signTimeTitleLabel.width, ShopCartRowHeight);
    [signTimeView addSubview:signTimeTitleLabel];
    
    //self.signTimeLabel = [[UILabel alloc]init];
    self.signTimeLabel.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame) + 10, 0, self.view.width * 0.5, ShopCartRowHeight);
    self.signTimeLabel.textColor = [UIColor redColor];
    self.signTimeLabel.font = [UIFont systemFontOfSize:15];
    self.signTimeLabel.text = @"闪电送，及时达";
    [signTimeView addSubview:self.signTimeLabel];
    
    //self.reserveLabel = [[UILabel alloc]init];
    self.reserveLabel.text = @"可预订";
    self.reserveLabel.backgroundColor = [UIColor whiteColor];
    self.reserveLabel.textColor = [UIColor redColor];
    self.reserveLabel.font = [UIFont systemFontOfSize:15];
    self.reserveLabel.frame = CGRectMake(self.view.width - 72, 0, 60, ShopCartRowHeight);
    [signTimeView addSubview:self.reserveLabel];
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
    arrowImageView.frame = CGRectMake(self.view.width - 15, (ShopCartRowHeight - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height);
    [signTimeView addSubview:arrowImageView];
    
}
//备注UI
- (void)buildSignComments{
    
    [self.tableHeadView addSubview:self.commentsView];
}

- (UIView*)lineView:(CGRect)frame {
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}

#pragma mark -- action 方法
- (void)leftNavigitonItemClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarBuyProductNumberDidChangeNotification object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)modifySignTimeViewClick{
    CHLog(@"修改收货时间");
}

- (void)selectedSignTimeTextFieldDidChange:(UIButton*)sender{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.commentsView.textField endEditing:YES];
}


#pragma mark -- ShopCartSupermarketTableFooterViewDelegate
-(void)supermarketTableFooterDetermineButtonClick{
    OrderPayWayViewController *opayWay = [[OrderPayWayViewController alloc]init];
   // BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:opayWay];
    
    [self.navigationController pushViewController:opayWay animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[UserShopCarTool shareUserShopCarTool] getShopCarProductClassifNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCartCell *cell = [ShopCartCell shopCarCell:tableView];
    cell.good = [[UserShopCarTool shareUserShopCarTool] getShopCarProduct][indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.commentsView.textField endEditing:YES];
}


@end
