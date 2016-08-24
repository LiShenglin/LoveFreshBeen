//
//  CHTabBarButton.h
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarRedDotView.h"
@interface CHTabBarButton : UIButton
@property(nonatomic,weak)ShopCarRedDotView * redDotView;

- (void)playAnimation;

@end
