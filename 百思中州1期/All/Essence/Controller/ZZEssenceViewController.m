//
//  ZZEssenceViewController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/5.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZEssenceViewController.h"
#import "ZZTopicViewController.h"
#import "ZZRecommendTagsViewController.h"

@interface ZZEssenceViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIButton *selectedButton;

@property(weak, nonatomic) UIView *bottomLine;

@property(weak, nonatomic) UIView *tagsView;

@property(weak, nonatomic) UIScrollView *contentView;

@end

@implementation ZZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 添加子控制器
    [self addChildVC];
    
    // 添加scrollView
    [self addContentView];
    
    // 添加toolbar
    [self setupTagsView];
    
    
    
}

-(void)addChildVC
{
    ZZTopicViewController * allVC= [[ZZTopicViewController alloc]init];
    allVC.title = @"全部";
    allVC.type = ZZTopicTypeAll;
    [self addChildViewController:allVC];
    
    ZZTopicViewController * audioVC= [[ZZTopicViewController alloc]init];
    audioVC.title = @"视频";
    audioVC.type = ZZTopicTypeAudio;
    [self addChildViewController:audioVC];
    
    ZZTopicViewController * videoVC= [[ZZTopicViewController alloc]init];
    videoVC.title = @"声音";
    videoVC.type = ZZTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    ZZTopicViewController * pictureVC= [[ZZTopicViewController alloc]init];
    pictureVC.title = @"图片";
    pictureVC.type = ZZTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    ZZTopicViewController * wordVC= [[ZZTopicViewController alloc]init];
    wordVC.title = @"段子";
    wordVC.type = ZZTopicTypeWord;
    [self addChildViewController:wordVC];
}

-(void)setupTagsView
{
    UIView *tagsView = [[UIView alloc]init];
//    tagsView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    
    tagsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    tagsView.y = 64;
    tagsView.height = 35;
    tagsView.width = self.view.width;

    [self.view addSubview:tagsView];
    self.tagsView = tagsView;
    
    
    // 下划线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor redColor];
    bottomLine.height = 2;
//    bottomLine.width = button.titleLabel.width;
    bottomLine.y = tagsView.height - bottomLine.height;
//    bottomLine.centerX = button.width * 0.5;
    
 
    
    // 添加按钮
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        
        UIViewController *childVC = self.childViewControllers[i];
        
        [button setTitle:childVC.title forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        button.width = self.view.width / self.childViewControllers.count;
        button.height = tagsView.height;
        button.x = i * button.width;

        // 计算titleLabel的尺寸
        [button.titleLabel sizeToFit];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagsView addSubview:button];
        
    
        // 默认第一个按钮是红色
        if (tagsView.subviews.count == 1) {
        
            
            [self titleClick:button];
            
            bottomLine.width = button.titleLabel.width;
            bottomLine.centerX = button.centerX;
        }
    }
    
    
    [tagsView addSubview:bottomLine];
    self.bottomLine = bottomLine;
}

-(void)tagClick
{
    [self.navigationController pushViewController:[[ZZRecommendTagsViewController alloc]init] animated:YES];
}

-(void)rightClick
{
    NSLog(@"rightClick---");
}

-(void)addContentView
{
    // 自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    
    contentView.frame = self.view.bounds;
    
    contentView.delegate = self;
    
    // 能滚动的范围
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 1);
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    // 添加第一个子控制器的View
    [self scrollViewDidEndScrollingAnimation:contentView];
}

// 滚动scrollView、改变下划线的位置和长度
-(void)titleClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 改变下划线的位置
    
    [UIView animateWithDuration:0.25 animations:^{
        
        // button的title字数可能不一样
        self.bottomLine.width = button.titleLabel.width;
        
        self.bottomLine.centerX = button.centerX;
    }];
    
    // 滚动scrollView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.view.width;
    self.contentView.contentOffset = offset;
    // 加载View，才会出现自动刷新
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}

// 动画执行完成调用，不设置contentOffSet不调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 加载子视图

    int index = (scrollView.contentOffset.x / scrollView.width);
    
    UIViewController *childVC = self.childViewControllers[index];
    childVC.view.x = index * scrollView.width;
    childVC.view.y = 0;// 默认是20
    
    [scrollView addSubview:childVC.view];
}

// 退拽结束(手松开调用)scrollView.contentOffset.x不确定
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 手动调用加载视图，不会自动调
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width; // 新特性页面

    // 改变bottomLine的位置
    [self titleClick:self.tagsView.subviews[index]];
}

@end
