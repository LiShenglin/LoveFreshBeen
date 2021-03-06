//
//  UIDevice+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIDevice+Extension.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation UIDevice (Extension)
+ (CGFloat)currentDeviceScreenMeasurement{
    CGFloat deviceScree = 3.5;
    
    if ((568 == ScreenHeight && 320 == ScreenWidth) || (1136 == ScreenHeight && 640 == ScreenWidth)) {
        deviceScree = 4.0;
    } else if ((667 == ScreenHeight && 375 == ScreenWidth) || (1334 == ScreenHeight && 750 == ScreenWidth)) {
        deviceScree = 4.7;
    } else if ((736 == ScreenHeight && 414 == ScreenWidth) || (2208 == ScreenHeight && 1242 == ScreenWidth)) {
        deviceScree = 5.5;
    }
    return deviceScree;
}

@end
