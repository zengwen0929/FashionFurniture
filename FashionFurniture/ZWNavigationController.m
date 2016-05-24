//
//  ZWNavigationController.m
//  zengwenaixianmian
//
//  Created by qianfeng on 15/12/8.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZWShoppingViewController.h"
#import "ZWHomeViewController.h"

@interface ZWNavigationController ()

@end

@implementation ZWNavigationController

+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  //  NSLog(@"push");
    

    
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        if ([self.viewControllers isKindOfClass:[ZWShoppingViewController class]]) {
            viewController.hidesBottomBarWhenPushed = NO;
        //    NSLog(@"%@",self.vi)
        }
        else{
        viewController.hidesBottomBarWhenPushed = YES;
        }
       // NSLog(@"%@",self.viewControllers);
        //
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"product_back.png" highImage:@"home_scan_click.png"title:nil];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"home_search.png" highImage:@"home_search_click.png"title:nil];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
//#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    
}


@end
