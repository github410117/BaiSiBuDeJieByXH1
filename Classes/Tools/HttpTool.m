//
//  HttpTool.m
//  百思不得姐
//
//  Created by xh on 16/6/29.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "HttpTool.h"


@implementation HttpTool

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(success)success failure:(error)failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 %@",error);
    }];
}

@end
