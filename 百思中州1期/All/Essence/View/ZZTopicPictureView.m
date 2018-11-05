
//
//  ZZTopicPictureView.m
//  百思中州1期
//
//  Created by 👄 on 15/11/9.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTopicPictureView.h"
#import "ZZTopic.h"
#import "UIImageView+WebCache.h"

@interface ZZTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIButton *showBigPictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@end

@implementation ZZTopicPictureView

+(instancetype)pictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)setTopic:(ZZTopic *)topic
{
    _topic = topic;
    
    
    // iamgeView
    
//    self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.bigImageView.clipsToBounds = YES;


    // 图片下载完成之后绘制
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 大图才需要绘制
        if (!topic.isBigImage) return;
        
        // 开启图形上下文
      UIGraphicsBeginImageContextWithOptions(topic.pictureViewF.size, YES, 0.0);
        
        // 设置图片大小
        CGFloat width = topic.pictureViewF.size.width;
        CGFloat height =  width * image.size.height / image.size.width;
            
        // 绘制
        [image drawInRect:CGRectMake(0, 0, width, height)];
            
        // 从上下文中拿到图片
        self.bigImageView.image = UIGraphicsGetImageFromCurrentImageContext();

        // 关闭上下文
        UIGraphicsEndImageContext();
        
    }];
    // gif\GIF

    NSString *prefix = [topic.large_image stringByDeletingPathExtension].lowercaseString;

    
    NSString *extension = [topic.large_image substringFromIndex:prefix.length + 2];

    if ([extension isEqualToString:@"gif"]) {
        self.gifView.hidden = NO;
    }
    else
    {
        self.gifView.hidden = YES;
    }
    
    
    // 是否显示“显示大图Button”
    self.showBigPictureView.hidden = !topic.isBigImage;
}

- (IBAction)showBigPicture {
    
}

@end
