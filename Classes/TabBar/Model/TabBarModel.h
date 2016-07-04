//
//  TabBarModel.h
//  TeamDemo
//
//  Created by etcxm on 16/6/3.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TabBarModel : NSObject
/**
 *  TabBar按钮图标
 */
@property (nonatomic, strong) NSString *image;

/**
 *  TabBar文字
 */
@property (nonatomic, strong) NSString *title;
/**
 *  TabBar选中图标
 */
@property (nonatomic, strong) NSString *selected;




@end
