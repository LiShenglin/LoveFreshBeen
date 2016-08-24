//
//  FileTool.m
//  baseFramework
//
//  Created by chenangel on 16/6/22.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "FileTool.h"

@interface FileTool()
@property (nonatomic,strong) NSFileManager * fileManager;
@end
@implementation FileTool
SingleM(FileTool)

- (NSFileManager *)fileManager{
    if (_fileManager == nil) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}
/// 计算单个文件的大小
- (CGFloat)fileSize:(NSString *)path {
    
    if ([self.fileManager fileExistsAtPath:path]) {
        NSDictionary * dict = [self.fileManager attributesOfItemAtPath:path error:nil];
        NSInteger fileSize = (NSInteger)dict[NSFileSize];
        if (fileSize){
            return fileSize / 1024.0 / 1024.0;
        }
    }
    return 0.0;
}

/// 计算整个文件夹的大小
- (CGFloat)folderSize:(NSString *)path {
    CGFloat folderSize = 0.0;
    
    if([self.fileManager fileExistsAtPath:path]) {
        NSArray<NSString *> * chilerFiles = [self.fileManager subpathsAtPath:path];
        for (NSString *fileName in chilerFiles) {
            NSString *tmpPath = path;
            NSString *fileFullPathName = [tmpPath stringByAppendingPathComponent:fileName];
            
            folderSize += [self fileSize:fileFullPathName];
        }
        return folderSize;
    }
    return 0;
}

/// 清除文件 同步
- (void)cleanFolder:(NSString *)path complete:(void(^)())completeBlock {
    
    NSArray * chilerFiles = [self.fileManager subpathsAtPath:path];
    for (NSString *fileName in chilerFiles){
        NSString * tmpPath = path;
        NSString *fileFullPathName = [tmpPath stringByAppendingPathComponent:fileName];
        if ([self.fileManager fileExistsAtPath:fileFullPathName]) {
            [self.fileManager removeItemAtPath:fileFullPathName error:nil];
        }
    }
    if (completeBlock) {
        completeBlock();
    }
}


/**
 *  清楚文件 异步
 */

- (void)cleanFolderAsync:(NSString *)path complete:(void(^)())completeBlock {
    dispatch_queue_t queue = dispatch_queue_create("cleanQueue", nil);
    dispatch_async(queue, ^{
        NSArray * chilerFiles = [self.fileManager subpathsAtPath:path];
        
        for (NSString *filename in chilerFiles) {
            NSString *fileFullPathName = [path stringByAppendingPathComponent:filename];
            if ([self.fileManager fileExistsAtPath:fileFullPathName]) {
                [self.fileManager removeItemAtPath:fileFullPathName error:nil];
            }
            
        }
        
        if (completeBlock) {
            completeBlock();
        }
    });
}




@end
