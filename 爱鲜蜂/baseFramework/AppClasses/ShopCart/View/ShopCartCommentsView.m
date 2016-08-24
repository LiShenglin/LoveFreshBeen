//
//  ShopCartCommentsView.m
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCartCommentsView.h"

@interface ShopCartCommentsView()
@end
@implementation ShopCartCommentsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:[self lineView:CGRectMake(10, 0, SCREEN_WIDTH - 10, 0.5)]];
        self.signCommentsLabel = [[UILabel alloc]init];
        self.signCommentsLabel.text = @"收货备注";
        self.signCommentsLabel.textColor = [UIColor blackColor];
        self.signCommentsLabel.font = [UIFont systemFontOfSize:15];
        self.signCommentsLabel.frame = CGRectMake(15, 15, self.signCommentsLabel.width, self.signCommentsLabel.height);
        [self.signCommentsLabel sizeToFit];
        [self addSubview:self.signCommentsLabel];
        
        self.textField = [[UITextField alloc]init];
        self.textField.placeholder = @"可输入100字以内特殊要求内容";
        self.textField.frame = CGRectMake(CGRectGetMaxX(self.signCommentsLabel.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(self.signCommentsLabel.frame) - 10 - 20, ShopCartRowHeight - 20);
        self.textField.font = [UIFont systemFontOfSize:15];
        //边框转角类型
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self addSubview:self.textField];
        
        [self addSubview:[self lineView:CGRectMake(0, ShopCartRowHeight - 0.5, SCREEN_WIDTH, 0.5)]];
        
        
        
    }
    return self;
}

- (UIView*)lineView:(CGRect)frame {
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}


@end
