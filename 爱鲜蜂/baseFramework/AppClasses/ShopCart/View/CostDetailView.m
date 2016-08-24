//
//  CostDetailView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CostDetailView.h"

@interface CostDetailView()

@end
@implementation CostDetailView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self buildLabel:CGRectMake(15, 0, 150, 30) text:@"费用明细" font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 30 - 0.5, SCREEN_WIDTH - 15, 0.5)];
        lineView1.backgroundColor = [UIColor blackColor];
        lineView1.alpha = 0.1;
        [self addSubview:lineView1];
        
        [self buildLabel:CGRectMake(15, 35, 100, 20) text:@"商品总额" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        
        [self buildLabel:CGRectMake(100, 35, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",[[UserShopCarTool shareUserShopCarTool] getAllProductPrice]] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight];
        
        [self buildLabel:CGRectMake(15, 60 , 100, 20) text:@"配送费" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        NSString *distribution = @"";
        if ([[[UserShopCarTool shareUserShopCarTool] getAllProductPrice] floatValue] >= 30) {
            distribution = @"0";
            self.coupon = @"5";
        }else{
            distribution = @"8";
            self.coupon = @"0";
        }
        
        [self buildLabel:CGRectMake(100, 60, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",distribution] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight];
        [self buildLabel:CGRectMake(15, 85, 100, 20) text:@"服务费" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        [self buildLabel:CGRectMake(15, 85, SCREEN_WIDTH - 110, 20) text:@"$0" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight];
        
        [self buildLabel:CGRectMake(15, 110, 100, 20) text:@"优惠券" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        [self buildLabel:CGRectMake(15, 110, SCREEN_WIDTH - 110, 20) text:[NSString stringWithFormat:@"$%@",self.coupon] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 135 - 1, SCREEN_WIDTH, 1)];
        lineView2.backgroundColor = [UIColor blackColor];
        lineView2.alpha = 0.1;
        [self addSubview:lineView2];
        
        
        
    }
    return self;
}

- (void)buildLabel:(CGRect)labelFrame text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.text = text;
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    [self addSubview:label];
}

@end
