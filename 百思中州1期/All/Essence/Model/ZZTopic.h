//
//  ZZTopic.h
//  百思中州1期
//
//  Created by 👄 on 15/11/6.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZZComment;
@interface ZZTopic : NSObject


/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 最热评论 */
@property (nonatomic, strong) ZZComment *top_cmt;

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型   请求下来就有值 */
@property (nonatomic, assign) ZZTopicType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;







/** cellHeight */
@property(assign, nonatomic) CGFloat cellHeight;

/** 视频View的尺寸 */
@property(assign, nonatomic) CGRect audioViewF;

/** 音频View的尺寸 */
@property(assign, nonatomic) CGRect videoViewF;

/** 图片View的尺寸 */
@property(assign, nonatomic) CGRect pictureViewF;
/** 是否是很大的图片 */
@property(assign, nonatomic,getter=isBigImage) BOOL bigImage;

@end
