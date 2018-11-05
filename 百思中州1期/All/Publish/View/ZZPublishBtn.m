//
//  ZZPublishBtn.m
//  百思中州1期
//
//  Created by 👄 on 15/11/11.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZPublishBtn.h"

@implementation ZZPublishBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}


- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}



@end
