//
//  ZZRecommendTagCell.m
//  百思中州1期
//
//  Created by 👄 on 15/11/10.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "ZZRecommendTagCell.h"
#import "UIImageView+WebCache.h"
#import "ZZRecommendTag.h"

@interface ZZRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end

@implementation ZZRecommendTagCell

- (void)awakeFromNib {

    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    self.iconView.clipsToBounds = YES;
}

-(void)setRecommendTag:(ZZRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    self.nameLabel.text = recommendTag.theme_name;
    self.messageLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}







@end
