//
//  FreshHotTool.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "FreshHotTool.h"

@implementation FreshHotTool
+ (void)loadFreshHotData:(void(^)(NSArray<Good*>* HotData,NSError * error))completion{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页新鲜热卖" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArr = dict[@"data"];
        
        NSArray<Good*> *result = [Good mj_objectArrayWithKeyValuesArray:dataArr];
        
        completion(result,nil);
        
    }
}

@end
