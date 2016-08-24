//
//  HomeHeadData.h
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activities.h"
/**
 *  首页总广告
 */
@interface HomeHeadData : NSObject
//焦点广告
@property(nonatomic,strong) NSArray<Activities *>* focus;
//焦点按钮
@property(nonatomic,strong) NSArray<Activities *>* icons;
//广告大图
@property(nonatomic,strong) NSArray<Activities *>* activities;


@end
