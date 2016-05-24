//
//  ZWGoodsViewController.m
//  设计典范
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "ZWGoodsViewController.h"
#import "AFNetworking.h"
#import "GoodsModel.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "UIImageView+WebCache.h"
#import "Tool.h"
#import "ZWGoodsCollectionViewCell.h"
#import "MJExtension.h"
#import "ZWNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "MJRefresh.h"
#import "ZWDetaiViewController.h"
@interface ZWGoodsViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout,MJRefreshBaseViewDelegate>
@property(nonatomic,strong)MJRefreshHeaderView *mjRefreshHeaderView;
@property(nonatomic,strong)MJRefreshFooterView *mjRefreshFooterView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIScrollView *scrollShowView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;

@end

@implementation ZWGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
      
    [self getDatas];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建瀑布流布局,每个item的大小,都是动态设置的
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    //设置列数
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //创建UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, scrrenW, scrrenH-120) collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZWGoodsCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    _mjRefreshHeaderView=[[MJRefreshHeaderView alloc]initWithScrollView:self.collectionView];
    _mjRefreshFooterView=[[MJRefreshFooterView alloc]initWithScrollView:self.collectionView];
    _mjRefreshHeaderView.delegate=self;
    _mjRefreshFooterView.delegate=self;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = scrrenW/2;
    CGFloat height = 215; //实际上应该从服务器中获取
    
    return CGSizeMake(width, height);
}


#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZWGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GoodsModel *model = self.dataArray[indexPath.item];
    
    [cell.imagView sd_setImageWithURL:[NSURL URLWithString:model.goodsPic] placeholderImage:nil];
    cell.nameLabel.text = model.goodsName;
    cell.nameLabel.textAlignment = NSTextAlignmentLeft;
    cell.nameLabel.numberOfLines = 0;

    cell.nameLabel.font = [UIFont systemFontOfSize:12];
    
    cell.PriceLabel.text = [NSString stringWithFormat:@"￥%@.00",model.goodsPrice];
    //cell.PriceLabel.backgroundColor = [UIColor yellowColor];
 
    cell.PriceLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     ZWDetaiViewController *dVC = [[ZWDetaiViewController alloc] init];
     GoodsModel *m = self.dataArray[indexPath.item];
    
     dVC.goodsId = m.goodsId;
   //  dVC.titleName = m.title;
    
     [self.navigationController pushViewController:dVC animated:YES];
    
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

   NSDictionary *parameters=@{@"moneyType":@"0",Kpage:@(_page),@"typeId":self.typeId,@"orderby":@"newproduct"};
    self.url=@"http://116.204.13.36:7777/api/goods/getTypeGoods";
   // NSLog(@"%@",self.typeId);
   // NSLog(@"%@",self.url);
    // 3.发送请求
    [mgr GET:self.url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (_page==1) {
            [_dataArray removeAllObjects];
        }
        
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
          NSLog(@"%@",dict);
        
        NSArray *array = [GoodsModel objectArrayWithKeyValuesArray:dict[@"data"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (GoodsModel *model in array) {
            
            [arrayM addObject:model];
        }
        [self.dataArray addObjectsFromArray:arrayM];
        
        [self.collectionView reloadData];
        
        [_mjRefreshHeaderView endRefreshing];
        [_mjRefreshFooterView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
    
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView==_mjRefreshHeaderView)
    {
        _page=1;
        [self getDatas];
        
    }
    else
    {
        _page++;
        [self getDatas];
    }
}
- (void)dealloc{
    
    [_mjRefreshFooterView free];
    [_mjRefreshHeaderView free];
    
}

@end
