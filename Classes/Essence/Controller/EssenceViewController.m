//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by etcxm on 16/6/28.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "EssenceViewController.h"
#import "EssenceHeaderBtn.h"
#import "RecommendViewController.h"
#import "VideoViewController.h"
#import "VoiceViewController.h"
#import "TalkViewController.h"
#import "ImageViewController.h"


@interface EssenceViewController ()<UIScrollViewDelegate> {
    UITableView *EssenceTabView;
}
@property (nonatomic,strong) UIButton *naviLeftBtn;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *btnIndicator;
@property (nonatomic,  weak) UIButton *seletedBtn;
@property (nonatomic,strong) UIScrollView *scrollview;
@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自己来布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpChildViewCtr];
    [self setTitleImage];
    [self setupTitleBtn];
   
}

/**
 *  添加子控制器
 */
- (void)setUpChildViewCtr {
    RecommendViewController *recommend = [[RecommendViewController alloc] init];
    [self addChildViewController:recommend];
    
    VideoViewController *video = [[VideoViewController alloc] init];
    [self addChildViewController:video];
    
    ImageViewController *imageV = [[ImageViewController alloc] init];
    [self addChildViewController:imageV];
    
    TalkViewController *talk = [[TalkViewController alloc] init];
    [self addChildViewController:talk];
}

/**
 *  设置Title图片(百思不得姐)
 */
- (void)setTitleImage {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 300, 200);
    imageView.image = GetImage(@"MainTitle");
    imageView.contentMode = UIViewContentModeCenter;
    [self.navigationItem setTitleView:imageView];
}





/**
 *  初始化Title标签
 */
-(void)setupTitleBtn {
    NSArray *titles = @[@"推荐",@"视频",@"图片",@"段子"];
    NSInteger count = titles.count;
    CGFloat btnH = self.titleView.height - 2;
    CGFloat btnW = self.titleView.width / count;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        CGFloat btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.titleView addSubview:btn];
        //默认选中第一个按钮
        if (btn.tag == 0) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.transform = CGAffineTransformScale(btn.transform, 1.1, 1.1);
                self.seletedBtn.transform = CGAffineTransformScale(btn.transform, 0.9, 0.9);
            } completion:^(BOOL finished) {
                
            }];
            btn.enabled = NO;
            self.seletedBtn = btn;
            [btn.titleLabel sizeToFit];
            
            self.btnIndicator.width = btn.titleLabel.width;
            self.btnIndicator.centerX = btn.centerX;
        }
    }
    [self.titleView addSubview:self.btnIndicator];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.titleView];
    
}

-(void)btnClick:(UIButton *)btn {
    [UIView animateWithDuration:0.25 animations:^{
        btn.transform = CGAffineTransformScale(btn.transform, 1.1, 1.1);
        self.seletedBtn.transform = CGAffineTransformScale(btn.transform, 0.9, 0.9);
    } completion:^(BOOL finished) {
        
    }];
    //按钮状态
    self.seletedBtn.enabled = YES;
    btn.enabled = NO;
    self.seletedBtn = btn;
    //指示器动画
    [UIView animateWithDuration:0.2 animations:^{
        //必须在这里才设置指示器的宽度，要不宽度会计算错误
        self.btnIndicator.width = btn.titleLabel.width;
        self.btnIndicator.centerX = btn.centerX;
    }];
    //控制器view的滚动
    CGPoint offset = self.scrollview.contentOffset;
    offset.x = btn.tag * self.scrollview.width;
    [self.scrollview setContentOffset:offset animated:YES];
    
}

- (UIView *)btnIndicator{
    if (_btnIndicator == nil) {
        _btnIndicator = [[UIView alloc]init];
        _btnIndicator.backgroundColor = [UIColor redColor];
        
        _btnIndicator.height = 2;
        _btnIndicator.y = self.titleView.height - _btnIndicator.height;
    }
    return _btnIndicator;
}

/**
 *  懒加载titleView
 */
- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
        _titleView.frame = CGRectMake(0, 64, Main_Screen_Width, 35);
        _titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    }
    return _titleView;
}
/**
 *  懒加载ScrollView
 */
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]init];
        _scrollview.frame = self.view.bounds;
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;//分页
        _scrollview.contentSize = CGSizeMake(_scrollview.width * self.childViewControllers.count , 0);
        // 添加第一个控制器的view
        [self scrollViewDidEndScrollingAnimation:self.scrollview];
        
    }
    return _scrollview;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - UIScrollViewDelegate

//结束滚动时动画
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //计算当前控制器View索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *viewVc = self.childViewControllers[index];
    viewVc.view.x = scrollView.contentOffset.x;
    viewVc.view.y = 0;
    viewVc.view.height = scrollView.height;
    //设置内边距
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    viewVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    viewVc.tableView.scrollIndicatorInsets = viewVc.tableView.contentInset;
    
    [scrollView addSubview:viewVc.view];
    
}

//滚动减速时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击titleView按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self btnClick:self.titleView.subviews[index]];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
