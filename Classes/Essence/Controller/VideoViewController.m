//
//  VideoViewController.m
//  百思不得姐
//
//  Created by xh on 16/6/28.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "VideoViewController.h"
#import "DataModel.h"
#import "contentCell.h"
#import "myContentCell.h"
#import "DataFrame.h"
#import <AVFoundation/AVFoundation.h>
#import "KRVideoPlayerController.h"


static NSString *const Identifier = @"mycell";
@interface VideoViewController ()
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, strong) KRVideoPlayerController *videoController;

// 当前页码
@property (nonatomic, assign) NSInteger page;
// 当加载下一页数据时需要的参数
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settableView];
    [self setUpRefresh];

}



/**
 *  懒加载数组
 */
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
//设置tableView
-(void)settableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"myContentCell" bundle:nil] forCellReuseIdentifier:Identifier];
}


/**
 *  设置刷新控件
 */
- (void)setUpRefresh {
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topRefresh)];
}

/**
 *  下拉刷新
 */
- (void)downRefresh {
    self.page = 0;
    [self.dataArray removeAllObjects];
    NSString *par = @"list";
    [ParsingData getDataType:TypeVideo parameter:par block:^(id json, id param) {
        for (DataModel *model in json) {
            DataFrame *frame = [[DataFrame alloc] init];
            frame.model = model;
            [self.dataArray addObject:frame];
        }
        _maxtime = param;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

/**
 *  上拉加载
 */
- (void)topRefresh {
    NSInteger page = _page ++;
    [ParsingData getDataWithMaxTime:_maxtime page:@(page) titleType:TypeVideo parameter:@"list" block:^(id json, id param) {
        NSMutableArray *newArray = [NSMutableArray array];
        for (DataModel *model in json) {
            DataFrame *frame = [[DataFrame alloc] init];
            frame.model = model;
            [newArray addObject:frame];
        }
        [self.dataArray addObjectsFromArray:newArray];
        [self.tableView reloadData];
        self.page = page;
        self.maxtime = param;
        [self.tableView.mj_footer endRefreshing];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myContentCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataFrame = _dataArray[indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataFrame *frame = self.dataArray[indexPath.row];
    return frame.cellHeight;
}


- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
