//
//  PageScrollView.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame placeholder:(UIImage*)placeholder focusImageViewClick:(void(^)(NSInteger index))focusImageViewClick;

@property(nonatomic,strong)HomeHeadData * headData;

@end
