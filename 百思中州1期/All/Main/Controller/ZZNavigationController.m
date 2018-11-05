//
//  ZZNavigationController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/5.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZNavigationController.h"

@interface ZZNavigationController ()

/*
 1.自定义cell，给cell中的每个子控件添加约束（控件的尺寸取决于数据）
 2.把数据传给cell。
 */

@end

@implementation ZZNavigationController

+(void)initialize
{
    // 设置导航条的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    
    [navBar setTitleTextAttributes:attributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**重写push*/
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {

        viewController.hidesBottomBarWhenPushed = YES;
        
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
        
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        
        
        
    }

    [super pushViewController:viewController animated:animated];
    
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

@end
