//
//  ZZTabBarController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/5.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTabBarController.h"

#import "ZZEssenceViewController.h"
#import "ZZNewViewController.h"
#import "ZZFrinendTrendsViewController.h"
#import "ZZMeViewController.h"

#import "ZZNavigationController.h"
#import "ZZTabBar.h"

@interface ZZTabBarController ()

@end

@implementation ZZTabBarController

// 第一次使用这个类的时候调用
+(void)initialize
{
    // 设置tabBarItem的主题
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    NSMutableDictionary *norAttributes = [NSMutableDictionary dictionary];
    // 颜色
    norAttributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 字体
    norAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    [tabBarItem setTitleTextAttributes:norAttributes forState:UIControlStateNormal];
    
    
    NSMutableDictionary *selAttributes = [NSMutableDictionary dictionaryWithDictionary:norAttributes];
    // 颜色
    selAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [tabBarItem setTitleTextAttributes:selAttributes forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.tintColor = [UIColor blackColor];
    
    // 添加子控制器
    ZZEssenceViewController *essenceVC = [[ZZEssenceViewController alloc]init];
    [self addChildVC:essenceVC title:@"精华" image:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    
    ZZNewViewController *newVC = [[ZZNewViewController alloc]init];
    [self addChildVC:newVC title:@"新帖" image:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];

    
    ZZFrinendTrendsViewController *fVC = [[ZZFrinendTrendsViewController alloc]init];
    [self addChildVC:fVC title:@"关注" image:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];

    ZZMeViewController *mVC = [[ZZMeViewController alloc]init];
    
    [self addChildVC:mVC title:@"我" image:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
    
    
    // 使用自定义的tabBar
    [self setValue:[[ZZTabBar alloc]init] forKey:@"tabBar"];
}

// 添加子控制器
-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
    childVC.view.backgroundColor = [UIColor whiteColor];
    
//    childVC.tabBarItem.title = title;
    
//    childVC.navigationItem.title = title;

    childVC.title = title;
    
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    
    ZZNavigationController *nav = [[ZZNavigationController alloc]initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

@end
