//
//  PostTitleView.m
//  百思不得姐
//
//  Created by etcxm on 16/6/28.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PostTitleView.h"

@implementation PostTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
