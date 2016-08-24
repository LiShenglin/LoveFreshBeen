//
//  UIBarButtonItem+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//  导航条按钮配置
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/** 配置导航条按钮 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image heighlightImage:(NSString *)heilightImage;

@end
