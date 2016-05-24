//
//  ZWShoppingViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWShoppingViewController.h"
#import "MJExtension.h"
#import "ClassifyModel.h"
#import "Tool.h"
#import "AFNetworking.h"
#import "QuickCreateView.h"
#import "ZWHomeViewController.h"


@interface ZWShoppingViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZWShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
   // [self getDatas];
   
    //没有登录之前的界面
    [self getUI];

}
- (void)getUI{

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 80, 80);
    imageView.center = CGPointMake(scrrenW/2, scrrenH/3);
    imageView.image  = [UIImage imageNamed:@"shopping_icon@2x.png"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 140, 50);
    label.center = CGPointMake(scrrenW/2, scrrenH/2.3);
   label.text = @"你懂的购物车还是空的哦~赶紧去挑选宝贝吧";
    label.numberOfLines = 0;
    label.font =[UIFont systemFontOfSize:12];
    label.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:label];

    UIImage *image = [UIImage imageNamed:@"shopping_btn_bg.png"];
    UIButton *button = [QuickCreateView addCustomButtonWithFrame:CGRectMake(0, 0, 80, 30) title:@"去挑选" image:nil bgImage:image tag:100 target:self action:@selector(click)];
    button.center = CGPointMake(scrrenW/2, scrrenH/2);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:button];

}

- (void)click{

    self.tabBarController.selectedIndex = 0;

}

@end
