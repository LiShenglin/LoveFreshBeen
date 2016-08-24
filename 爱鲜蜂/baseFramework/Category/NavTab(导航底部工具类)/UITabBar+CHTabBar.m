//
//  UITabBar+CHTabBar.m
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UITabBar+CHTabBar.h"

@implementation UITabBar (CHTabBar)
//添加+按钮
-(UIButton *)pulishBtnNormalImg:(NSString*)norImg selImg:(NSString *)selImg{
    UIButton *pulishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pulishBtn setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    [pulishBtn setImage:[UIImage imageNamed:selImg] forState:UIControlStateSelected];
    [pulishBtn sizeToFit];
    [self addSubview:pulishBtn];
    return pulishBtn;
}
//只针对奇数按钮自动布局添加中间按钮，
-(void)setTabBarCount:(CGFloat)count needMiddleBtn:(BOOL)isNeedMiddleBtn btnWH:(void(^)(CGFloat btnw,CGFloat btnH))btnWH{
    /**** 按钮的尺寸 ****/
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    NSInteger midcount = count / 2;
    if(btnWH){
        btnWH(buttonW,buttonH);
    }
    
    /**** 设置所有UITabBarButton的frame ****/
    CGFloat tabBarButtonY = 0;
    // 按钮索引
    int tabBarButtonIndex = 0;
    
        if (isNeedMiddleBtn) {//需要添加中间按钮
            for (UIControl *subview in self.subviews) {
            // 过滤掉非UITabBarButton
            if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
            // 设置frame
            CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
                
            if (tabBarButtonIndex >= midcount) { // 右边的2个UITabBarButton
                tabBarButtonX += buttonW;
            }
            subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
                
 
            // 增加索引
            tabBarButtonIndex++;
                
                
                
            }
        }else{//不需要添加中间按钮

            for (UIView *subview in self.subviews) {
                // 过滤掉非UITabBarButton
                if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
                // 设置frame
                CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
                tabBarButtonX += buttonW;
                subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
                // 增加索引
            }
            
        }
    
}

@end
