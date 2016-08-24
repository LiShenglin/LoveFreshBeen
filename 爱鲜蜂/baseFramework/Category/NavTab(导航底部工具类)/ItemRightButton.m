//
//  UIButton+ItemRightButton.m
//  baseFramework
//
//  Created by chenangel on 16/6/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ItemRightButton.h"

@implementation ItemRightButton
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat Offset = 15;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(Offset, self.height - 15, self.width + Offset, self.titleLabel.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.imageView.frame = CGRectMake(Offset, 0, self.width + Offset, self.height - 15);
    self.imageView.contentMode = UIViewContentModeCenter;
}

@end
