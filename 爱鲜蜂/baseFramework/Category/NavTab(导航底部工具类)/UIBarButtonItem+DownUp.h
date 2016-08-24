//
//  UIBarButtonItem+DownUp.h
//  baseFramework
//
//  Created by chenangel on 16/6/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ItemButtonType) {
    ItemButtonTypeLeft = 0,
    ItemButtonTypeRight = 1,
};
@interface UIBarButtonItem (DownUp)

+ (UIBarButtonItem*)barButton:(NSString*)title titleColor:(UIColor*)titleColor image:(UIImage*)image hightLightImage:(UIImage*)hightLightImage target:(id)target action:(SEL)action type:(ItemButtonType)type;


+ (UIBarButtonItem *)barButtonWithImage:(UIImage*)image target:(id)target action:(SEL)action;

+ (UIBarButtonItem*)barButtonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor target:(id)target action:(SEL)action;

@end
