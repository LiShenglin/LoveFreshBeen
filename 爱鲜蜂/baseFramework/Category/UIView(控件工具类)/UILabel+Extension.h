//
//  UILabel+Extension.h
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+(UILabel *)addLabelWithFrame:(CGRect)frame AndText:(NSString *)text AndFont:(CGFloat)font AndAlpha:(CGFloat)alpha AndColor:(UIColor *)color AndAlignment:(NSTextAlignment)alignment;
@end
