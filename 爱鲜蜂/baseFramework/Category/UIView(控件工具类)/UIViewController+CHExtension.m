//
//  UICollectionView+CHExtension.m
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIViewController+CHExtension.h"

@implementation UIViewController (CHExtension)
-(void)showNetWorkErrorView{
    UIButton * errorView = [UIButton buttonWithType:UIButtonTypeCustom];
    errorView.frame = CGRectMake(0, 0, 150, 145);
    errorView.center = self.view.center;
    [errorView setImage:[UIImage imageNamed:@"not_network_icon_unpre"] forState:UIControlStateNormal];
    [errorView setImage:[UIImage imageNamed:@"not_network_icon_pre"] forState:UIControlStateHighlighted];
    [errorView addTarget:self action:@selector(errorViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:errorView];

    // 让他处在view的最上层
    [self.view bringSubviewToFront:errorView];
}

-(void)errorViewDidClick:(UIButton*)errorView {
    [errorView removeFromSuperview];
    [CHNotificationCenter postNotificationName:@"NOTIFY_ERRORBTNCLICK" object:nil];
}

-(void)showProgress{
    UIImageView *progressView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    progressView.tag = 500;
    progressView.center = self.view.center;
    [self.view addSubview:progressView];
    NSMutableArray<UIImage*>*imgArray = [NSMutableArray array];
    // 添加图片
    for (NSInteger i = 0; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld",i+1]];
        [imgArray addObject:image];
    }
    progressView.animationImages = imgArray;
    progressView.animationDuration = 0.5;
    progressView.animationRepeatCount = 999;
    [progressView startAnimating];
}

-(void)hiddenProgress{
    for (UIImageView *view in self.view.subviews){
        if (view.tag == 500){
            [view stopAnimating];
            [view performSelector:@selector(setAnimationImages:) withObject:nil];
        }
    }
}
@end
