//
//  FormValidator.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormValidator : NSObject<UIAlertViewDelegate>

+(UIColor *) randomColor;
/**
 * 密码规则验证
 *
 *  @param aPassword 密码
 *
 *  @return 如果正确则返回nil，不符合则有提示
 */
+(NSString *)checkPassword:(NSString *)aPassword;
/**
 * 手机账号规则验证
 */
+(NSString *)checkMobile:(NSString *)aMobile;
/**
 * 验证码规则验证
 */
+(NSString *)checkVerifyCode:(NSString *)verifyCode;


+ (void)showAlertWithStr:(NSString *)message;

+(CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat;
+(CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrWidth:(CGFloat)widh;

@end
