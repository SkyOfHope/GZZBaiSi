//
//  ZZCommentViewController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/11.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZCommentViewController.h"
#import "ZZCommentCell.h"
#import "AFNetworking.h"
#import "ZZTopic.h"

#import "ZZComment.h"
#import "ZZCommentHeaderView.h"

@interface ZZCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;


/*
 1.VFL 
 2.NSLayoutConstraint:
 3.UIView + autolayout
 */


@property(weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;

@end

static NSString *const ZZCommentCellId = @"comment";

@implementation ZZCommentViewController

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc]init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 键盘的frame改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    self.title =@"评论";
    
    self.view.backgroundColor = ZZGlobalBg;

    [self setupTableView];
    [self setupRefreshView];
    
    self.tableView.estimatedRowHeight = ZZScreenH;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)setupRefreshView
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tableView.footer = footer;
}

-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]init];
//    tableView.rowHeight = 150;
//    // 默认估计值
    
    
    tableView.backgroundColor = ZZGlobalBg;
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.width = self.view.width;
    tableView.height = self.view.height - 44;
    tableView.delegate = self;
    tableView.dataSource = self;

    [self.view insertSubview:tableView atIndex:0];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZCommentCell class]) bundle:nil] forCellReuseIdentifier:ZZCommentCellId];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView = tableView;
}

-(void)loadNewData
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";

    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.latestComments = [ZZComment objectArrayWithKeyValuesArray:responseObject[@"data"]];

        self.hotComments = [ZZComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.header endRefreshing];
    }];
}

-(void)loadMoreData
{

}

/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    
    // 修改toolBar的位置
    
    self.bottomSpace.constant = frame.size.height;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    

    [UIView animateWithDuration:duration animations:^{
        
        self.view.autoresizingMask = UIViewAutoresizingNone;
        
        [self.view layoutIfNeeded];   // 改变约束
    }];
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.hotComments.count ? 2 : 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.hotComments.count ? self.hotComments.count : self.latestComments.count;
    }
    
    return self.latestComments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZCommentCellId];
    
    if (indexPath.section == 0) {
        
        cell.comment = self.hotComments.count ? self.hotComments[indexPath.row] : self.latestComments[indexPath.row];
        return cell;
    }

    cell.comment = self.latestComments[indexPath.row];
    return cell;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return self.hotComments.count ? @"最热评论":@"最新评论";
//    }
//
//    return @"最新评论";
//}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 先从缓存池中找header
    ZZCommentHeaderView *header = [ZZCommentHeaderView headerViewWithTableView:tableView];
    
    // 设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}


@end
