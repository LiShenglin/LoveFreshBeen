//
//  UIButton+ItemLeftImageButton.m
//  baseFramework
//
//  Created by chenangel on 16/6/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ItemLeftImageButton.h"

@implementation ItemLeftImageButton
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.imageView.x = -15;
}

@end
