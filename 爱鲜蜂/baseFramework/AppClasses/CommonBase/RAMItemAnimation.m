//
//  RAMItemAnimation.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "RAMItemAnimation.h"

@interface RAMItemAnimation()

@end
@implementation RAMItemAnimation
//动画时间
- (CGFloat)duration{
    return 0.6;
}
//文本选中颜色
- (UIColor*)textSelectedColor{
    return [UIColor grayColor];
}
//图标选中颜色
- (UIColor *)iconSelectedColor{
    return [UIColor yellowColor];
}
#pragma mark -- 执行动画
//按钮执行动画
- (void)playAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel{
    [self playBounceAnimation:icon];
    textlabel.textColor = self.textSelectedColor;
}
//取消动画按钮
- (void)deselectAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel defaultTextColor:(UIColor *)defaultTextColor{
    textlabel.textColor = defaultTextColor;
    
    UIImage * tempImage = icon.image;
    icon.image = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    icon.tintColor = defaultTextColor;
}
//选中动画按钮
- (void)selectedAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel{
    textlabel.textColor = self.textSelectedColor;
    UIImage *tempImage = icon.image;
    CHLog(@"itemitem----%@",icon.image);
    icon.image = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    icon.tintColor = self.textSelectedColor;
    
}
- (void)playBounceAnimation:(UIImageView *)icon{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@(1.0),@(1.4),@(0.9),@(1.15),@(0.95),@(1.2),@(1.0)];
    bounceAnimation.duration = self.duration;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    UIImage *tempimage = icon.image;
    icon.image = [tempimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    icon.tintColor = self.iconSelectedColor;
}








@end
