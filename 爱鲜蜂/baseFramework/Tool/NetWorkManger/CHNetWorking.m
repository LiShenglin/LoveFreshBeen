//
//  CHNetWorking.m
//  baseFramework
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHNetWorking.h"
//AFN自带指示器
#import "AFNetworkActivityIndicatorManager.h"
//AFN入口文件
#import "AFNetworking.h"
//AFN封装的Session管理文件
#import "AFHTTPSessionManager.h"
//加密的公共库
#import <CommonCrypto/CommonDigest.h>


#pragma mark -- 字符串MD5加密,用于参数传递加密
@interface NSString (md5)

+ (NSString *)chnetworking_md5:(NSString *)string;

@end

@implementation NSString (md5)

+ (NSString *)chnetworking_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

@end

#pragma mark -- 接口配置静态变量声明
//
static NSString *sg_privateNetworkBaseUrl = nil;
//是否开启debug打印日志
static BOOL sg_isEnableInterfaceDebug = NO;
//是否自动转码
static BOOL sg_shouldAutoEncode = NO;
//请求头参数
static NSDictionary *sg_httpHeaders = nil;
//默认返回类型
static CHResponseType sg_responseType = kCHResponseTypeJSON;

static CHRequestType  sg_requestType  = kCHRequestTypeJSON;
static CHNetworkStatus sg_networkStatus = kCHNetworkStatusUnknown;
static NSMutableArray *sg_requestTasks;
static BOOL sg_cacheGet = YES;
static BOOL sg_cachePost = NO;
static BOOL sg_shouldCallbackOnCancelRequest = YES;
static NSTimeInterval sg_timeout = 60.0f;
static BOOL sg_shoulObtainLocalWhenUnconnected = NO;

