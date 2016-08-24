//
//  HeadResoureTool.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeHeadData;
@interface HeadResoureTool : NSObject
+ (void)loadHomeHeadData:(void(^)(HomeHeadData *,NSError*))completion;

@end
