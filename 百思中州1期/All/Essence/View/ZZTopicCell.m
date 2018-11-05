//
//  ZZTopicCell.m
//  百思中州1期
//
//  Created by 👄 on 15/11/6.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZTopicCell.h"
#import "ZZTopic.h"
#import "UIImageView+WebCache.h"
#import "ZZComment.h"
#import "ZZUser.h"

#import "ZZTopicVideoView.h"
#import "ZZTopicAudioView.h"
#import "ZZTopicPictureView.h"

@interface ZZTopicCell ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;


@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;


@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


@property (strong, nonatomic) ZZTopicPictureView *pictureView;
@property (strong, nonatomic) ZZTopicAudioView *audioView;
@property (strong, nonatomic) ZZTopicVideoView *videoView;




@end


@implementation ZZTopicCell

-(ZZTopicPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [ZZTopicPictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}


-(ZZTopicVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [ZZTopicVideoView videoView];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}


-(ZZTopicAudioView *)audioView
{
    if (!_audioView) {
        _audioView = [ZZTopicAudioView audioView];
        [self.contentView addSubview:_audioView];
    }
    return _audioView;
}

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTopic:(ZZTopic *)topic
{
    _topic = topic;

    // 加V
    self.sinaVView.hidden = !topic.sina_v;
    
    // 头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
    self.profileImageView.clipsToBounds = YES;
    
    // 昵称
    self.nameLabel.text = topic.name;
    
    // 时间
    self.createTimeLabel.text = topic.create_time;
    
    // 文字
    self.text_label.text = topic.text;

    // 是否隐藏最热评论
    self.commentContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username, topic.top_cmt.content];

    if(topic.top_cmt.content)
    {
        self.commentView.hidden = NO;
    }
    else
    {
        self.commentView.hidden = YES;
    }

    // 根据帖子类型加载不同的View
    if (topic.type == ZZTopicTypeAudio) {
     
        // 隐藏其他View
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = NO;
        
        self.audioView.topic = topic;
        self.audioView.frame = topic.audioViewF;
    }
    else if (topic.type == ZZTopicTypeVideo)
    {
        // 隐藏其他View
        self.pictureView.hidden = YES;
        self.audioView.hidden = YES;
        self.videoView.hidden = NO;
        
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewF;
    }
    else if (topic.type == ZZTopicTypePicture)
    {
        // 隐藏其他View
        self.audioView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        
        
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewF;
    }
    else
    {
        // 隐藏其他View
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = YES;
    }
    
    
    
    // toolBar
    [self setupTitleWithBtn:self.dingButton count:topic.ding placeHolderTitle:@"顶"];
    [self setupTitleWithBtn:self.caiButton count:topic.cai placeHolderTitle:@"踩"];
    [self setupTitleWithBtn:self.reportButton count:topic.repost placeHolderTitle:@"转发"];
    [self setupTitleWithBtn:self.commentButton count:topic.comment placeHolderTitle:@"评论"];
}

-(void)setupTitleWithBtn:(UIButton *)button count:(NSInteger)count placeHolderTitle:(NSString *)placeHolderTitle
{
    if (count >= 10000) {
        placeHolderTitle = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
        placeHolderTitle = [placeHolderTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    else if (count > 0)
    {
        placeHolderTitle = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeHolderTitle forState:UIControlStateNormal];
}

// 改高度- Y + 10 让cell有间距
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= ZZTopicCellMargin;;
    frame.origin.y += ZZTopicCellMargin;
    
    [super setFrame:frame];
}


- (IBAction)more {
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    
    [sheet showInView:self.superview];
}

// 点击任何Button都会调用
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //
            
            break;
        case 1:  // 举报

            
            break;
        default:
            break;
    }
}

@end
