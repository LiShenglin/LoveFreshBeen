//
//  CHTabBarButton.m
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHTabBarButton.h"

@implementation CHTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2+5;
    self.imageView.width = 21.0;
    self.imageView.height = 21.0;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 10;
    newFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = newFrame;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    

}

- (void)playAnimation{
    CAKeyframeAnimation * keyAnimation = [[CAKeyframeAnimation alloc]init];
    keyAnimation.keyPath = @"transform.scale";
    keyAnimation.values = @[@(1.0),@(1.4),@(0.9),@(1.15),@(0.95),@(1.2),@(1.0)];
    keyAnimation.duration = 0.7;
    keyAnimation.calculationMode = kCAAnimationCubic;
    [self.imageView.layer addAnimation:keyAnimation forKey:nil];
    
}

@end
