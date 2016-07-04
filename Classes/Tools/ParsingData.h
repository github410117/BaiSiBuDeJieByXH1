//
//  ParsingData.h
//  百思不得姐
//
//  Created by xh on 16/6/29.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

//推荐刷新的block
typedef void(^RecommendBlock)(id json,id param);
@interface ParsingData : NSObject

/**
 *  推荐页刷新
 *
 *  @param type      请求类型
 *  @param parameter 请求参数
 *  @param block     回调
 */
+ (void)getDataType:(TitleType)type parameter:(NSString *)parameter block:(RecommendBlock)block;

@end
