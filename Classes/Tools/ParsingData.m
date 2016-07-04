//
//  ParsingData.m
//  百思不得姐
//
//  Created by xh on 16/6/29.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "ParsingData.h"
#import "HttpTool.h"
#import "DataModel.h"

@implementation ParsingData

+ (void)getDataType:(TitleType)type parameter:(NSString *)parameter block:(RecommendBlock)block {
    NSMutableDictionary *parameterDic = [NSMutableDictionary dictionary];
    //请求必须参数
    parameterDic[@"a"] = parameter;
    parameterDic[@"c"] = @"data";
    parameterDic[@"type"] = @(type);//type转换为数字对应类型
    
    [HttpTool get:APIUrl parameters:parameterDic success:^(id json) {
        //这里之所以可以直接使用字典转数组，是因为在调用Http中的block时AFNetworking已经自动解析了json为字典
        NSArray *array = [DataModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        NSString *str = json[@"info"][@"maxtime"];//双层字典相当于2个objectForKey
        block(array,str);
    } failure:^(NSError *error) {
        NSLog(@"请求失败 %@",error);
    }];
}


+ (void)getDataWithMaxTime:(NSString *)maxtime page:(NSNumber *)page titleType:(TitleType)type parameter:(NSString *)parameter block:(RecommendBlock)block {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = parameter;
    params[@"c"] = @"data";
    params[@"type"] = @(type);
    params[@"page"] = page;
    params[@"maxtime"] = maxtime;
    
    [HttpTool get:APIUrl parameters:params success:^(id json) {
        NSArray *array = [DataModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        NSString *maxtime = json[@"info"][@"maxtime"];
        block(array,maxtime);
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

@end
