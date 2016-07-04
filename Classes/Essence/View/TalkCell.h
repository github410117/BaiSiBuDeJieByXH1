//
//  TalkCell.h
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;
@interface TalkCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setData:(DataModel *)model;
@end
