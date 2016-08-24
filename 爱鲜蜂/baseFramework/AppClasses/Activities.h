//
//  Activities.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 首页焦点按钮
 */
@interface Activities : NSObject
@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * img;
@property(nonatomic,copy) NSString * topimg;
@property(nonatomic,copy) NSString * jptype;
@property(nonatomic,copy) NSString * trackid;
@property(nonatomic,copy) NSString * mimg;
@property(nonatomic,copy) NSString * customURL;

//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
