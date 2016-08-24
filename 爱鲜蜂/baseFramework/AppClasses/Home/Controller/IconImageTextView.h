//
//  IconImageTextView.h
//  baseFramework
//
//  Created by chenangel on 16/6/29.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activities;
@interface IconImageTextView : UIView
@property(nonatomic,strong)Activities *Activitie;

- (instancetype)initWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage;
@end
