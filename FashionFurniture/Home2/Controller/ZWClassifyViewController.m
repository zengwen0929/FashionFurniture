//
//  ZWClassifyViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWClassifyViewController.h"
#import "ZWNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "MJExtension.h"
#import "ClassifyModel.h"
#import "Tool.h"
#import "AFNetworking.h"
#import "LevelData.h"
#import "ClassifyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZWGoodsViewController.h"
#import "ZWSearchViewController.h"


@interface ZWClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
{
    BOOL firstFlag;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) ClassifyModel *seledtedmodel;
@end

@implementation ZWClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    firstFlag = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"home_search.png" highImage:@"home_search_click.png"title:nil];

    
    [self getDatas];
    [self createTableView];
    

    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    //设置列数
    layout.columnCount = 3;
    layout.sectionInset = UIEdgeInsetsMake(5, 5,5, 5);
    
    //创建UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(90, 0, scrrenW-90, scrrenH-120) collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ClassifyCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
   
    
    
    
}

- (void)search{

    ZWSearchViewController *search  = [[ZWSearchViewController alloc] init];
    
    [self.navigationController pushViewController:search animated:YES];
    

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.seledtedmodel.levelData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath /*当前位置*/
{
    ClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LevelData *model = self.seledtedmodel.levelData[indexPath.item];
  
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.typeUrl] placeholderImage:nil];
    cell.nameLabel.text = model.typeName;
    cell.nameLabel.font = [UIFont systemFontOfSize:14];
    cell.nameLabel.textAlignment = NSTextAlignmentCenter;
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(65, 85);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWGoodsViewController *dVC = [[ZWGoodsViewController alloc] init];
    LevelData *m = self.seledtedmodel.levelData[indexPath.item];
    dVC.typeId = m.typeId;
    dVC.title = m.typeName;
    
    [self.navigationController pushViewController:dVC animated:YES];
    
}



//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}

//创建tableview
-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 90, scrrenH) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = ZWColor(245, 245, 245);
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark - Table view delegate
//返回头部视图的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - 左侧的添加头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90 ,44)];
    UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 44)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageViewClick)];
    [imageView addGestureRecognizer:tap];
    titleName.text = @"所以商品";
    titleName.textAlignment = NSTextAlignmentCenter;
    titleName.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:titleName];
       return imageView;
    
}

- (void)buttonImageViewClick{

    ZWGoodsViewController *goodsVC = [[ZWGoodsViewController alloc] init];
     goodsVC.title = @"排序";

    goodsVC.typeId = @"-1";
 
    [self.navigationController pushViewController:goodsVC animated:YES];
  
}

#pragma mark - Table view data source
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//定制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ZW";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    ClassifyModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.levelName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    self.seledtedmodel = self.dataArray[indexPath.row];

    [self.collectionView reloadData];
    
}

#pragma mark - 数据请求
- (void)getDatas{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.发送请求
    [mgr GET:classifyURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = [ClassifyModel objectArrayWithKeyValuesArray:dict[@"data"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (ClassifyModel *model in array) {
            [arrayM addObject:model];
        }
        [self.dataArray addObjectsFromArray:arrayM];
        
        [self.tableView reloadData];
        if (firstFlag) {
            self.seledtedmodel = self.dataArray[0];
            [self.collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
    
    
}



@end
