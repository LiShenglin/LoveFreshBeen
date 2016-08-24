//
//  ProgressHUBManager.m
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ProgressHUBManager.h"

@implementation ProgressHUBManager
+ (void)setBackgroundColor:(UIColor *)color {
    [SVProgressHUD setBackgroundColor:color];
}

+ (void)setForegroundColor:(UIColor *)color {
    [SVProgressHUD setForegroundColor:color];
}

+ (void)setSuccessImage:(UIImage *)image {
    [SVProgressHUD setSuccessImage:image];
}

+ (void)setErrorImage:(UIImage *)image {
    [SVProgressHUD setErrorImage:image];
}

+ (void)setFont:(UIFont *)font {
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16]];
}

+ (void)showImage:(UIImage *)image status:(NSString *)status {
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showImage:image status:status];
}

+ (void)show{
    [SVProgressHUD show];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)showWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status];
}

+ (BOOL)isVisible{
    return [SVProgressHUD isVisible];
}

+ (void)showSuccessWithStatus:(NSString *)string {
    [SVProgressHUD showSuccessWithStatus:string];
}


@end
