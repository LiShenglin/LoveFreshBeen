//
//  HotView.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IconClick)(NSInteger index);
@interface HotView : UIView
@property(nonatomic,strong)HomeHeadData * headData;
@property(nonatomic,weak)IconClick iconClick;
-(instancetype)initWithFrame:(CGRect)frame iconClick:(IconClick)iconClick;

@end
