//
//  OrderPayWayViewController.m
//  baseFramework
//
//  Created by chenangel on 16/7/14.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "OrderPayWayViewController.h"
#import "PayWayView.h"
#import "ShopCartGoodsListView.h"
#import "CostDetailView.h"
static CGFloat leftMargin = 15;
@interface OrderPayWayViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *tableHeaderView;


@end

@implementation OrderPayWayViewController

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50)];
    }
    return _scrollView;
}
-(UIView *)tableHeaderView{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40 + 15 + 190 + 30)];
    }
    return _tableHeaderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNavigationItem];
    [self buildScrollView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    print(navigationController)
}

// MARK: - Action
- (void)buildNavigationItem {
    self.navigationItem.title = @"结算付款";
}

- (void)buildScrollView {
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    [self buildTableHeaderView ];
    [self.scrollView addSubview:self.tableHeaderView];
    
}

- (void)buildTableHeaderView {
    self.tableHeaderView.backgroundColor = [UIColor clearColor];
    
    [self buildCouponView];
    
    [self buildPayView];
    
    [self buildCarefullyView];
}

//优惠券
-(void)buildCouponView{
    UIView *couponView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    couponView.backgroundColor = [UIColor whiteColor];
    [self.tableHeaderView addSubview:couponView];
    
    
    UIImageView* couponImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_submit_Icon"]];
    
    couponImageView.frame = CGRectMake(leftMargin, 10, 20, 20);
    [couponView addSubview:couponImageView];
    
    
    UILabel * couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(couponImageView.frame) + 10, 0, SCREEN_WIDTH * 0.4, 40)];
    
    couponLabel.text = @"1张优惠劵";
    couponLabel.textColor = [UIColor redColor];
    couponLabel.font = [UIFont systemFontOfSize:14];
    [couponView addSubview:couponLabel];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
    
    arrowImageView.frame = CGRectMake(SCREEN_WIDTH - 10 - 5, 15, 5, 10);
    [couponView addSubview:arrowImageView];
    
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 40, 40);
    [checkButton setTitle:@"查看" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    checkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [couponView addSubview:checkButton];
    
    
    [self buildLineView:couponView lineFrame: CGRectMake(0, 40 - 1, SCREEN_WIDTH, 1)];
    
}

-(void)buildLineView:(UIView*)addView lineFrame:(CGRect)lineFrame {
    UIView *lineView = [[UIView alloc]initWithFrame:lineFrame];
    
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [addView addSubview:lineView];
    
}

-(void)buildLabel:(CGRect)labelFrame textColor:(UIColor*)textColor font:(UIFont*)font addView: (UIView*)addView text:(NSString *)text {
//    let label = UILabel(frame: labelFrame)
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.textColor = textColor;
    label.font = font;
    label.text = text;
    [addView addSubview:label];
    
}
//支付方式
- (void)buildPayView {
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 190)];
    
    payView.backgroundColor = [UIColor whiteColor];
    [self.tableHeaderView addSubview:payView];
    
    [self buildLabel:CGRectMake(leftMargin, 0, 150, 30) textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12] addView:payView text:@"选择支付方式"];
    
    PayView *payV = [[PayView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 160)];
    [payView addSubview:payV];
    
    [self buildLineView:payView lineFrame:CGRectMake(0, 189, SCREEN_WIDTH, 1)];
    
}
//精选商品和底部确认付款视图
-(void)buildCarefullyView {
    
    UIView *carefullyView = [[UIView alloc]initWithFrame:CGRectMake(0, 40 + 15 + 190 + 15, SCREEN_WIDTH, 30)];
    
    carefullyView.backgroundColor = [UIColor whiteColor];
    [self.tableHeaderView addSubview:carefullyView];
    
    [self buildLabel:CGRectMake(leftMargin, 0, 150, 30) textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12] addView:carefullyView text:@"精选商品"];
    
    
    ShopCartGoodsListView*goodsView = [[ShopCartGoodsListView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(carefullyView.frame), SCREEN_WIDTH, 300)];
    goodsView.height = goodsView.goodsHeight;
    [self.scrollView addSubview:goodsView];
    
    
    
    CostDetailView *costDetailView = [[CostDetailView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsView.frame) + 10, SCREEN_WIDTH, 135)];
    [self.scrollView addSubview:costDetailView];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,  CGRectGetMaxY(costDetailView.frame) + 15);
    
    
    //底部视图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - 64, SCREEN_WIDTH, 50)];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    [self buildLineView:bottomView lineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    [self.view addSubview:bottomView];
    
    [self buildLabel:CGRectMake(leftMargin, 0, 80, 50) textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] addView:bottomView text:@"实付金额:"];
    
    NSString *priceText = [costDetailView.coupon isEqualToString: @"0"] ? [[UserShopCarTool shareUserShopCarTool] getAllProductPrice] : [NSString stringWithFormat:@"%ld",[[[UserShopCarTool shareUserShopCarTool] getAllProductPrice] integerValue] - 5];
    

    if ([priceText floatValue] < 30){
        priceText = [NSString stringWithFormat:@"%f",[priceText floatValue] + 8];
    }
    [self buildLabel:CGRectMake(85, 0, 150, 50) textColor:[UIColor redColor] font:[UIFont systemFontOfSize:14] addView:bottomView text:[NSString stringWithFormat:@"$%@",priceText]];
    
    
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 1, 100, 49)];
    
    payButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [payButton setTitle:@"确认付款" forState:UIControlStateNormal];
    
    payButton.backgroundColor = LFBNavigationYellowColor;
    [payButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [bottomView addSubview:payButton];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
