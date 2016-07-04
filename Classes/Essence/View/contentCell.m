//
//  contentCell.m
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "contentCell.h"
#import "UIButton+WebCache.h"
#import "DataModel.h"
#import "PictureView.h"
#import "myVoiceView.h"
#import "myVideoView.h"


@interface contentCell ()
@property (weak, nonatomic) IBOutlet UIButton *headImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//用户昵称
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *content;//正文
@property (weak, nonatomic) IBOutlet UIImageView *videoOrVoice;
@property (weak, nonatomic) IBOutlet UILabel *hotComment;//热评
@property (weak, nonatomic) IBOutlet UIButton *praise;//赞
@property (weak, nonatomic) IBOutlet UIButton *stamp;//踩
@property (weak, nonatomic) IBOutlet UIButton *share;//分享
@property (weak, nonatomic) IBOutlet UIButton *allComment;//所有评论
@property (weak, nonatomic) IBOutlet UIView *hotCommentView;//热评的View

@property (nonatomic, strong) PictureView *pictureView;
@property (nonatomic, strong) myVoiceView *myVoiceView;
@property (nonatomic, strong) myVideoView *myVideoView;



@end

@implementation contentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setData:(DataModel *)inModel {
    _model = inModel;
    //设置头像
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_model.profile_image] forState:UIControlStateNormal];
    
    _userName.text = _model.name;//设置昵称
    _releaseTime.text = _model.created_at;//设置发布时间
    _content.text = _model.text;//设置段子正文
    
    [_praise setTitle:[NSString stringWithFormat:@"%ld",_model.ding] forState:UIControlStateNormal];//顶
    [_stamp setTitle:[NSString stringWithFormat:@"%ld",_model.cai] forState:UIControlStateNormal];//踩
    [_share setTitle:[NSString stringWithFormat:@"%ld",_model.repost] forState:UIControlStateNormal];//转发
    [_allComment setTitle:[NSString stringWithFormat:@"%ld",_model.comment] forState:UIControlStateNormal];//评论
    
//    看有无热评
    if (_model.cmtModel) {
        //有热评
        _hotCommentView.hidden = NO;
        _hotComment.text = [NSString stringWithFormat:@"%@ : %@",_model.cmtModel.user.username,_model.cmtModel.content];
    }else {
        _hotCommentView.hidden = YES;
    }
    
//    根据传入的类型来判断有无视频，就可以hidden掉imageView
    switch (_model.type) {
        case TypeRecommend: {
            self.pictureView.hidden = YES;
            self.myVideoView.hidden = YES;
            self.myVoiceView.hidden = YES;
            break;
        }
        case TypeImage: {
            self.pictureView.model = _model;
            self.pictureView.hidden = NO;
            self.myVoiceView.hidden = YES;
            self.myVideoView.hidden = YES;
            break;
        }
        case TypeTalk: {
            
            break;
        }
        case TypeVoice: {
            self.myVoiceView.model = _model;
            self.myVoiceView.hidden = NO;
            self.pictureView.hidden = YES;
            self.myVideoView.hidden = YES;
            break;
        }
        case TypeVideo: {
            self.myVideoView.allModel = _model;
            self.videoOrVoice.hidden = NO;
            _myVideoView = [myVideoView videoView];
//            [_myVideoView setData:_model];
            [self.videoOrVoice addSubview:_myVideoView];
//            [self.videoOrVoice addSubview:_myVideoView];
//            self.pictureView.hidden = YES;
//            self.myVoiceView.hidden = YES;
            break;
        }
    }
    
}


//- (PictureView *)pictureView
//{
//    if (!_pictureView) {
//        _pictureView = [PictureView pictureView];
//        [self.contentView addSubview:_pictureView];
//    }
//    return _pictureView;
//}
//
//-(myVideoView *)myVideoView
//{
//    if (!_myVideoView) {
//        _myVideoView = [myVideoView videoView];
//        [self.contentView addSubview:_myVideoView];
//    }
//    return _myVideoView;
//}
//
//- (myVoiceView *)myVoiceView
//{
//    if (!_myVoiceView) {
//        _myVoiceView = [myVoiceView voiceView];
//        [self.contentView addSubview:_myVoiceView];
//    }
//    return _myVoiceView;
//}

@end
