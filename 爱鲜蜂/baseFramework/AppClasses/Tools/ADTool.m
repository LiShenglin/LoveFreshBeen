//
//  ADTool.m
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ADTool.h"
#import "AD.h"
@implementation ADTool
+ (void)loadADData:(void(^)(NSArray<AD*>* data,NSError * error))completion{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AD" ofType:nil];
    NSData * data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray * resultData = dict[@"data"];
        NSMutableArray * ADData = [AD mj_objectArrayWithKeyValuesArray:resultData]
;
        
        completion(ADData,nil);
        
    }
    
}

@end
