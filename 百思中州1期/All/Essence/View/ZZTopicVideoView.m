//
//  ZZTopicVideoView.m
//  百思中州1期
//
//  Created by 👄 on 15/11/9.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTopicVideoView.h"
#import "UIImageView+WebCache.h"
#import "ZZTopic.h"

@interface ZZTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation ZZTopicVideoView

+(instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

/*加载完xib之后调用*/
-(void)awakeFromNib
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(play)];
    
    [self.bigImageView addGestureRecognizer:tapGR];
}

-(void)setTopic:(ZZTopic *)topic
{
    _topic = topic;
    
    // 大图片
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    
    // 播放次数
    self.countLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    // 时长
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.voicetime / 60, topic.voicetime % 60];
}

-(void)play
{
    NSLog(@"play");
}


@end
