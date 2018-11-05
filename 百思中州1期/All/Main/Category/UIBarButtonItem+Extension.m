//
//  UIBarButtonItem+Extension.m
//  百思中州1期
//
//  Created by 👄 on 15/11/5.
//  Copyright (c) 2015年 LK. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)barButtonItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    
    button.width = 30;
    button.height = 30;

    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

@end
