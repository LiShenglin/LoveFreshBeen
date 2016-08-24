//
//  PayWayView.h
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PayWayType) {
    WeChat = 0,
    QQPurse = 1,
    AliPay = 2,
    Delivery = 3
};

/**
 *  PayWayView支付view
 */
typedef void(^SelectedCallback)(PayWayType type);

@interface PayWayView : UIView
- (instancetype)initWithFrame:(CGRect)frame payType:(PayWayType)payType selectedCallBack:(SelectedCallback)selectedCallback;

@end


/**
 *  PayView支付总View
 */
@interface PayView : UIView

@property(nonatomic,strong)PayWayView *weChatView;
@property(nonatomic,strong)PayWayView *qqPurseView;

@property(nonatomic,strong)PayWayView *alipayView;

@property(nonatomic,strong)PayWayView *deliveryView;


-(instancetype)initWithFrame:(CGRect)frame;

@end