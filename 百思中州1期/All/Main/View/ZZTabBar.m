//
//  ZZTabBar.m
//  百思中州1期
//
//  Created by 👄 on 15/11/11.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTabBar.h"
#import "ZZPublishViewController.h"

@interface ZZTabBar()

@property(weak, nonatomic) UIButton *plusBtn;

@end

@implementation ZZTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        // 添加加号按钮
        UIButton *plusBtn = [[UIButton alloc]init];

        [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
                 
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    
    return self;
}

-(void)plusBtnClick
{
//    UITabBarController *tabBarVC = (UITabBarController *)self.delegate;

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[ZZPublishViewController alloc]init] animated:NO completion:nil];
}

/**self的frame改动了*/
-(void)layoutSubviews
{
    [super layoutSubviews];

    // plusBtn
    self.plusBtn.height = self.height;
    self.plusBtn.width = self.width / 5;
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;


    
    
    CGFloat width = self.width / 5;
    NSInteger i = 0;
    
    for (UIView *subView in self.subviews) {

        if (![subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
       
        subView.width = width;
        subView.x = i * width;
        
        if(i >= 2)
        {
            subView.x = (i + 1) * width;
        }
        
       i++;
    }
}

@end
