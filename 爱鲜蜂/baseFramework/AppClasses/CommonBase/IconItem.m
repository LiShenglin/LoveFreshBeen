//
//  iconsViewItem.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "IconItem.h"

@implementation IconItem
- (instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
