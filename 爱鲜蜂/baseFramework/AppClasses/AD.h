//
//  AD.h
//  baseFramework
//
//  Created by chenangel on 16/6/23.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AD : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * img_name;
@property(nonatomic,copy)NSString * starttime;
@property(nonatomic,copy)NSString * endtime;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
