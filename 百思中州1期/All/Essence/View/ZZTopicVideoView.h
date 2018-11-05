//
//  ZZTopicVideoView.h
//  百思中州1期
//
//  Created by 👄 on 15/11/9.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZTopic;
@interface ZZTopicVideoView : UIView

@property (strong, nonatomic) ZZTopic *topic;

+(instancetype)videoView;

@end
