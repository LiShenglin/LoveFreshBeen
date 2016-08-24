//
//  CHTabBarView.m
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHTabBarView.h"
#import "CHTabBarButton.h"
#import "ShopCarRedDotView.h"
@interface CHTabBarView()
@property(nonatomic,strong) CHTabBarButton * lastTabBarButton;
@property(nonatomic,strong) ShopCarRedDotView * redDotView;
@end

@implementation CHTabBarView

- (void)setTabBarItems:(NSArray *)TabBarItems{
    _TabBarItems = TabBarItems;
    NSArray *iconsImage = @[@"v2_home", @"v2_order", @"shopCart", @"v2_my"];
    NSArray *selectImage = @[@"v2_home_r", @"v2_order_r", @"shopCart_r", @"v2_my_r"];
    
    for (NSInteger index; index < self.TabBarItems.count; index ++) {
        UITabBarItem * item = self.TabBarItems[index];
        
        CHTabBarButton * tabBarButton = [CHTabBarButton buttonWithType:UIButtonTypeCustom];
        //CHLog(@"title----%@",item.title);
        tabBarButton.tintColor = [UIColor grayColor];
        tabBarButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [tabBarButton setTitle:item.title forState:UIControlStateNormal];
        [tabBarButton setTitle:item.title forState:UIControlStateSelected];
        [tabBarButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tabBarButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [tabBarButton.titleLabel sizeToFit];
        
        UIImage * image = [UIImage imageNamed:iconsImage[index]];
        
        [tabBarButton setImage:[UIImage imageNamed:iconsImage[index]] forState:UIControlStateNormal];
        [tabBarButton setImage:[UIImage imageNamed:selectImage[index]] forState:UIControlStateSelected];
        
        [tabBarButton sizeToFit];
        if (index == 2) {
            ShopCarRedDotView * redDotView = [ShopCarRedDotView shareShopCarRedDotView];
            redDotView.buyNumber = 0;
            redDotView.frame = CGRectMake(55, 5, 16, 16);
            [tabBarButton addSubview:redDotView];
            self.redDotView = redDotView;
        }
        
        CHLog(@"image-----%@----%@",image,tabBarButton.imageView);
        [self addSubview:tabBarButton];
    }

}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger i = 0;
    for (NSInteger index; index < self.subviews.count; index ++) {
        UIControl * btn = self.subviews[index];
        if([btn isKindOfClass:[CHTabBarButton class]]) {
            CHTabBarButton * tempBtn = (CHTabBarButton*)btn;

            CGFloat buttonW = self.width/self.TabBarItems.count;
            CGFloat buttonH = 49.0;
            CGFloat buttonX = i*buttonW;
            CGFloat buttonY = 0;
            
            tempBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

            tempBtn.tag = i;
            i ++;
            [tempBtn addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}

- (void)tabBarClick:(CHTabBarButton *)btn{
    self.lastTabBarButton.selected = NO;
    
    btn.selected = YES;
    self.lastTabBarButton = btn;
    if (btn.tag != 2) {
        [btn playAnimation];
    }
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [_delegate tabBar:self didClickBtn:btn.tag];
    }
    
    
}


@end
