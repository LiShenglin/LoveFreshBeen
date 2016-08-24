//
//  ADViewController.m
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController()
@property(nonatomic,strong)UIImageView *imageView;
@end
@implementation ADViewController

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = [UIScreen mainScreen].bounds;
        }
    return _imageView;
}

- (void)setImageName:(NSString *)imageName{
    CGFloat deviceScree = [UIDevice currentDeviceScreenMeasurement];
    NSString *placeholderImageName = nil;
    if (deviceScree == 3.5) {
        placeholderImageName = @"iphone4";
    }else if (deviceScree == 4.0){
        placeholderImageName = @"iphone5";
    }else if (deviceScree == 4.7){
        placeholderImageName = @"iphone6";
    }else{
        placeholderImageName = @"iphone6s";
    }
    
    self.imageView.image = [UIImage imageNamed:placeholderImageName];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error != nil) {
                CHLog(@"广告加载失败");
                [AINotiCenter postNotificationName:ADImageLoadFail object:nil];
            }
            
            if (image != nil) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [AINotiCenter postNotificationName:ADImageLoadSecussed object:image];
                    });
                });
            }else{//广告加载失败
                [AINotiCenter postNotificationName:ADImageLoadFail object:nil];
            }
        }];

        
        
    });
    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

@end
