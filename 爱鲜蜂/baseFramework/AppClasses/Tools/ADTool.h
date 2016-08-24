//
//  ADTool.h
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AD;
@interface ADTool : NSObject
+ (void)loadADData:(void(^)(NSArray<AD*>* data,NSError * error))completion;
@end
