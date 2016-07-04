//
//  EssenceHeaderBtn.m
//  百思不得姐
//
//  Created by xh on 16/6/27.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "EssenceHeaderBtn.h"

@interface EssenceHeaderBtn ()<UIScrollViewDelegate> {
    UIScrollView *scrollView1;
    UIView *redIndicator;//红色指示器
    UIButton *selectedBtn;//当前选择的btn
}
@property (nonatomic, strong) NSArray *headerArray;
@end

@implementation EssenceHeaderBtn
/**
 *  重写初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self scrollView1];
    }
    return self;
}
/**
 *  ScrollView
 */
- (void)scrollView1 {
    //设置scrollView1
    scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
    scrollView1.delegate = self;
    scrollView1.showsHorizontalScrollIndicator = NO;
    scrollView1.scrollEnabled = YES;
    
    //红色指示器
    redIndicator = [[UIView alloc] init];
    redIndicator.backgroundColor = [UIColor redColor];
    CGRect frame = redIndicator.frame;
    frame.size.height = 2;
    frame.origin.y = 42;
    redIndicator.frame = frame;
    [scrollView1 addSubview:redIndicator];
    
    
    
    //用来存放上一次的的button位置
    CGFloat lastWidth = 0;
    //循环创建button
    for (int i = 0; i < self.headerArray.count; ++i) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGFloat width = [_headerArray[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        [btn setTitle:_headerArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(20 + lastWidth, 3, width, 38);
        lastWidth = btn.frame.size.width + btn.frame.origin.x;
        [scrollView1 addSubview:btn];
        if (i == 0) {
            [self btnClick:btn];
            btn.enabled = NO;
            selectedBtn = btn;
            CGRect btnframe = btn.frame;
            CGRect frame = redIndicator.frame;
            frame.size.width = btnframe.size.width;
            frame.origin.x = btnframe.origin.x;
            redIndicator.frame = frame;
            
            
        }
    }
    scrollView1.contentSize = CGSizeMake(lastWidth, 0);
    [self addSubview:scrollView1];    
}
/**
 *  懒加载plist文件
 */
- (NSArray *)headerArray {
    if (_headerArray == nil) {
        _headerArray = [GetPlistArray arrayWithString:@"HeaderLabel"];
    }
    return _headerArray;
}

/**
 *  按钮点击事件
 *
 *  @param btn 当前点击按钮
 */
- (void)btnClick:(UIButton *)btn {
    //修改按钮的状态,改变当前选择按钮
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformScale(btn.transform, 1.1, 1.1);
        selectedBtn.transform = CGAffineTransformScale(btn.transform, 0.9, 0.9);
    } completion:^(BOOL finished) {
        
    }];
    selectedBtn.enabled = YES;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [selectedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.enabled = NO;
    selectedBtn = btn;
    
    
    
    //让红色指示器动画移动
    [UIView animateWithDuration:0.25 animations:^{
        CGRect redFrame = redIndicator.frame;
        CGRect btnFrame = btn.frame;
        redFrame.size.width = btnFrame.size.width;
        redFrame.origin.x = btn.frame.origin.x;
        redIndicator.frame = redFrame;
    }];
    
}



@end
