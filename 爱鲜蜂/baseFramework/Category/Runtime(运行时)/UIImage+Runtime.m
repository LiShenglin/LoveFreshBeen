//
//  UIImage+Runtime.m
//  baseFramework
//
//  Created by chenangel on 16/5/30.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIImage+Runtime.h"
#define DeviceVersion [[UIDevice currentDevice].systemVersion doubleValue]
@implementation UIImage (Runtime)
//此方法需要用到全局快速替换不同版本的时候才开启 load方法

//+ (void)load{
//    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
//    Method m2 = class_getClassMethod([UIImage class], @selector(ch_imageWithName:));
//    //开始交换方法
//    method_exchangeImplementations(m1, m2);
//}

+ (UIImage *)ch_imageWithName:(NSString *)name{
    double version = DeviceVersion;
    if (version >= 7.0) {
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage ch_imageWithName:name];
}
@end
