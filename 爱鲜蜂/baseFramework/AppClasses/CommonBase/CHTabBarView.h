//
//  CHTabBarView.h
//  baseFramework
//
//  Created by chenangel on 16/6/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTabBarView;

@protocol CHTabBarViewDelegate <NSObject>
- (void)tabBar:(CHTabBarView *)tabBar didClickBtn:(NSInteger)index;
@end
@interface CHTabBarView : UIView
@property(nonatomic,strong)NSArray * TabBarItems;
@property(nonatomic,weak) id<CHTabBarViewDelegate> delegate;
@end
