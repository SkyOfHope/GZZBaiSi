//
//  AppDelegate.m
//  百思中州1期
//
//  Created by 👄 on 15/11/5.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "AppDelegate.h"

#import "ZZTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 创建window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [[ZZTabBarController alloc]init];
    
    // 成为主窗口才处理事件
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
