//
//  ZZTopicViewController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/5.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTopicViewController.h"
#import "ZZTopicCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ZZTopic.h"
#import "ZZCommentViewController.h"

@interface ZZTopicViewController ()

// 保存请求下来的帖子数据
@property (strong, nonatomic) NSMutableArray *topics;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property(assign, nonatomic) NSInteger page;

@property (copy, nonatomic) NSString *maxtime;

@end

static NSString *const ZZTopicId = @"topic";

@implementation ZZTopicViewController



-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc]init];
    }
    return _manager;
}


-(NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupTableView];
    [self setupRefreshView];
}

-(void)setupRefreshView
{
    // 自动改变透明度（下拉的百分比）
    [self.tableView.header setAutomaticallyChangeAlpha:YES];

    // 下拉刷新控件
    MJRefreshNormalHeader *normalHeader = [[MJRefreshNormalHeader alloc]init];
    // 刷新的时候触发
    [normalHeader setRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    
    self.tableView.header = normalHeader;
    [normalHeader beginRefreshing];
    
    // 上拉刷新控件
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(laodMoreTopic)];
    
    self.tableView.footer = footer;
}

-(void)loadNewTopic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    
    // 请求数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
      
        
        self.maxtime = responseObject[
        @"info"][@"maxtime"];
        
//        NSLog(@"%@",responseObject);
        
        // 转模型
        NSArray *topicArr = [ZZTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 数据加到数组
        [self.topics addObjectsFromArray:topicArr];
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.header endRefreshing];
    }];
  
    
}
-(void)laodMoreTopic
{
    // 取消其他请求任务
//    [self.manager invalidateSessionCancelingTasks:YES];
    
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);

    NSInteger page = self.page + 1;   // 2
    params[@"page"] = @(page);
    
    // 当前时间之前的数据---------
    params[@"maxtime"] = self.maxtime;
    
    
    
    // 发请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        self.maxtime = responseObject[@"info"][@"maxtime"];

        
//        NSLog(@"%@",responseObject);
        
        
        [self.topics addObjectsFromArray:[ZZTopic objectArrayWithKeyValuesArray:responseObject[@"list"]]];

        [self.tableView.footer endRefreshing];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.footer endRefreshing];
        
    }];
}

-(void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = ZZGlobalBg;
    
    // 内边距：出现刷新控件
    
    CGFloat top = 64;
    CGFloat bottom = 49;

    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableView.contentInset = UIEdgeInsetsMake(top + 35, 0, bottom, 0);
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZTopicCell class]) bundle:nil]  forCellReuseIdentifier:ZZTopicId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZTopicId];
    cell.topic = self.topics[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZCommentViewController *comentVC = [[ZZCommentViewController alloc]init];
    comentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:comentVC animated:YES];
    
}

@end
