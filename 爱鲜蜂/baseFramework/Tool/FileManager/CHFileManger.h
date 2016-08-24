//
//  CHFileManger.h
//  baseFramework
//
//  Created by chenangel on 16/5/30.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHFileManger : NSObject

/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getDirectorySize:(NSString *)directoryPath;

/**
 *  删除指定文件夹
 *
 *  @param directoryPath 文件夹
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;



//计算缓存大小修饰过名称
+ (NSString *)getCacheSize;

//清除缓存
+ (void)clearCache;

/**
 *  GCD文件快速搬迁
 *
 *  @param fromPath   从指定文件路径
 *  @param toFilePath 搬到指定文件路径
 */
+ (void)moveFileFromPath:(NSString *)fromPath toFilePath:(NSString *)toFilePath;

@end
