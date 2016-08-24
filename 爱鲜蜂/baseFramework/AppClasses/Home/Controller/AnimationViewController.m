//
//  AnimationViewController.m
//  baseFramework
//
//  Created by chenangel on 16/6/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController()

@end
@implementation AnimationViewController
#pragma mark - 商品添加到购物车动画
- (void)addProductsAnimation:(UIImageView *)imageView {
    if (self.animationLayers == nil) {
        self.animationLayers = [NSMutableArray array];
    }
    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer * transitionLayer = [[CALayer alloc]init];
    transitionLayer.frame = frame;
    //动画的layer数据设置
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    [self.animationLayers addObject:transitionLayer];
    CGPoint p1 = transitionLayer.position;
    CGFloat x = self.view.width - self.view.width / 4 - self.view.width / 8 - 6;
    CGFloat y = self.view.layer.bounds.size.height - 40;
    CGPoint p3 = CGPointMake(x, y);
    //位置帧动画
    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30 , p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = true;
    
    CABasicAnimation * transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation,opacityAnimation,transformAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    [transitionLayer addAnimation:groupAnimation forKey:@"cartParabola"];
    
}


#pragma mark - 添加商品到右下角购物车动画
- (void)addProductsToBigShopCarAnimation:(UIImageView *)imageView {
    if (self.animationBigLayers == nil) {
        self.animationBigLayers = [NSMutableArray array];
    }
    
    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer * transitionLayer = [[CALayer alloc]init];
    transitionLayer.frame = frame;
    //动画的layer数据设置
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    [self.animationBigLayers addObject:transitionLayer];
    CGPoint p1 = transitionLayer.position;
    CGFloat x = self.view.width - 40;
    CGFloat y = self.view.layer.bounds.size.height - 40;
    CGPoint p3 = CGPointMake(x, y);
    //位置帧动画
    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30 , p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = true;
    
    CABasicAnimation * transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation,opacityAnimation,transformAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    [transitionLayer addAnimation:groupAnimation forKey:@"BigShopCarAnimation"];
    
}

#pragma mark - 停止动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.animationLayers.count > 0) {
        CALayer * transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [self.animationLayers removeObjectAtIndex:0];
        [self.view.layer removeAnimationForKey:@"cartParabola"];
    }
    
    if (self.animationBigLayers.count > 0) {
        CALayer * transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [self.animationLayers removeObjectAtIndex:0];
        [self.view.layer removeAnimationForKey:@"BigShopCarAnimation"];
    }
    
}

@end
