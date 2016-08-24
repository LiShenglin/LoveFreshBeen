//
//  UIImageView+Download.m
//  baseFramework
//
//  Created by chenangel on 16/6/7.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UIImageView+Download.h"
#import <AFNetworking.h>
@implementation UIImageView (Download)
/*
 sd_setImageWithURL:placeholderImage:方法的执行步骤
 1.取消当前imageView之前关联的请求
 2.设置占位图片到当前imageView上面
 3.如果缓存中有对应的图片，那么就显示到当前imageView上面
 4.如果缓存中没有对应的图片，发送请求给服务器下载图片
 */

/**
 *   图片下载优化、根据网络状态下载不同图片
 *
 *  @param originalImageURL  originalImageURL 原始图
 *  @param thumbnailImageURL thumbnailImageURL 缩略图
 *  @param placeholderImage  placeholderImage 占位图
 *  @param completedBlock    completedBlock 完成后执行的操作
 */
- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage options:(SDWebImageOptions)option progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock{
    //从内存、沙河获取图片
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageURL];
    if (originalImage) {//如果内存\沙河缓存有原图，那么就直接显示原图（不管现在什么网络状态）
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] completed:completedBlock];
    }else{//内存、沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        
        if (mgr.isReachableViaWiFi) {//wifi模式下载大图
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage options:option progress:progressBlock completed:completedBlock];
            
        }else if (mgr.isReachableViaWWAN){//使用手机自带的网络
#warning 从沙盒中读取用户的配置项：在3G、4G环境是否仍然下载原因
            //            //设置总是获取大图
            //            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
            //    [[NSUserDefaults standardUserDefaults] synchronize];
            //            //读取偏好设置，看是否获取大图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            if(alwaysDownloadOriginalImage){//下载原图
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage options:option progress:progressBlock completed:completedBlock];
            } else{//下载小图
            [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage options:option progress:progressBlock completed:completedBlock];
            }
        }else{//没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) {//内存、沙盒缓存中有小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
            }else{
                [self sd_setImageWithURL:nil placeholderImage:placeholderImage completed:completedBlock];
            }
            
        }
    }
    
}


- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock{
    
    
    //从内存、沙河获取图片
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageURL];
    if (originalImage) {//如果内存\沙河缓存有原图，那么就直接显示原图（不管现在什么网络状态）
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] completed:completedBlock];
    }else{//内存、沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        //开启网络状态监听，此句一般放在appdelegate处
        [mgr startMonitoring];
        
        if (mgr.isReachableViaWiFi) {//wifi模式下载大图
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
        }else if (mgr.isReachableViaWWAN){//使用手机自带的网络
#warning 从沙盒中读取用户的配置项：在3G、4G环境是否仍然下载原因
//            //设置总是获取大图
//            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
            //    [[NSUserDefaults standardUserDefaults] synchronize];
//            //读取偏好设置，看是否获取大图
       BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
#warning 真实项目中才去掉下面一句
            alwaysDownloadOriginalImage = YES;
            if(alwaysDownloadOriginalImage){//下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
            } else{//下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
            }
        }else{//没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) {//内存、沙盒缓存中有小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
            }else{
                [self sd_setImageWithURL:nil placeholderImage:placeholderImage completed:completedBlock];
            }
            
        }
    }
}
/**
 *  没有展位图，也没有回调
 *
 *  @param originalImageURL
 *  @param thumbnailImageURL
 */
- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL{
    [self ch_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:nil completed:nil];
}
/**
 *  没有展位图的，下载回调操作
 *
 *  @param originalImageURL
 *  @param thumbnailImageURL
 *  @param completedBlock
 */
- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock{
    [self ch_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:nil completed:completedBlock];
}



@end
