//
//  ProgressHUBManager.h
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface ProgressHUBManager : NSObject
/**设置背景颜色*/
+ (void)setBackgroundColor:(UIColor *)color;
/**设置字体颜色*/
+ (void)setForegroundColor:(UIColor *)color;
/**设置成功显示的图片*/
+ (void)setSuccessImage:(UIImage *)image;
/**设置失败显示的图片*/
+ (void)setErrorImage:(UIImage *)image ;
/**设置字体大小*/
+ (void)setFont:(UIFont *)font;
/**设置成功显示的图片和文字*/
+ (void)showImage:(UIImage *)image status:(NSString *)status;
/**显示成功默认效果*/
+ (void)show;
/**消失*/
+ (void)dismiss;
/**显示文字*/
+ (void)showWithStatus:(NSString *)status ;
/**当前提示框是否显示*/
+ (BOOL)isVisible;
/**显示并设置成功的文字*/
+ (void)showSuccessWithStatus:(NSString *)string ;

@end
