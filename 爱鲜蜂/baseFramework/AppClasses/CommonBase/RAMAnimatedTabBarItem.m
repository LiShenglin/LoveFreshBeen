//
//  RAMAnimatedTabBarItem.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "RAMAnimatedTabBarItem.h"

@implementation RAMAnimatedTabBarItem
- (void)playAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel{
    if (self.animation != nil ) {
        [self.animation playAnimationIcon:icon textLabel:textlabel];
    }
}

- (void)deselectAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel defaultTextColor:(UIColor *)defaultTextColor{
    if ([self.animation respondsToSelector:@selector(deselectAnimationIcon:textLabel:defaultTextColor:)]) {
        [self.animation deselectAnimationIcon:icon textLabel:textlabel defaultTextColor:defaultTextColor];
    }
}

- (void)selectedAnimationIcon:(UIImageView*)icon textLabel:(UILabel*)textlabel{
    if ([self.animation respondsToSelector:@selector(selectedAnimationIcon:textLabel:)]) {
        [self.animation selectedAnimationIcon:icon textLabel:textlabel];
    }
    
}
@end
