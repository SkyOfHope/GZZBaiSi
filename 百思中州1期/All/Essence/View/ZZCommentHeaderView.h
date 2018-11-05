//
//  NTCommentHeaderView.h
//  百思
//
//  Created by 👄 on 15/10/10.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCommentHeaderView : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
