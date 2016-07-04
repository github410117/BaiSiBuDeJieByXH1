//
//  PictureView.m
//  百思不得姐
//
//  Created by etcxm on 16/7/1.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PictureView.h"
#import "DataModel.h"
#import "DALabeledCircularProgressView.h"
#import "UIImageView+WebCache.h"


@interface PictureView ()
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *ProgressView;
- (IBAction)bigImage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *bigImageOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;

@end

@implementation PictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    //取消UIView的自动调整布局
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加单击事件
    self.imageView.userInteractionEnabled = YES;//设置为能与用户交互
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)]];
}

- (void)showImage {
    NSLog(@"暂时没写第二界面");
}

- (void)setModel:(DataModel *)model {
    _model = model;
    [self.ProgressView setProgress:0.0 animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cdn_img] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.bigImageOutlet.hidden = YES;
        self.bgImage.hidden = NO;
        CGFloat progress = receivedSize / expectedSize;
        self.ProgressView.hidden = NO;
        self.ProgressView.progressLabel.textColor = [UIColor whiteColor];
        self.ProgressView.roundedCorners = 3;
        self.ProgressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        [self.ProgressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.ProgressView.hidden = YES;
        self.bgImage.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.bigImageOutlet.hidden = YES;
        self.gifImage.hidden = ![model.middle_image.pathExtension.lowercaseString isEqualToString:@"gif"];//根据图片后缀是不是gif来判断是否隐藏gif图标
    }];
    
}

- (IBAction)bigImage:(UIButton *)sender {
    NSLog(@"待写第二界面");
}
@end
