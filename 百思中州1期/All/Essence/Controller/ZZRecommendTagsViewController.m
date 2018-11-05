//
//  ZZRecommendTagsViewController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/10.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZRecommendTagsViewController.h"
#import "AFNetworking.h"
#import "ZZRecommendTag.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "ZZRecommendTagCell.h"

@interface ZZRecommendTagsViewController ()


/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

static NSString *const ZZRecommendTagId = @"tag";

@implementation ZZRecommendTagsViewController

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc]init];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setupTableView];
    
    [self loadTags];
}

-(void)setupTableView
{
    self.tableView.backgroundColor = ZZGlobalBg;
    self.tableView.rowHeight = 70;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ZZRecommendTagId];
}

-(void)loadTags
{
    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.tags = [ZZRecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZRecommendTagId];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}

@end
