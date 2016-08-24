//
//  UITabBar+CHTabBar.h
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

//tabbar可以制作不同的中间按钮样式
@interface UITabBar (CHTabBar)
//发布按钮
-(UIButton *)pulishBtnNormalImg:(NSString*)norImg selImg:(NSString *)selImg;
//按钮内部自动布局的分类，得到宽、高，常规按钮索引、设置是否要特殊按钮
-(void)setTabBarCount:(CGFloat)count needMiddleBtn:(BOOL)isNeedMiddleBtn btnWH:(void(^)(CGFloat btnw,CGFloat btnH))btnWH;
@end
