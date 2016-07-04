//
//  TalkCell.m
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "TalkCell.h"
#import "DataModel.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"


@interface TalkCell ()
@property (weak, nonatomic) IBOutlet UIButton *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation TalkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//+ (instancetype)cellWithTableView:(UITableView *)tableView {
//    static NSString *identifier = @"MyCell";
//    TalkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
//    }
//    return cell;
//}

- (void)setData:(DataModel *)model {
    NSURL *url = [NSURL URLWithString:model.profile_image];
    NSLog(@"%@",url);
    UIImageView *im = [[UIImageView alloc] init];
    [im setImageWithURL:url];
    im.image = [im.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_headImage setImage:im.image forState:UIControlStateNormal];
    _userName.text = model.name;
    _releaseTime.text = model.created_at;
    _content.text = model.text;
}

@end
