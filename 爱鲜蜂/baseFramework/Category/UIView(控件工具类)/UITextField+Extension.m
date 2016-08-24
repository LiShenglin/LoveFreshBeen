//
//  UITextField+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UITextField+Extension.h"

#import <objc/message.h>

NSString * const placeholderColorName = @"placeholderColor";
@implementation UITextField (Extension)
/**
 *
 *没有背景的输入框
 */
+(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color
{
    UITextField *textF=[[UITextField alloc]initWithFrame:frame];
    textF.userInteractionEnabled = YES;
    textF.textColor = color;
    textF.font =[UIFont systemFontOfSize:font*Width];
    textF.placeholder=placeholder;
    return textF;
}
/**
 *
 *有背景的输入框,设置代理、外层配合下列方法即可实现文本输入交替
 */
//+(UITextField *)addTextFieldWithFrame:(CGRect)frame WithHeight:(CGFloat)heigh AndBgImgStr:(NSString *)bgimage AndPlaceholderStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color target:(UIView *)view AndDelegate:(UIViewController *)vc{
//    UIImageView *imgBack =[UIImageView addImgWithFrame:CGRectMake(30*Width, heigh*Height, 260*Width, 36*Height) AndImage:@"login_Register_Bord" isuserInteractionEnabled:NO];
//    [view addSubview:imgBack];
//    
//    UITextField *textF =[UITextField addTextFieldWithFrame:CGRectMake(30*Width+5, (heigh+0.5)*Height, 260*Width-5, 35*Height) AndStr:placeholder AndFont:14 AndTextColor:whitesColor];
//    textF.delegate = vc;
//    [view addSubview:textF];
//    return textF;
//}


#pragma mark -- 占位符换颜色
+ (void)load
{
    Method placeholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method bs_placeholderMethod = class_getInstanceMethod(self, @selector(bs_setPlaceholder:));
    method_exchangeImplementations(placeholderMethod, bs_placeholderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    UILabel *placeLabel = [self valueForKeyPath:@"placeholderLabel"];
    
    placeLabel.textColor = placeholderColor;
    
    objc_setAssociatedObject(self, (__bridge const void *)(placeholderColorName), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)placeholderColor
{
    
    return objc_getAssociatedObject(self, (__bridge const void *)(placeholderColorName));
    
}

- (void)bs_setPlaceholder:(NSString *)placeholder
{
    
    [self bs_setPlaceholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}
@end

