//
//  UILabel+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+(UILabel *)addLabelWithFrame:(CGRect)frame AndText:(NSString *)text AndFont:(CGFloat)font AndAlpha:(CGFloat)alpha AndColor:(UIColor *)color AndAlignment:(NSTextAlignment)alignment
{
    UILabel *label =[[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.alpha = alpha;
    label.font =[UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = alignment;
    return label;
}
@end
