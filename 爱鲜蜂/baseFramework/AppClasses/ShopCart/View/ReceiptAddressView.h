//
//  ReceiptAddressView.h
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptAddressView : UIView
@property(nonatomic,strong)Address *address;
-(instancetype)initWithFrame:(CGRect)frame modifyButtonClickCallBack:(dispatch_block_t) modifyButtonClickCallBack;

@end
