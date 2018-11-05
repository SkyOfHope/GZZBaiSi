//
//  ZZCommentHeaderView.m
//  百思
//
//  Created by 👄 on 15/10/10.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import "ZZCommentHeaderView.h"

@interface ZZCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation ZZCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    ZZCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[ZZCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = ZZGlobalBg;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = ZZRGBColor(67, 67, 67);
        label.width = 200;
        label.x = 5;
        label.font = [UIFont systemFontOfSize:14];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}

@end
