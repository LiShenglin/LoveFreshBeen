//
//  HWEmotion.h
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"
// 通知
// 表情选中的通知
#define HWEmotionDidSelectNotification @"HWEmotionDidSelectNotification"
#define HWSelectEmotionKey @"HWSelectEmotionKey"
// 删除文字的通知
#define HWEmotionDidDeleteNotification @"HWEmotionDidDeleteNotification"

@interface HWEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;
@end
