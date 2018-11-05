
//
//  ZZTopic.m
//  百思中州1期
//
//  Created by 👄 on 15/11/6.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTopic.h"
#import "ZZComment.h"
#import "ZZUser.h"
#import "MJExtension.h"

#import "NSDate+Extension.h"

@implementation ZZTopic

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]" //,
             //             @"qzone_uid" : @"top_cmt[0].user.qzone_uid"
             };
}


// 计算cell的高度

// 计算视频、音频、图片View的Y和高度
-(CGFloat)cellHeight
{
    // 1 cellHeight默认是text_label的最大Y值

    CGSize maxSize = CGSizeMake(ZZScreenW - 2 * ZZTopicCellMargin, MAXFLOAT);
    
    // 计算textLabel的高度
    CGSize textLabelSize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    
    // cellHeight
    _cellHeight = ZZTopicCellTextLabelY + textLabelSize.height + ZZTopicCellMargin;
    
    
    // 2 根据帖子类型改变cellHeight
    if(self.type == ZZTopicTypeAudio)
    {
        // 1 计算视频的高度
        CGFloat audioH = (ZZScreenW - 2 * ZZTopicCellMargin) * self.height / self.width;
        
        CGFloat audioX = ZZTopicCellMargin;
        CGFloat audioY = _cellHeight;
        CGFloat audioW = maxSize.width;
        
        // 2 给audioViewF赋值
        _audioViewF = CGRectMake(audioX, audioY, audioW, audioH);
        
        // 3 改变cellHeight
        _cellHeight += audioH + ZZTopicCellMargin;
    }
    else if(self.type == ZZTopicTypeVideo)
    {
        // 1 计算音频的高度和y.
        CGFloat videoH = (ZZScreenW - 2 * ZZTopicCellMargin) * self.height / self.width;
        
        CGFloat videoX = ZZTopicCellMargin;
        CGFloat videoY = _cellHeight;
        CGFloat videoW = maxSize.width;
        
        // 2 videoViewF赋值
        _videoViewF = CGRectMake(videoX, videoY, videoW, videoH);
        
        // 3 计算cell的高度
        _cellHeight += videoH + ZZTopicCellMargin;
    }
    else if(self.type == ZZTopicTypePicture)
    {
        // 1 计算图片的高度
        CGFloat pictureH = (ZZScreenW - 2 * ZZTopicCellMargin) * self.height / self.width;
        
        
        
        // 判断如果高度大于600
        if(pictureH > 600)
        {
            pictureH = 200;
            self.bigImage = YES;
        }
        
        
        
        CGFloat pictureX = ZZTopicCellMargin;
        CGFloat pictureY = _cellHeight;
        CGFloat pictureW = maxSize.width;
        
        // 2 pictureViewF赋值
        _pictureViewF = CGRectMake(pictureX, pictureY, pictureW, pictureH);

        // 3 计算cell的高度
        _cellHeight += pictureH + ZZTopicCellMargin;
    }
    
    // 3 是否有最热评论
    if(self.top_cmt.content)
    {
        NSString *result = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username, self.top_cmt.content];
        
        // 计算最热的高度
        CGSize commentContentSize = [result boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size;
        
        // 改变cellHeight
        _cellHeight += commentContentSize.height + ZZTopicCellHotCommentLabelH;
    }
    
    
    // 4 cellHeight加上toolbar的高度
    _cellHeight += ZZTopicCellToolBarH + ZZTopicCellMargin;
    
    return _cellHeight;
}

-(NSString *)create_time
{
//    _create_time = @"2014-11-10 09:27:50";
    
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [fm dateFromString:_create_time];
    
    if (date.isThisYear) {   // 今年
        
        if (date.isToday) {  // 今天
            
            NSDateComponents *dateC = [date deltaWithNow];
            
            if(dateC.hour > 1)
            {
                return [NSString stringWithFormat:@"%zd小时前",dateC.hour];
            }
            else if(dateC.minute > 1)
            {
                return [NSString stringWithFormat:@"%zd分钟前",dateC.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else if (date.isYesterday) // 昨天
        {
            fm.dateFormat = @"昨天 HH:mm:ss";
            return [fm stringFromDate:date];
        }
        else
        {
            fm.dateFormat = @"MM-dd";
            return [fm stringFromDate:date];
        }
    }
    else
    {
        fm.dateFormat = @"yyyy-MM-dd";
        return [fm stringFromDate:date];
    }
}


@end
