//
//  UILabel+adaption.m
//  百思不得姐
//
//  Created by xh on 16/6/27.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "UILabel+adaption.h"

@implementation UILabel (adaption)
/**
 *  UILbal高度自适应
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
/**
 *  UILabel宽度自适应
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
