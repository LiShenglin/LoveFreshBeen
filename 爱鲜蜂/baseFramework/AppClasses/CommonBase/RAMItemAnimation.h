//
//  RAMItemAnimation.h
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RAMItemAnimationProtocol <NSObject>
- (void)playAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel;
- (void)deselectAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel defaultTextColor:(UIColor *)defaultTextColor;
- (void)selectedAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel;

@end
@interface RAMItemAnimation : NSObject<RAMItemAnimationProtocol>
//动画时间
- (CGFloat)duration;
//文本选中颜色
- (UIColor*)textSelectedColor;
//图标选中颜色
- (UIColor *)iconSelectedColor;
//按钮执行动画
- (void)playAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel;
//取消动画按钮
- (void)deselectAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel defaultTextColor:(UIColor *)defaultTextColor;
//选中动画按钮
- (void)selectedAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel;
@end
