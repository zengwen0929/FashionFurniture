//
//  ZWStyleViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWStyleViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "AFNetworking.h"
#import "StyleModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "StyleCollectionViewCell.h"
#import "Tool.h"
#import "ZWStyleDescViewController.h"


@interface ZWStyleViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ZWStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDatas];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建瀑布流布局,每个item的大小,都是动态设置的
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    //设置列数
    layout.columnCount = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //创建UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, scrrenW, scrrenH-120) collectionViewLayout:layout];
    
 self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"StyleCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = scrrenW;
    CGFloat height = 150; //实际上应该从服务器中获取
    
    return CGSizeMake(width, height);
}


#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     StyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    StyleModel *model = self.dataArray[indexPath.item];
 
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
    
    return cell;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}


- (void)getDatas{
    
      AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    
    // 3.发送请求
    [mgr GET:@"http://116.204.13.36:7777/api/goods/getProductStyleList?page=1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
      //  NSLog(@"%@",dict);
        
        NSArray *array = [StyleModel objectArrayWithKeyValuesArray:dict[@"data"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (StyleModel *model in array) {
          
            [arrayM addObject:model];
        }
        [self.dataArray addObjectsFromArray:arrayM];
        
        [self.collectionView reloadData];
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   ZWStyleDescViewController  *dVC = [[ZWStyleDescViewController alloc] init];
    StyleModel *m = self.dataArray[indexPath.item];
    
    dVC.productStyleId = m.productStyleId;
    dVC.title = m.styleName;
    
    [self.navigationController pushViewController:dVC animated:YES];
    
}






@end
