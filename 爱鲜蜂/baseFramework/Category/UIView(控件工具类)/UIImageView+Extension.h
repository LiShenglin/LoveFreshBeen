//
//  UIImageView+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
+(UIImageView *)addImgWithFrame:(CGRect)frame AndImage:(NSString *)imgName isuserInteractionEnabled:(BOOL)isEnabled;

/**
 *  设置头像
 *
 *  @param url
 */
- (void)setHeader:(NSString *)url;

/**
 *  设置圆形头像
 */
- (void)setCircleHeader:(NSString *)url;
/**
 *  设置矩形头像
 */
- (void)setRectHeader:(NSString *)url;

@end
