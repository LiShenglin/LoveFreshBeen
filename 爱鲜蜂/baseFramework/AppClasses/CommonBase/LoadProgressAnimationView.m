//
//  LoadProgressAnimationView.m
//  baseFramework
//
//  Created by chenangel on 16/7/4.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "LoadProgressAnimationView.h"

@interface LoadProgressAnimationView()

@end
@implementation LoadProgressAnimationView
CGFloat viewWidth = 0;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        viewWidth = frame.size.width;
        self.backgroundColor = LFBNavigationYellowColor;
        self.width = 0;
    }
    return self;
}
- (void)startLoadProgressAnimation{
    self.width = 0;
    self.hidden = NO;
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.width = viewWidth *0.6;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.width = viewWidth * 0.8;
            }];
        });
    }];
}

- (void)endLoadProgressAnimation{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = viewWidth;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}


@end
