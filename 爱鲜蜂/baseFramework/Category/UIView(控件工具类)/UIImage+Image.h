//
//
//  Created by chenangel on 16/5/20.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 圆形图片
 */
- (UIImage *)circleImage;
+ (UIImage *)circleImageClass:(NSString *)image;


+ (UIImage *)imageWithName:(NSString *)name;

/**
 * 在周边加一个边框为1的透明像素
 */
- (UIImage *)imageAntialias;

// 快速的返回一个最原始的图片
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName;


// 快速拉伸图片
+ (instancetype)imageWithStretchableImageName:(NSString *)imageName;
//图片圆环
+ (UIImage *)imageWithClipImageNamed:(UIImage *)clipImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

#pragma mark -- 根据图片url获取图片大小
+ (CGSize)getImageSizeWithURL:(id)imageURL;


@end
