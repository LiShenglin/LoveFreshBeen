//
//  UIImageView+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
+(UIImageView *)addImgWithFrame:(CGRect)frame AndImage:(NSString *)imgName  isuserInteractionEnabled:(BOOL)isEnabled{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.userInteractionEnabled = isEnabled;
    imgView.image = [UIImage imageNamed:imgName];
    
    return imgView;
}
/**
 *  设置头像
 *
 *  @param url
 */
- (void)setHeader:(NSString *)url{
    [self setCircleHeader:url];
}
/**
 *  设置圆形头像
 */
- (void)setCircleHeader:(NSString *)url{
    UIImage *placeholder = [UIImage circleImageClass:url];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.image = [image circleImage];
    }];
}
/**
 *  设置矩形头像
 */
- (void)setRectHeader:(NSString *)url{
    UIImage *placeHolder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder];
}

@end
