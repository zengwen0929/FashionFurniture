//
//  ZWTabBarViewController.m
//  zengwenaixianmian
//
//  Created by zengwen on 15/10/8.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWTabBarViewController.h"
#import "ZWNavigationController.h"
#import "ZWHomeViewController.h"
#import "ZWStyleViewController.h"
#import "ZWClassifyViewController.h"
#import "ZWShoppingViewController.h"
#import "ZWMeViewController.h"
#import "Tool.h"

@interface ZWTabBarViewController ()

@end

@implementation ZWTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
  //  self.view.backgroundColor = [UIColor blackColor];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"home_bottom_bar.png"];
    
    // 1.初始化子控制器
    ZWHomeViewController *home = [[ZWHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"home.png"selectedImage:@"home_select.png"];
    
    ZWStyleViewController *style = [[ZWStyleViewController alloc] init];
    [self addChildVc:style title:@"风格" image:@"style.png" selectedImage:@"style_select.png"];
    
    ZWClassifyViewController *classify = [[ZWClassifyViewController alloc] init];
    [self addChildVc:classify title:@"分类" image:@"classify.png" selectedImage:@"classify_select.png"];
    
    ZWShoppingViewController *shopping = [[ZWShoppingViewController alloc] init];
    [self addChildVc:shopping title:@"购物车" image:@"shopping_trolley.png" selectedImage:@"shopping_trolley_select.png"];
    ZWMeViewController *me = [[ZWMeViewController alloc] init];
    [self addChildVc:me title:@"我" image:@"me.png" selectedImage:@"me_select.png"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
   // childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //    childVc.tabBarItem.title = title; // 设置tabbar的文字
        childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ZWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
  // childVc.view.backgroundColor = ZWRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}
@end
