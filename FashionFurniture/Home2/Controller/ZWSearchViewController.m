//
//  ZWSearchViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "ZWSearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "SearchResultViewController.h"

@interface ZWSearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation ZWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"evaluate_write_bg" highImage:nil title:@"搜索"];
    
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    searchBar.placeholder = @"搜索商品";
    searchBar.backgroundImage = [UIImage imageNamed:@"evaluate_write_bg"];
    self.searchBar =searchBar;
    self.navigationItem.titleView = searchBar;
    
    
}

- (void)search{

    SearchResultViewController *srVC = [[SearchResultViewController alloc] init];
    srVC.searchResult = self.searchBar.text;
    [self.navigationController pushViewController:srVC animated:YES];
    
    [self.searchBar resignFirstResponder];


}

#pragma mark - 搜索框代理方法
/**
 *  键盘弹出:搜索框开始编辑文字
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
  
    
   
    
    // 3.显示搜索框右边的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
   
  }

/**
 *  键盘退下:搜索框结束编辑文字
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
  
    // 3.隐藏搜索框右边的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
 
    
  
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
