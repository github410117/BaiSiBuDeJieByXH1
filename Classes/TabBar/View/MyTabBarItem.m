//
//  MyTabBarItem.m
//  TeamDemo
//
//  Created by etcxm on 16/6/3.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MyTabBarItem.h"

@implementation MyTabBarItem

- (instancetype)initWithTabBarModel:(TabBarModel *)tabBarModel
{
    if (self = [super init]) {
        self.title = tabBarModel.title;
        //设置item字体的颜色
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil];
        [self setTitleTextAttributes:dic forState:UIControlStateNormal];
        //设置item选中后字体的颜色
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor] ,NSForegroundColorAttributeName, nil];
        [self setTitleTextAttributes:dic1 forState:UIControlStateSelected];
        if (tabBarModel.title.length == 0) {
            self.image = GetImage(tabBarModel.image);
            self.selectedImage = GetImage(tabBarModel.selected);
            self.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else {
        self.image = GetImage(tabBarModel.image);
        self.selectedImage = GetImage(tabBarModel.selected);
        //设置显示真实图片，而不是默认蓝色
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    return self;
}

@end
