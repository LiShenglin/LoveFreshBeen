//
//  UIButton+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
/**
 *按钮图片分类
 */
+ (UIButton *)addBtnImage:(NSString *)imgName AndFrame:(CGRect)frame WithTarget:(id)target action:(SEL)action
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame =frame;
    return btn;
}
/**
 *按钮图片+文字内容和偏离位置设置
 */
+(UIButton *)addBtnImage:(NSString *)img AndFrame:(CGRect)frame WithTitle:(NSString *)title AndTitleColor:(UIColor *)color AndTitleFont:(CGFloat)font AndImgInsets:(UIEdgeInsets)edgeInset AndTitleEdgeInsets:(UIEdgeInsets)titleInsets AndTarget:(id)traget AndAction:(SEL)selector
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:titleInsets];
    [btn setImageEdgeInsets:edgeInset];
    btn.titleLabel.font =[UIFont systemFontOfSize:font];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn addTarget:traget action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/**
 *设置文字+背景图的按钮
 */
+(UIButton *)addBtnWithFrame:(CGRect)frame WithTitle:(NSString *)title WithBGImg:(NSString *)backImg WithFont:(CGFloat)font WithTitleColor:(UIColor *)color Target:(id)traget Action:(SEL)action
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:font];
    btn.titleLabel.font =[UIFont systemFontOfSize:font];
    [btn setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
    [btn addTarget:traget action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
