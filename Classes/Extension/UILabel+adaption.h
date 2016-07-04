//
//  UILabel+adaption.h
//  百思不得姐
//
//  Created by xh on 16/6/27.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (adaption)

//高度自适应
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
//宽度自适应
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
