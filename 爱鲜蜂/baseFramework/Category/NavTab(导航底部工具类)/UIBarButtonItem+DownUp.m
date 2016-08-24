//
//  UIBarButtonItem+DownUp.m
//  baseFramework
//
//  Created by chenangel on 16/6/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIBarButtonItem+DownUp.h"
#import "ItemLeftButton.h"
#import "ItemRightButton.h"
#import "ItemLeftImageButton.h"


@implementation UIBarButtonItem (DownUp)

+ (UIBarButtonItem*)barButton:(NSString*)title titleColor:(UIColor*)titleColor image:(UIImage*)image hightLightImage:(UIImage*)hightLightImage target:(id)target action:(SEL)action type:(ItemButtonType)type{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (type == ItemButtonTypeLeft) {
        btn = [ItemLeftButton buttonWithType:UIButtonTypeCustom];
    }else{
        btn = [ItemRightButton buttonWithType:UIButtonTypeCustom];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setImage:hightLightImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 60, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonWithImage:(UIImage*)image target:(id)target action:(SEL)action{
    UIButton *btn = [ItemLeftImageButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeCenter;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 44, 44);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (UIBarButtonItem*)barButtonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if ([title lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] == 2) {
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25);
    }
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



@end
