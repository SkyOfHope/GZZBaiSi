//
//  ZZPublishViewController.m
//  百思中州1期
//
//  Created by 👄 on 15/11/11.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZPublishViewController.h"
#import "ZZPublishBtn.h"

@interface ZZPublishViewController ()

@end

@implementation ZZPublishViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];

    NSInteger maxCols = 3;

    CGFloat btnW = 72;
    CGFloat btnH = btnW + 30;

    CGFloat startBtnX = 20;
    
    CGFloat margin = (self.view.width - 2 * startBtnX - btnW * maxCols) / (maxCols * 2);
    
    for (int i = 0; i < images.count; i++) {
        ZZPublishBtn *btn = [[ZZPublishBtn alloc]init];
        
        // frame
        btn.width = btnW;
        btn.height = btnH;
        
        NSInteger row = i / maxCols;
        NSInteger col = i % maxCols;
        
        btn.x = col * (btnW + margin) + startBtnX;
        btn.y = row * btnH + 200;
        
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        
  
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
    }
}


- (IBAction)cancel {

    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
