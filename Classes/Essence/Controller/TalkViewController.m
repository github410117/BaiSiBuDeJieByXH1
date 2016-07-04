//
//  TalkViewController.m
//  百思不得姐
//
//  Created by xh on 16/6/28.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "TalkViewController.h"
#import "TalkCell.h"
#import "DataModel.h"
#import "DataFrame.h"
#import "myContentCell.h"

static NSString *const Identifier = @"mycell";
@interface TalkViewController ()
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要的参数 */
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation TalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settableView];
    [self setUpRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)downRefresh {
    NSString *par = @"list";
    [ParsingData getDataType:TypeTalk parameter:par block:^(id json, id param) {
        for (DataModel *model in json) {
            DataFrame *frame = [[DataFrame alloc] init];
            frame.model = model;
            [self.dataArray addObject:frame];
        }
        //        self.dataArray = [DataModel mj_objectArrayWithKeyValuesArray:json];
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
