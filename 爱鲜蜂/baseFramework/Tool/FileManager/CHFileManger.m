//
//  CHFileManger.m
//  baseFramework
//
//  Created by chenangel on 16/5/30.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHFileManger.h"
@implementation CHFileManger
/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getDirectorySize:(NSString *)directoryPath{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
            //抛出异常
        NSException *excep =[NSException exceptionWithName:@"FilePathRrror:" reason:@"你输入的不是文件或者文件不存在！" userInfo:nil];
        [excep raise];
    }
    
    NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
    NSInteger totalSize = 0 ;
    
    for (NSString *filepath in subpaths) {
        //拼接全路径
        NSString *subpath = [directoryPath stringByAppendingPathComponent:filepath];

        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        
        if (!isExist || !isDirectory) continue;
        
        if ([subpath containsString:@".DS"]) continue;
        
        //获取文件目录下的大小
            NSDictionary *attr = [mgr attributesOfItemAtPath:
                                  subpath error:nil];
            long long size = [attr fileSize];
            totalSize += size;
    }
    return totalSize;
}
+ (NSString *)getCacheSize{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSInteger totalSize = [self getDirectorySize:cache];
    NSString *str = @"清除缓存";
    if (totalSize > 1000 * 1000) { // MB
        CGFloat totalSizeF = totalSize / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)",str,totalSizeF];
    } else if (totalSize > 1000) { // KB
        CGFloat totalSizeF = totalSize / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fKB)",str,totalSizeF];
    } else if (totalSize > 0) { // B
        str = [NSString stringWithFormat:@"%@(%ldB)",str,totalSize];
    }
    
    return str;
}


/**
 *  删除指定文件夹
 *
 *  @param directoryPath 文件夹
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectroy;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectroy];
    if (!isExist || !isDirectroy) {
        NSException *excep =[NSException exceptionWithName:@"FilePathRrror:" reason:@"你输入的不是文件或者文件不存在！" userInfo:nil];
        [excep raise];
    }
    
    NSArray *subpaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *FileStr in subpaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:FileStr];
        [mgr removeItemAtPath:filePath error:nil];
    }
}

//清除缓存
+ (void)clearCache{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [self removeDirectoryPath:cache];
}
//快速搬迁文件
+ (void)moveFileFromPath:(NSString *)fromPath toFilePath:(NSString *)toFilePath{
    NSArray *subpaths = [[NSFileManager defaultManager] subpathsAtPath:fromPath];
    NSInteger count = subpaths.count;
    dispatch_apply(count,  dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSString *fromFullPath = [fromPath stringByAppendingPathComponent:subpaths[index]];
        NSString *toFullPath = [toFilePath stringByAppendingPathComponent:subpaths[index]];
        [[NSFileManager defaultManager] moveItemAtPath:fromFullPath toPath:toFullPath error:nil];
    });
}

@end
