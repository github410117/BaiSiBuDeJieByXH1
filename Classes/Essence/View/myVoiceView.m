//
//  VoiceView.m
//  百思不得姐
//
//  Created by xh on 16/7/2.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "myVoiceView.h"
#import "DataModel.h"

@interface myVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end

@implementation myVoiceView

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setModel:(DataModel *)model {
    _model = model;
    self.playCount.text = [NSString stringWithFormat:@"%ld播放",(long)_model.playcount];
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld", _model.voicetime / 60, _model.voicetime % 60];
}

@end
