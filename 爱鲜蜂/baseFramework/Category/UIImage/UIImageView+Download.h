//
//  UIImageView+Download.h
//  baseFramework
//
//  Created by chenangel on 16/6/7.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Download)
/**
 *   图片下载优化、根据网络状态下载不同图片
 *
 *  @param originalImageURL  originalImageURL 原始图
 *  @param thumbnailImageURL thumbnailImageURL 缩略图
 *  @param placeholderImage  placeholderImage 占位图
 *  @param completedBlock    completedBlock 完成后执行的操作
 */
-(void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *   带进度回调，图片下载优化、根据网络状态下载不同图片
 *
 *  @param originalImageURL  originalImageURL description
 *  @param thumbnailImageURL thumbnailImageURL description
 *  @param placeholderImage  placeholderImage description
 *  @param progressBlock     progressBlock description
 *  @param completedBlock    completedBlock description
 */
- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage options:(SDWebImageOptions)option progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;


/**
 *  没有展位图，也没有回调
 *
 *  @param originalImageURL
 *  @param thumbnailImageURL
 */
- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL;
/**
 *  没有展位图的，下载回调操作
 *
 *  @param originalImageURL
 *  @param thumbnailImageURL
 *  @param completedBlock
 */
- (void)ch_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock;


@end
