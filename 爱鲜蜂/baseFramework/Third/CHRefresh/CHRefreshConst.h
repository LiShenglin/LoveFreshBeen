//
//  CHRefreshConst.h
//  baseFramework
//
//  Created by chenangel on 16/6/12.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHRefreshConst : NSObject
/**
 *   主要存储一些常量值
 */


//#define CHRefreshViewHeight 30
//#define CHRefreshSlowAnimationDuration 0.3
//#define CHRefreshHeaderTimeKey @"RefreshHeaderView"
//#define CHRefreshContentOffset @"contentOffset"
//#define CHRefreshContentSize @"contentSize"
#define CHRefreshLabelTextColor [UIColor lightGrayColor]
#define CHRefreshLabelTextSize [UIFont systemFontOfSize:12]

UIKIT_EXTERN CGFloat const CHRefreshViewHeight;
UIKIT_EXTERN CGFloat const CHRefreshSlowAnimationDuration;
UIKIT_EXTERN NSString * const CHRefreshHeaderTimeKey;
UIKIT_EXTERN NSString * const CHRefreshContentOffset;
UIKIT_EXTERN NSString * const CHRefreshContentSize;

@end
