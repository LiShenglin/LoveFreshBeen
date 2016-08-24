//
//  PublicConfig.h
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#ifndef PublicConfig_h
#define PublicConfig_h
#import "UIDevice+Extension.h"
#import "BaseNavigationController.h"
#import "ProgressHUBManager.h"



#define ScreenBounds [UIScreen mainScreen].bounds
#define AINotiCenter [NSNotificationCenter defaultCenter]
#define LFBNavigationBarWhiteBackgroundColor [UIColor colorWithRed:249 green:250 blue:253 alpha:1.0]
static CGFloat const ShopCarRedDotAnimationDuration = 0.2;
static CGFloat const NavigationH = 64;
static CGFloat const ShopCartRowHeight = 50;
#pragma mark --通知
// MARK: - Home 属性
static CGFloat const HotViewMargin = 10;
static CGFloat const HomeCollectionViewCellMargin = 10;
static CGFloat const HomeCollectionCellAnimationDuration = 1.0;

/// 首页headView高度改变
static NSString* const HomeTableHeadViewHeightDidChange = @"HomeTableHeadViewHeightDidChange";
/// 首页商品库存不足
static NSString* const HomeGoodsInventoryProblem = @"HomeGoodsInventoryProblem";
static NSString* const GuideViewControllerDidFinish = @"GuideViewControllerDidFinish";
static NSString* const LFBSearchViewControllerDeinit = @"LFBSearchViewControllerDeinit";
static NSString* const LFBShopCarDidRemoveProductNSNotification =@ "LFBShopCarDidRemoveProductNSNotification";
/// 购买商品数量发生改变
static NSString* const LFBShopCarBuyProductNumberDidChangeNotification = @"LFBShopCarBuyProductNumberDidChangeNotification";
/// 购物车商品价格发送改变
static NSString* const LFBShopCarBuyPriceDidChangeNotification = @"LFBShopCarBuyPriceDidChangeNotification";
// MARK: - 搜索ViewController
static NSString* const LFBSearchViewControllerHistorySearchArray = @"LFBSearchViewControllerHistorySearchArray";

static NSString* const TabBtnClick = @"TabBtnClick";

// MARK: - 广告页通知
static NSString* const ADImageLoadSecussed = @"ADImageLoadSecussed";
static NSString* const ADImageLoadFail = @"ADImageLoadFail";


// MARK: - 常用颜色
#define LFBGlobalBackgroundColor CHColor(239, 239, 239)
#define LFBNavigationYellowColor CHColor(253, 212, 49)
#define LFBTextGreyColol CHColor(130, 130, 130)
#define LFBTextBlackColor CHColor(50, 50, 50)
#define HomeCollectionTextFont [UIFont systemFontOfSize:14]


#endif /* PublicConfig_h */
