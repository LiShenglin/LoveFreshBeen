//
//  HeadResoureTool.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HeadResoureTool.h"
#import "Activities.h"
#import "HomeHeadData.h"
@implementation HeadResoureTool
+ (void)loadHomeHeadData:(void(^)(HomeHeadData *,NSError*))completion{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页焦点按钮" ofType:nil];
    NSData * data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary * headData = dict[@"data"];
        id mappins = SFBeginPropertyMappingWithClass(HomeHeadData)
        SFMappingPropertyToClass(focus, Activities)
        SFMappingPropertyToClass(icons, Activities)
        SFMappingPropertyToClass(activities, Activities)
        SFEndPropertyMapping;

        HomeHeadData *allheadData = [HomeHeadData sf_objectFromDictionary:headData mapping:mappins];
        
        completion(allheadData,nil);
        
    }
    
}



@end
