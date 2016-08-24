//
//  UICollectionView+CHExtension.h
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  该分类用于让uiviewController控制器扩展中间加载的动画
 */
@interface UIViewController (CHExtension)
-(void)showNetWorkErrorView;
-(void)errorViewDidClick:(UIButton*)errorView;
-(void)showProgress;
-(void)hiddenProgress;
@end
