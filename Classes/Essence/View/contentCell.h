//
//  contentCell.h
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface contentCell : UITableViewCell
@property (nonatomic, strong) DataModel *model;
- (void)setData:(DataModel *)inModel;
@end
