//
//  NetworkingDemo.m
//  baseFramework
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "NetworkingDemo.h"
#import "CHNetWorking.h"

@implementation NetworkingDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置基础URL
    [CHNetWorking updateBaseUrl:@"http://apistore.baidu.com"];
    [CHNetWorking enableInterfaceDebug:YES];
    
    //设置get/post都缓存
    [CHNetWorking cacheGetRequest:YES shoulCachePost:YES];
    
    
    //测试post/api
    NSString *url = @"http://apistore.baidu.com/microservice/cityinfo?cityname=beijing";
    [CHNetWorking getWithUrl:url refreshCache:NO params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"progress: %f, cur: %lld, total: %lld",
              (bytesRead * 1.0) / totalBytesRead,
              bytesRead,
              totalBytesRead);
    } success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
    
    //POST 假数据
    NSDictionary *postDict = @{ @"urls": @"http://www.henishuo.com/git-use-inwork/",
                                @"goal" : @"site",
                                @"total" : @(123)
                                };
    NSString *path = @"/urls?site=www.henishuo.com&token=bRidefmXoNxIi3Jp";
    
    // 由于这里有两套基础路径，用时就需要更新
    [CHNetWorking updateBaseUrl:@"http://data.zz.baidu.com"];
    // 每次刷新缓存
    // 如果获取到的业务数据是不正确的，则需要下次调用时设置为YES,表示要刷新缓存
    // HYBURLSessionTask *task =
    [CHNetWorking postWithUrl:path refreshCache:YES params:postDict success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
    
    // 取消全部请求
    //  [HYBNetworking cancelAllRequest];
    
    // 取消单个请求方法一
    //  [HYBNetworking cancelRequestWithURL:path];
    
    // 取消单个请求方法二
    //  [task cancel];
    
    NSLog(@"----缓存%lld", [CHNetWorking totalCacheSize]);
    //  [HYBNetworking clearCaches];
    
    path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/b.zip"];
    [CHNetWorking downloadWithUrl:@"http://wiki.lbsyun.baidu.com/cms/iossdk/sdk/BaiduMap_IOSSDK_v2.10.2_All.zip" saveToPath:path progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
    } success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
    //读取应用缓存
    NSLog(@"----缓存%lld", [CHNetWorking totalCacheSize]);
    
    //测试从百度下载数据
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [CHNetWorking clearCaches];
    NSLog(@"----缓存%lld", [CHNetWorking totalCacheSize]);
    
}
@end
