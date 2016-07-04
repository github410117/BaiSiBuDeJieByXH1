//
//  VideoView.m
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "myVideoView.h"
#import "DataModel.h"
//krv必须的框架
#import "KRVideoPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"

@interface myVideoView ()
- (IBAction)playBtnAction:(UIButton *)sender;//播放按钮事件
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;//视频的显示图片
@property (weak, nonatomic) IBOutlet UIButton *playBtn;//播放按钮
@property (weak, nonatomic) IBOutlet UILabel *playCount;//播放次数
@property (weak, nonatomic) IBOutlet UILabel *playTime;//播放时间
@property (nonatomic, strong) KRVideoPlayerController *videoController;//krv



@end

@implementation myVideoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.videoImage.userInteractionEnabled = YES;
//    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}


- (void)setAllModel:(DataModel *)allModel {
    _allModel = allModel;
    NSString *str = [NSString stringWithFormat:@"%ld播放",_allModel.playcount];
    CGFloat contentW = [str boundingRectWithSize:CGSizeMake(300,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
    //设置播放次数
    self.playCount.text = str;
    CGRect frame = self.playCount.frame;
    frame.size.width = contentW;
    
    self.playCount.frame = frame;
    //设置播放器封面图片
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:_allModel.cdn_img]];
    //设置视频时长
    self.playTime.text = [NSString stringWithFormat:@"0%ld:%02ld",_allModel.videotime / 60, _allModel.videotime % 60];

    
}

/**
 *  播放按钮
 */
- (IBAction)playBtnAction:(UIButton *)sender {
    [self playVideoWithURL:[NSURL URLWithString:_allModel.videouri]];
    //将krv的view加到self上，self本身为view，注意要.view
    [self addSubview:self.videoController.view];
}


- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:self.videoImage.bounds];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
    }
    self.videoController.contentURL = url;
}
@end
