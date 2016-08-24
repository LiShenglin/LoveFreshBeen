//
//  FreshHotTool.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreshHotTool : NSObject
+ (void)loadFreshHotData:(void(^)(NSArray<Good*>* HotData,NSError * error))completion;

@end
