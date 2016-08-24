//
//  RAMAnimatedTabBarItem.h
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMItemAnimation.h"

@interface RAMAnimatedTabBarItem : UITabBarItem<RAMItemAnimationProtocol>
@property(nonatomic,strong) RAMItemAnimation *animation;
@property(nonatomic,strong) UIColor *textColor;

//- (void)playAnimation:(UIImageView*)icon textLabel:(UILabel*)textlabel;

//- (void)deselectAnimation:(UIImageView*)icon textLabel:(UILabel*)textlabel defaultTextColor:(UIColor *)defaultTextColor;

//- (void)selectedAnimation:(UIImageView*)icon textLabel:(UILabel*)textlabel;


@end
