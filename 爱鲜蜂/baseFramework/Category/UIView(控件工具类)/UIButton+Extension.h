//
//  UIButton+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
/**
 *按钮图片分类
 */
+ (UIButton *)addBtnImage:(NSString *)imgName AndFrame:(CGRect)frame WithTarget:(id)target action:(SEL)action;
/**
 *按钮图片+文字内容和偏离位置设置
 */
+(UIButton *)addBtnImage:(NSString *)img AndFrame:(CGRect)frame WithTitle:(NSString *)title AndTitleColor:(UIColor *)color AndTitleFont:(CGFloat)font AndImgInsets:(UIEdgeInsets)edgeInset AndTitleEdgeInsets:(UIEdgeInsets)titleInsets AndTarget:(id)traget AndAction:(SEL)selector;
/**
 *设置文字+背景图的按钮
 */
+(UIButton *)addBtnWithFrame:(CGRect)frame WithTitle:(NSString *)title WithBGImg:(NSString *)backImg WithFont:(CGFloat)font WithTitleColor:(UIColor *)color Target:(id)traget Action:(SEL)action;
@end
