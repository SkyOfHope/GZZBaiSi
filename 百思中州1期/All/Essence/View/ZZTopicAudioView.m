//
//  ZZTopicAudioView.m
//  百思中州1期
//
//  Created by 👄 on 15/11/9.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTopicAudioView.h"
#import "UIImageView+WebCache.h"
#import "ZZTopic.h"

@interface ZZTopicAudioView()

@property (weak, nonatomic) IBOutlet UIImageView *bigIamgeView;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation ZZTopicAudioView

+(instancetype)audioView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

/*加载完xib之后调用*/
-(void)awakeFromNib
{
    // autoresizing iOS7 autolayout iOS8 SizeClass
//    self.autoresizingMask = UIViewAutoresizingNone;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(play)];
    
    [self.bigIamgeView addGestureRecognizer:tapGR];
}


-(void)setTopic:(ZZTopic *)topic
{
    _topic = topic;

    // iamgeView
    [self.bigIamgeView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.countLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    // 时长
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.videotime / 60, topic.videotime % 60];
}



-(void)play
{
    NSLog(@"play");
}



@end
