//
//  TabBarViewController.m
//  TeamDemo
//
//  Created by etcxm on 16/6/3.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "TabBarViewController.h"
#import "MyTabBarItem.h"
#import "TabBarModel.h"
#import "AttentionTableViewController.h"
#import "EssenceViewController.h"
#import "MineTableViewController.h"
#import "NewTableViewController.h"
#import "AddViewController.h"
#define TabBarPlistName @"TabBarTitleAndImage.plist"

@interface TabBarViewController ()
//用于接收TabBar加载进来的数组文件(其中是字典)
@property (nonatomic, strong) NSArray *TabBarPlist;

//模型数组
@property (nonatomic, strong) NSMutableArray *ModelArray;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //懒加载Plist文件
    [self TabBarPlist];
    //字典转模型
    [self DicToModel];
    [self setUpCtr];
    
    
}

/**
 *  设置TabBar上的控制器
 */
- (void)setUpCtr
{
    //精选
    EssenceViewController *essence = [[EssenceViewController alloc] init];
    UINavigationController *navigationEssence = [self tableViewCtr1:essence Num:0];
    //最新
    NewTableViewController *new = [[NewTableViewController alloc] init];
    UINavigationController *navigationNew = [self tableViewCtr:new Num:1];
    //加号
    AddViewController *Add = [[AddViewController alloc] init];
    UINavigationController *navigationAdd = [self tableViewCtr1:Add Num:2];
    //关注
    AttentionTableViewController *attention = [[AttentionTableViewController alloc] init];
    UINavigationController *navigationAttention = [self tableViewCtr:attention Num:3];
    MineTableViewController *mine = [[MineTableViewController alloc] init];
    UINavigationController *navigationMine = [self tableViewCtr:mine Num:4];
    //加入到TabBar
    [self setViewControllers:@[navigationEssence,navigationNew,navigationAdd,navigationAttention,navigationMine]];
}
/**
 *  设置导航栏并绑定Item
 */
- (UINavigationController *)tableViewCtr:(UITableViewController *)tableViewCtr Num:(NSInteger)num
{
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:tableViewCtr];
    navigation.tabBarItem = [self item:num];
    return navigation;
}
- (UINavigationController *)tableViewCtr1:(UIViewController *)tableViewCtr Num:(NSInteger)num
{
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:tableViewCtr];
    navigation.tabBarItem = [self item:num];
    return navigation;
}

/**
 *  用来设置TabBar上的item
 *
 *  @param num 对应模型数组的第几位
 *
 *  @return 初始化好的item
 */
- (UITabBarItem *)item:(NSInteger)num
{
    TabBarModel *TBModel = [[TabBarModel alloc] init];
    TBModel = _ModelArray[num];
    MyTabBarItem *item = [[MyTabBarItem alloc] initWithTabBarModel:TBModel];
    return item;
}


/**
 *  字典转模型（字典数组---->模型数组）
 */
- (void)DicToModel
{
    _ModelArray = [[NSMutableArray alloc] init];
    _ModelArray = [TabBarModel mj_objectArrayWithKeyValuesArray:_TabBarPlist];
}


/**
 *  懒加载TabBar的Plist文件
 */
- (NSArray *)TabBarPlist
{
    if (_TabBarPlist == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:TabBarPlistName ofType:nil];
        _TabBarPlist = [NSArray arrayWithContentsOfFile:path];
    }
    return _TabBarPlist;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
