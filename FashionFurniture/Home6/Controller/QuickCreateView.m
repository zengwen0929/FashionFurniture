//
//  QuickCreateView.m
//  华夏二手车
//
//  Created by Jarvan on 15/9/20.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import "QuickCreateView.h"

@implementation QuickCreateView

/** 快速创建系统按键*/
+ (UIButton *)addSystemButtonWithFrame:(CGRect)frame title:(NSString *)title tag:(int)tag target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/** 快速创建图片按键*/
+ (UIButton *)addCustomButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image bgImage:(UIImage *)bgImage tag:(int)tag target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
 
    
    return button;
}

/** 快速创标签*/
+ (UILabel *)addLableWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color{
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = frame;
    lable.text = text;
    lable.textColor = color;
    //    lable.textAlignment = NSTextAlignmentCenter;
    //    lable.backgroundColor = [UIColor redColor];
    
    return lable;
}

/** 快速图片视图*/
+ (UIImageView *)addImageViewWithFrame:(CGRect)frame
                                 image:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = frame;
    imageView.image = image;
    
    return imageView;
}
 /**按钮偏移的视图*/
+ (UIButton *)addCustomButtonDeviateWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image bgImage:(UIImage *)bgImage tag:(int)tag target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -25, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -28);
    
    return button;
}


@end
