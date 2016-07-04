//
//  VideoView.h
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;
@interface myVideoView : UIView
@property (nonatomic, strong) DataModel *allModel;

+ (instancetype)videoView;
@end
