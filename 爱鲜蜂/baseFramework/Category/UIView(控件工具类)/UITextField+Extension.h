//
//  UITextField+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

@property UIColor *placeholderColor;
/**
 *
 *没有背景的输入框
 */
+(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color;
/**
 *
 *有背景的输入框,设置代理、外层配合下列方法即可实现文本输入交替
 */
//
//+(UITextField *)addTextFieldWithFrame:(CGRect)frame WithHeight:(CGFloat)heigh AndBgImgStr:(NSString *)bgimage AndPlaceholderStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color AndDelegate:(UIViewController *)vc;


@end
