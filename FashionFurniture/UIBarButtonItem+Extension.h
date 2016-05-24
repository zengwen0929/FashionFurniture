//
//  UIBarButtonItem+Extension.h
//  zengwenaixianmian
//
//  Created by qianfeng on 15/12/8.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title;
@end