@implementation CHNetWorking
//单例
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sg_requestTasks == nil) {
            sg_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return sg_requestTasks;
}
#pragma mark -- 请求配置:URL公共地址、格式化接口数据打印日志
+ (void)updateBaseUrl:(NSString *)baseUrl {
    sg_privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl {
    return sg_privateNetworkBaseUrl;
}

+ (void)setTimeout:(NSTimeInterval)timeout {
    sg_timeout = timeout;
}

#pragma mark -- 请求头设置、URL编码设置(shouldAutoEncodeUrl默认为NO，YES为自动编码)
+ (void)configRequestType:(CHRequestType)requestType
             responseType:(CHResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest {
    sg_requestType = requestType;
    sg_responseType = responseType;
    sg_shouldAutoEncode = shouldAutoEncode;
    sg_shouldCallbackOnCancelRequest = shouldCallbackOnCancelRequest;
}

+ (BOOL)shouldEncode {
    return sg_shouldAutoEncode;
}

+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    sg_httpHeaders = httpHeaders;
}
#pragma mark -- 请求接口:get、post、图片上传、上传文件、下载文件
/*
 *
 *  GET请求接口，若不指定baseurl，可以传完整url含参数
 *
 */
+ (CHURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                          success:(CHResponseSuccess)success
                             fail:(CHResponseFail)fail {
    return [self getWithUrl:url
               refreshCache:refreshCache
                     params:nil
                    success:success
                       fail:fail];
}
/*
 *
 *  GET请求接口，若不指定baseurl，带参数
 *
 */
+ (CHURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                          success:(CHResponseSuccess)success
                             fail:(CHResponseFail)fail {
    return [self getWithUrl:url
               refreshCache:refreshCache
                     params:params
                   progress:nil
                    success:success
                       fail:fail];
}
/*
 *
 *  GET请求接口，若不指定baseurl，带参数和进度
 *
 */
+ (CHURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                         progress:(CHGetProgress)progress
                          success:(CHResponseSuccess)success
                             fail:(CHResponseFail)fail {
    return [self _requestWithUrl:url
                    refreshCache:refreshCache
                       httpMedth:1
                          params:params
                        progress:progress
                         success:success
                            fail:fail];
}
/*
 *POST请求接口，需完整参数
 */
+ (CHURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                           success:(CHResponseSuccess)success
                              fail:(CHResponseFail)fail {
    return [self postWithUrl:url
                refreshCache:refreshCache
                      params:params
                    progress:nil
                     success:success
                        fail:fail];
}
/*
 *POST请求接口，需完整参数，带进度条
 */
+ (CHURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                          progress:(CHPostProgress)progress
                           success:(CHResponseSuccess)success
                              fail:(CHResponseFail)fail {
    return [self _requestWithUrl:url
                    refreshCache:refreshCache
                       httpMedth:2
                          params:params
                        progress:progress
                         success:success
                            fail:fail];
}

+ (CHURLSessionTask *)_requestWithUrl:(NSString *)url
                          refreshCache:(BOOL)refreshCache
                             httpMedth:(NSUInteger)httpMethod
                                params:(NSDictionary *)params
                              progress:(CHDownloadProgress)progress
                               success:(CHResponseSuccess)success
                                  fail:(CHResponseFail)fail {
    AFHTTPSessionManager *manager = [self manager];
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        
        if (absouluteURL == nil) {
            CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    CHURLSessionTask *session = nil;
    
    if (httpMethod == 1) {
        if (sg_cacheGet) {
            if (sg_shoulObtainLocalWhenUnconnected) {
                if (sg_networkStatus == kCHNetworkStatusNotReachable ||  sg_networkStatus == kCHNetworkStatusUnknown ) {
                    id response = [CHNetWorking cahceResponseWithURL:absolute parameters:params];
                    if (response) {
                        if (success) {
                            [self successResponse:response callback:success];
                            
                            if ([self isDebug]) {
                                [self logWithSuccessResponse:response
                                                         url:absolute
                                                      params:params];
                            }
                        }
                        return nil;
                    }
                }
            }
            if (!refreshCache) {// 获取缓存
                id response = [CHNetWorking cahceResponseWithURL:absolute
                                                       parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if (sg_cacheGet) {
                [self cacheResponseObject:responseObject request:task.currentRequest parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && sg_cacheGet) {// 获取缓存
                id response = [CHNetWorking cahceResponseWithURL:absolute
                                                       parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    } else if (httpMethod == 2) {
        if (sg_cachePost ) {// 获取缓存
            if (sg_shoulObtainLocalWhenUnconnected) {
                if (sg_networkStatus == kCHNetworkStatusNotReachable ||  sg_networkStatus == kCHNetworkStatusUnknown ) {
                    id response = [CHNetWorking cahceResponseWithURL:absolute
                                                           parameters:params];
                    if (response) {
                        if (success) {
                            [self successResponse:response callback:success];
                            
                            if ([self isDebug]) {
                                [self logWithSuccessResponse:response
                                                         url:absolute
                                                      params:params];
                            }
                        }
                        return nil;
                    }
                }
            }
            if (!refreshCache) {
                id response = [CHNetWorking cahceResponseWithURL:absolute
                                                       parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if (sg_cachePost) {
                [self cacheResponseObject:responseObject request:task.currentRequest  parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && sg_cachePost) {// 获取缓存
                id response = [CHNetWorking cahceResponseWithURL:absolute
                                                       parameters:params];
                
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    }
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CHURLSessionTask *)uploadFileWithUrl:(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(CHUploadProgress)progress
                                 success:(CHResponseSuccess)success
                                    fail:(CHResponseFail)fail {
    if ([NSURL URLWithString:uploadingFile] == nil) {
        CHAppLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
        return nil;
    }
    
    NSURL *uploadURL = nil;
    if ([self baseUrl] == nil) {
        uploadURL = [NSURL URLWithString:url];
    } else {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]];
    }
    
    if (uploadURL == nil) {
        CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
        return nil;
    }
    
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    CHURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        [self successResponse:responseObject callback:success];
        
        if (error) {
            [self handleCallbackWithError:error fail:fail];
            
            if ([self isDebug]) {
                [self logWithFailError:error url:response.URL.absoluteString params:nil];
            }
        } else {
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:response.URL.absoluteString
                                      params:nil];
            }
        }
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CHURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(CHUploadProgress)progress
                               success:(CHResponseSuccess)success
                                  fail:(CHResponseFail)fail {
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    AFHTTPSessionManager *manager = [self manager];
    CHURLSessionTask *session = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allTasks] removeObject:task];
        [self successResponse:responseObject callback:success];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allTasks] removeObject:task];
        
        [self handleCallbackWithError:error fail:fail];
        
        if ([self isDebug]) {
            [self logWithFailError:error url:absolute params:nil];
        }
    }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CHURLSessionTask *)downloadWithUrl:(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(CHDownloadProgress)progressBlock
                               success:(CHResponseSuccess)success
                               failure:(CHResponseFail)failure {
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            CHAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self manager];
    
    CHURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        if (error == nil) {
            if (success) {
                success(filePath.absoluteString);
            }
            
            if ([self isDebug]) {
                CHAppLog(@"Download success for url %@",
                          [self absoluteUrlWithPath:url]);
            }
        } else {
            [self handleCallbackWithError:error fail:failure];
            
            if ([self isDebug]) {
                CHAppLog(@"Download fail for url %@, reason : %@",
                          [self absoluteUrlWithPath:url],
                          [error description]);
            }
        }
    }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
#pragma mark -- 取消请求
+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(CHURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[CHURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(CHURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[CHURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

#pragma mark -- 缓存操作:开启缓存、缓存总大小、清除缓存
//读取当前debug/发布状态
+ (BOOL)isDebug {
    return sg_isEnableInterfaceDebug;
}
//设置debug/发布模式
+ (void)enableInterfaceDebug:(BOOL)isDebug {
    sg_isEnableInterfaceDebug = isDebug;
}

//网络异常，设置是否从本地获取加载数据
+ (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain {
sg_shoulObtainLocalWhenUnconnected = shouldObtain;
}
//设置getpost是否开启缓存
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost {
    sg_cacheGet = isCacheGet;
    sg_cachePost = shouldCachePost;
}


+ (void)clearCaches {
    NSString *directoryPath = cachePath();
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if (error) {
            NSLog(@"CHNetworking clear caches error: %@", error);
        } else {
            NSLog(@"CHNetworking clear caches ok");
        }
    }
}

+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}
static inline NSString *cachePath() {
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CHNetworkingCaches"];
    
}

#pragma mark - Private
+ (AFHTTPSessionManager *)manager {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = nil;;
    if ([self baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    
    switch (sg_requestType) {
        case kCHRequestTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case kCHRequestTypePlainText: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    switch (sg_responseType) {
        case kCHResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kCHResponseTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case kCHResponseTypeData: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    
    for (NSString *key in sg_httpHeaders.allKeys) {
        if (sg_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:sg_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    manager.requestSerializer.timeoutInterval = sg_timeout;
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    if (sg_shoulObtainLocalWhenUnconnected && (sg_cacheGet || sg_cachePost ) ) {
        [self detectNetwork];
    }
    return manager;
}

+ (void)detectNetwork{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable){
            sg_networkStatus = kCHNetworkStatusNotReachable;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            sg_networkStatus = kCHNetworkStatusUnknown;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            sg_networkStatus = kCHNetworkStatusReachableViaWWAN;
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            sg_networkStatus = kCHNetworkStatusReachableViaWiFi;
        }
    }];
}

+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    CHAppLog(@"\n");
    CHAppLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              params,
              [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    CHAppLog(@"\n");
    if ([error code] == NSURLErrorCancelled) {
        CHAppLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params);
    } else {
        CHAppLog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params,
                  [error localizedDescription]);
    }
}

// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}


+ (NSString *)encodeUrl:(NSString *)url {
    return [self ch_URLEncode:url];
}

+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (void)successResponse:(id)responseData callback:(CHResponseSuccess)success {
    if (success) {
        success([self tryToParseData:responseData]);
    }
}

+ (NSString *)ch_URLEncode:(NSString *)url {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return url;
}

+ (id)cahceResponseWithURL:(NSString *)url parameters:params {
    id cacheData = nil;
    
    if (url) {
        // Try to get datas from disk
        NSString *directoryPath = cachePath();
        NSString *absoluteURL = [self generateGETAbsoluteURL:url params:params];
        NSString *key = [NSString chnetworking_md5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data) {
            cacheData = data;
            CHAppLog(@"Read data from cache for url: %@\n", url);
        }
    }
    
    return cacheData;
}

+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:params {
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = cachePath();
        
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error) {
                CHAppLog(@"create cache dir error: %@\n", error);
                return;
            }
        }
        
        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
        NSString *key = [NSString chnetworking_md5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        
        if (data && error == nil) {
            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            if (isOk) {
                CHAppLog(@"cache file ok for request: %@\n", absoluteURL);
            } else {
                CHAppLog(@"cache file error for request: %@\n", absoluteURL);
            }
        }
    }
}

+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([[self baseUrl] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseUrl], mutablePath];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }
        }else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseUrl], path];
            }
        }
    }
    return absoluteUrl;
}

+ (void)handleCallbackWithError:(NSError *)error fail:(CHResponseFail)fail {
    if ([error code] == NSURLErrorCancelled) {
        if (sg_shouldCallbackOnCancelRequest) {
            if (fail) {
                fail(error);
            }
        }
    } else {
        if (fail) {
            fail(error);
        }
    }
}

@end
