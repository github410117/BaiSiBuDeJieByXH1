//
//  HttpTool.h
//  百思不得姐
//
//  Created by xh on 16/6/29.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(id json);
typedef void(^error)(NSError *error);
@interface HttpTool : NSObject
/**
 *  get请求接口
 *
 *  @param url        请求api网址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(success)success failure:(error)failure;
@end
