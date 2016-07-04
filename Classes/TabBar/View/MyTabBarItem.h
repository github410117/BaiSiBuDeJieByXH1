//
//  MyTabBarItem.h
//  TeamDemo
//
//  Created by etcxm on 16/6/3.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarModel.h"

@interface MyTabBarItem : UITabBarItem

//@property (nonatomic, strong) TabBarModel *tabBarModel;

- (instancetype)initWithTabBarModel:(TabBarModel *)tabBarModel;

@end
