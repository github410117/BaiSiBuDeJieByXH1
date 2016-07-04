//
//  myContentCell.m
//  百思不得姐
//
//  Created by xh on 16/7/2.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "myContentCell.h"
#import "DataModel.h"
#import "PictureView.h"
#import "myVoiceView.h"
#import "myVideoView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+AFNetworking.h"

@interface myContentCell ()
@property (weak, nonatomic) IBOutlet UIButton *headImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//ID昵称

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *content;//正文
@property (weak, nonatomic) IBOutlet UILabel *hotComment;//热评
@property (weak, nonatomic) IBOutlet UIButton *zan;
@property (weak, nonatomic) IBOutlet UIButton *cai;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIView *hotCommentView;


@property (nonatomic, strong) PictureView *pictureView;
@property (nonatomic, strong) myVoiceView *myVoiceView;
@property (nonatomic, strong) myVideoView *myVideoView;

@end

@implementation myContentCell



- (void)setDataFrame:(DataFrame *)dataFrame {
    _dataFrame = dataFrame;
    DataModel *model = dataFrame.model;
    [self.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:model.profile_image] forState:UIControlStateNormal];
    self.userName.text = model.name;
    self.releaseTime.text = model.created_at;
    self.content.text = model.text;
    [self.zan setTitle:[NSString stringWithFormat:@"%ld",model.ding] forState:UIControlStateNormal];
    [self.cai setTitle:[NSString stringWithFormat:@"%ld",model.cai] forState:UIControlStateNormal];
    [self.share setTitle:[NSString stringWithFormat:@"%ld",model.repost] forState:UIControlStateNormal];
    [self.comment setTitle:[NSString stringWithFormat:@"%ld",model.comment] forState:UIControlStateNormal];
    //热评
    if (model.cmtModel) {
        self.hotCommentView.hidden = NO;
        self.hotComment.text = [NSString stringWithFormat:@"%@ : %@", model.cmtModel.user.username, model.cmtModel.content];
    }else {
        self.hotCommentView.hidden = YES;
    }
    
    switch (model.type) {
        case TypeRecommend: {
            self.pictureView.hidden = YES;
            self.myVideoView.hidden = YES;
            self.myVoiceView.hidden = YES;
            break;
        }
        case TypeImage: {
            self.pictureView.model = model;
            self.pictureView.frame  = dataFrame.viewFrame;
            self.pictureView.hidden = NO;
            self.myVoiceView.hidden = YES;
            self.myVideoView.hidden = YES;
            break;
        }
        case TypeTalk: {
            self.pictureView.hidden = YES;
            self.myVideoView.hidden = YES;
            self.myVoiceView.hidden = YES;
            break;
        }
        case TypeVoice: {
            self.myVoiceView.model = model;
            self.myVoiceView.frame  = dataFrame.viewFrame;
            self.myVoiceView.hidden = NO;
            self.pictureView.hidden = YES;
            self.myVideoView.hidden = YES;
            break;
        }
        case TypeVideo: {
            self.myVideoView.allModel = model;
            self.myVideoView.frame  = dataFrame.viewFrame;
            NSLog(@"%@",NSStringFromCGRect(dataFrame.viewFrame));
//            self.myVideoView.frame = CGRectMake(0, 0, 100, 20);
            self.myVideoView.hidden = NO;
            self.pictureView.hidden = YES;
            self.myVoiceView.hidden = YES;
            break;
        }
    }
}


//重新设置尺寸
//-(void)setFrame:(CGRect)frame {
//    CGFloat inset = 10;
//    frame.size.height -= inset;
//    frame.origin.y += inset;
//    [super setFrame:frame];
//}

- (PictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [PictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (myVideoView *)myVideoView
{
    if (!_myVideoView) {
        _myVideoView = [myVideoView videoView];
        [self.contentView addSubview:_myVideoView];
    }
    return _myVideoView;
}

- (myVoiceView *)myVoiceView
{
    if (!_myVoiceView) {
        _myVoiceView = [myVoiceView voiceView];
        [self.contentView addSubview:_myVoiceView];
    }
    return _myVoiceView;
}





















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
