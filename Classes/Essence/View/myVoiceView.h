//
//  VoiceView.h
//  百思不得姐
//
//  Created by xh on 16/7/2.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;
@interface myVoiceView : UIView

@property (nonatomic, strong) DataModel *model;

+ (instancetype)voiceView;

@end
