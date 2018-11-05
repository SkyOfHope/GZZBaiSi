//
//  ZZComment.h
//  百思中州1期
//
//  Created by 👄 on 15/11/9.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ZZUser;
@interface ZZComment : NSObject

// 讯飞 百度语音：文字转声音  声音转文字

/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) ZZUser *user;

@end
