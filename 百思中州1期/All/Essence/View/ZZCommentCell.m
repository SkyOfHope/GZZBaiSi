//
//  ZZCommentCell.m
//  百思中州1期
//
//  Created by 👄 on 15/11/11.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZCommentCell.h"
#import "ZZComment.h"
#import "ZZUser.h"

@interface ZZCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation ZZCommentCell

- (void)awakeFromNib {
    
    self.autoresizingMask = UIViewAutoresizingNone;

}


-(void)setComment:(ZZComment *)comment
{
    _comment = comment;
    
    // 头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image]];
    
    // 性别
    if ([comment.user.sex isEqualToString:@"m"]) {
    
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }
    else
    {
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    // 昵称
    self.nameLabel.text = comment.user.username;
    
    // 内容
    self.text_label.text = comment.content;
    
    // 点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    
    // 隐藏声音Button
    self.voiceButton.hidden = comment.voiceuri.length == 0 ? YES : NO;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}




@end
