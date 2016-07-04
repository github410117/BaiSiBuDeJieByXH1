//
//  PictureView.h
//  百思不得姐
//
//  Created by etcxm on 16/7/1.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;
@interface PictureView : UIView

@property (nonatomic, strong) DataModel *model;
+ (instancetype)pictureView;
@end
