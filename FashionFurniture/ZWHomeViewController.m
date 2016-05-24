//
//  ZWHomeViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWHomeViewController.h"
#import "ZWNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "AFNetworking.h"
#import "HomeModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "ButtonTitle.h"
#import "ButtomModel.h"
#import "Tool.h"
#import "ZWGoodsViewController.h"
#import "ZWDetaiViewController.h"
#import "ZWSearchViewController.h"




@interface ZWHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollViewShow;

@property (nonatomic,strong) NSMutableArray *DBImageNameArray;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic,strong) NSMutableArray *bottomdataArray;


@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIView *buttonView;
@property (nonatomic,strong) NSMutableArray *titleNameArray;
@property (nonatomic,strong) NSMutableArray *dataNameAndStyle;
@property (nonatomic,strong) UIView *productView;
@property (nonatomic,strong) UIView *chuxiaoProductView;


@property (nonatomic,strong) UIView *imagesView;
@property (nonatomic,copy) NSString *productUrl;

@property (nonatomic,strong) NSDictionary *dict;

@end

@implementation ZWHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];

  

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"home_scan.png" highImage:@"home_scan_click.png"title:nil];
    

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"home_search.png" highImage:@"home_search_click.png"title:nil];
    
   
    
    // 最外层滚动视图
    [self createShowCrollView];

    
    [self getDatas];
    
    
  
}

- (void)search{
    
    ZWSearchViewController *search  = [[ZWSearchViewController alloc] init];
    
    [self.navigationController pushViewController:search animated:YES];
    
    
}

-(NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        self.imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
    
    
}

-(NSMutableArray *)bottomdataArray{
    if (!_bottomdataArray) {
        self.bottomdataArray = [NSMutableArray array];
    }
    return _bottomdataArray;
    
    
}



-(NSMutableArray *)titleNameArray{
    if (!_titleNameArray) {
        self.titleNameArray = [NSMutableArray array];
    }
    return _titleNameArray;
    
    
}

-(NSMutableArray *)dataNameAndStyle{
    if (!_dataNameAndStyle) {
        self.dataNameAndStyle = [NSMutableArray array];
    }
    return _dataNameAndStyle;
    
    
}


-(NSMutableArray *)DBImageNameArray{
    if (!_DBImageNameArray) {
        self.DBImageNameArray = [NSMutableArray array];
    }
    return _DBImageNameArray;
    

}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
    
}


- (void)createShowCrollView{
    self.scrollViewShow = [[UIScrollView alloc] initWithFrame:CGRectMake(0 ,0 ,scrrenW , scrrenH-108)];
   
    self.scrollViewShow.backgroundColor = ZWColor(245, 245, 245);

    

    [self.view addSubview:self.scrollViewShow];
}


//获取数据
- (void)getDatas{

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    NSString *url = @"http://116.204.13.36:7777/api/adImage/list";
    [mgr GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
      
        self.dict = dict;
        
      
        NSArray *array3 = [ButtomModel objectArrayWithKeyValuesArray:dict[@"data"][@"yushou"][@"adImages"]];
        NSMutableArray *arrayMI = [NSMutableArray array];
        NSMutableArray *arrayMD = [NSMutableArray array];
        for (ButtomModel*model in array3) {
            [arrayMI addObject:model.picUrl];
            [arrayMD addObject:model];
            
        }
        [self.imagesArray addObjectsFromArray:arrayMI];
        [self.bottomdataArray addObjectsFromArray:arrayMD];
        

        
        

        
        NSArray *array2 = [ButtonTitle objectArrayWithKeyValuesArray:dict[@"data"][@"productType"]];
        NSMutableArray *arrayMT = [NSMutableArray array];
        NSMutableArray *arrayMS = [NSMutableArray array];
        for (ButtonTitle *model in array2) {
            [arrayMT addObject:model.name];
            [arrayMS addObject:model];
            
        }
        [self.titleNameArray addObjectsFromArray:arrayMT];
        [self.dataNameAndStyle addObjectsFromArray:arrayMS];
        
        
        NSArray *array = [HomeModel objectArrayWithKeyValuesArray:dict[@"data"][@"dingbu"][@"adImages"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        NSMutableArray *arrayM2 = [NSMutableArray array];
        for (HomeModel *model in array) {
            [arrayM2 addObject:model];
            [arrayM addObject:model.picUrl];
        }
        [self.DBImageNameArray addObjectsFromArray:arrayM];
        [self.dataArray addObjectsFromArray:arrayM2];
       [self createScrollView];
    
        [self createPageControll];
        [self createTimer];
        [self createButtonView];
        [self createProductView];
        [self createchuxiaoProductView];
        [self createimagesView];
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];


}

- (void)createButtonView{

    NSInteger index = 0;
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+5,scrrenW, scrrenW*0.22)];
   self.buttonView.backgroundColor = [UIColor whiteColor];
    [self.scrollViewShow addSubview:self.buttonView];

    for (NSInteger k = 0; k<4; k++) {
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(15+k*scrrenW/4, scrrenW*0.22/2, 64, 1)];
        lineView.image =[UIImage imageNamed:@"home_bottom_bar.png"];
        [self.buttonView addSubview:lineView];
        
    }
    
    
    for (NSInteger i = 0; i<2; i++) {
        
        for (NSInteger j= 0; j<4; j++) {
            
            UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/4*j, 2+scrrenW*0.22/2*i, scrrenW/4, 30)];
            buttonImageView.userInteractionEnabled = YES;
            buttonImageView.tag = 100+index;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageViewClick:)];
            
            [buttonImageView addGestureRecognizer:tap];

           
            [self.buttonView addSubview:buttonImageView];
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrrenW/4-1, 30)];
           // nameLabel.backgroundColor = [UIColor yellowColor];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.text = self.titleNameArray[index++];
            [buttonImageView addSubview:nameLabel];
            

        }
              
    }

}

- (void)createimagesView{

    self.imagesView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chuxiaoProductView.frame)+10, scrrenW, self.bottomdataArray.count*200)];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, scrrenW/2-70, 1)];
    line.image = [UIImage imageNamed:@"home_bottom_bar.png"];
    [self.imagesView addSubview:line];
    
    UIImageView *yushou = [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/2-40, 8, 80, 17)];
    yushou.image = [UIImage imageNamed:@"home_time.png"];
    [self.imagesView addSubview:yushou];

    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/2+50, 14, scrrenW/2-70, 1)];
    line2.image = [UIImage imageNamed:@"home_bottom_bar.png"];
    [self.imagesView addSubview:line2];

    
    
  //  NSLog(@"%ld",self.bottomdataArray.count*200);
    
    self.imagesView.backgroundColor = [UIColor whiteColor];
    [self.scrollViewShow addSubview:self.imagesView];
    
    for (NSInteger i = 0; i<self.bottomdataArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30+i*(200+5), scrrenW, 200)];
        imageView.userInteractionEnabled = YES;
        imageView.tag =100+i;
        
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttomImagesViewClick:)];
        [imageView addGestureRecognizer:tap];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[i]] placeholderImage:nil];
        [self.imagesView addSubview:imageView];
        
    }
 
    self.scrollViewShow.contentSize = CGSizeMake(scrrenW, CGRectGetMaxY(self.imagesView.frame)+50);
}
-(void)buttomImagesViewClick:(UIGestureRecognizer *)t{

       NSLog(@"---");
    ZWDetaiViewController *dVC = [[ZWDetaiViewController alloc] init];

    if (t.view.tag == 100) {
        dVC.goodsId =self.dict[@"data"][@"yushou"][@"adImages"][0][@"productId"];
    }
    
    if (t.view.tag == 101) {
        dVC.goodsId =self.dict[@"data"][@"yushou"][@"adImages"][1][@"productId"];
    }
    
    if (t.view.tag == 102) {
        dVC.goodsId =self.dict[@"data"][@"yushou"][@"adImages"][0][@"productId"];
    }
    
    
   
    
    [self.navigationController pushViewController:dVC animated:YES];
    


}



-(void)buttonImageViewClick:(UITapGestureRecognizer *)t
{
    
    ZWGoodsViewController *goodsVC = [[ZWGoodsViewController alloc] init];
    ButtonTitle *m = self.dataNameAndStyle[t.view.tag-100];
 
    
    
    goodsVC.typeId = m.typeid;
    goodsVC.title =@"排序";

    
    [self.navigationController pushViewController:goodsVC animated:YES];

    

}

- (void)createProductView
{

    self.productView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buttonView.frame)+5,scrrenW, scrrenW/2+10)];
   // self.productView.backgroundColor = [UIColor whiteColor];
    [self.scrollViewShow addSubview:self.productView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrrenW/2, scrrenW/2+10)];
    imageView1.backgroundColor = [UIColor whiteColor];
    imageView1.tag = 101;
    imageView1.userInteractionEnabled = YES;
    [self addTapGestureRecognizerInImageViewWithImageView:imageView1];
    UIImageView *subImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 145/2, 17)];
    subImageView.image =[UIImage imageNamed:@"home_new.png"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 19, 180, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = self.dict[@"data"][@"xinpin"][@"adImages"][0][@"title"];
    [imageView1 addSubview:subImageView];
    [imageView1 addSubview:titleLabel];
    
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.dict[@"data"][@"xinpin"][@"adImages"][0][@"picUrl"]] placeholderImage:nil];
    [self.productView addSubview:imageView1];
    UIImageView *bgImageView= [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/2, 0, scrrenW/2, (scrrenW/2+10)/2)];
    bgImageView.tag = 102;
    bgImageView.backgroundColor = [UIColor whiteColor];
    bgImageView.userInteractionEnabled = YES;
    [self addTapGestureRecognizerInImageViewWithImageView:bgImageView];
    [self.productView addSubview:bgImageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/4, 0, (scrrenW/2-1)/2, (scrrenW/2+10)/2)];
    

    ///imageView2.userInteractionEnabled = YES;
  
   UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, scrrenW/4, 20)];
    titleLabel2.font = [UIFont systemFontOfSize:14];
    titleLabel2.text = self.dict[@"data"][@"xinpin"][@"adImages"][1][@"title"];
    [bgImageView addSubview:titleLabel2];
    
    UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, scrrenW/4, 20)];
    titleLabel3.font = [UIFont systemFontOfSize:14];
    titleLabel3.text = self.dict[@"data"][@"xinpin"][@"adImages"][1][@"subtitle"];
    [bgImageView addSubview:titleLabel3];
    
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.dict[@"data"][@"xinpin"][@"adImages"][1][@"picUrl"]] placeholderImage:nil];
    [bgImageView addSubview:imageView2];
//    
    
    
    UIImageView *bgImageView2= [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/2, (scrrenW/2+10)/2, scrrenW/2, (scrrenW/2+10)/2)];
    bgImageView2.tag = 103;
    bgImageView2.userInteractionEnabled = YES;
    [self addTapGestureRecognizerInImageViewWithImageView:bgImageView2];
    bgImageView2.backgroundColor = [UIColor whiteColor];
    [self.productView addSubview:bgImageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/4, 0, (scrrenW/2-1)/2, (scrrenW/2+10)/2)];
    
    
    
    ///imageView2.userInteractionEnabled = YES;
    
    UILabel *titleLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, scrrenW/4, 20)];
    titleLabel4.font = [UIFont systemFontOfSize:14];
    titleLabel4.text = self.dict[@"data"][@"xinpin"][@"adImages"][2][@"title"];
    [bgImageView2 addSubview:titleLabel4];
    
    UILabel *titleLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, scrrenW/4, 20)];
    titleLabel5.font = [UIFont systemFontOfSize:14];
    titleLabel5.text = self.dict[@"data"][@"xinpin"][@"adImages"][2][@"subtitle"];
    [bgImageView2 addSubview:titleLabel5];
    
    [imageView3 sd_setImageWithURL:[NSURL URLWithString:self.dict[@"data"][@"xinpin"][@"adImages"][2][@"picUrl"]] placeholderImage:nil];
    [bgImageView2 addSubview:imageView3];

    
    

}

- (void)createchuxiaoProductView
{
    
    self.chuxiaoProductView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.productView.frame)+5,scrrenW, scrrenW/2+10)];
    // self.productView.backgroundColor = [UIColor whiteColor];
    [self.scrollViewShow addSubview:self.chuxiaoProductView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(scrrenW/2, 0, scrrenW/2, scrrenW/2+10)];
    imageView1.backgroundColor = [UIColor whiteColor];
    imageView1.tag = 104;
    imageView1.userInteractionEnabled = YES;
    [self addTapGestureRecognizerInImageViewWithImageView:imageView1];
    UIImageView *subImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 145/2, 17)];
    subImageView.image =[UIImage imageNamed:@"home_hot.png"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 19, 180, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = self.dict[@"data"][@"chuxiao"][@"adImages"][2][@"title"];
    [imageView1 addSubview:subImageView];
    [imageView1 addSubview:titleLabel];
    
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.dict[@"data"][@"chuxiao"][@"adImages"][2][@"picUrl"]] placeholderImage:nil];
    [self.chuxiaoProductView addSubview:imageView1];
    UIImageView *bgImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrrenW/2, (scrrenW/2+10)/2)];
    bgImageView.tag = 105;
    bgImageView.backgroundColor = [UIColor whiteColor];

    bgImageView.userInteractionEnabled = YES;
    [self addTapGestureRecognizerInImageViewWithImageView:bgImageView];
      [self.chuxiaoProductView addSubview:bgImageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (scrrenW/2-1)/2, (scrrenW/2+10)/2)];
    
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.dict[@"data"][@"chuxiao"][@"adImages"][0][@"picUrl"]] placeholderImage:nil];
    [bgImageView addSubview:imageView2];
   
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(scrrenW/4+5, 25, scrrenW/4, 20)];
    titleLabel2.font = [UIFont systemFontOfSize:14];
    titleLabel2.text = self.dict[@"data"][@"chuxiao"][@"adImages"][0][@"title"];
    [bgImageView addSubview:titleLabel2];
    
    UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(scrrenW/4+5, 50, scrrenW/4, 20)];
    titleLabel3.font = [UIFont systemFontOfSize:14];
    titleLabel3.text = self.dict[@"data"][@"chuxiao"][@"adImages"][0][@"subtitle"];
    [bgImageView addSubview:titleLabel3];
   
   
   
    UIImageView *bgImageView2= [[UIImageView alloc] initWithFrame:CGRectMake(0, (scrrenW/2+10)/2, scrrenW/2, (scrrenW/2+10)/2)];
    bgImageView2.tag = 106;
    bgImageView2.userInteractionEnabled = YES;
    [self addTapGestureRecognizerInImageViewWithImageView:bgImageView2];
    bgImageView2.backgroundColor = [UIColor whiteColor];
    [self.chuxiaoProductView addSubview:bgImageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (scrrenW/2-1)/2, (scrrenW/2+10)/2)];
   
    [imageView3 sd_setImageWithURL:[NSURL URLWithString:self.dict[@"data"][@"chuxiao"][@"adImages"][1][@"picUrl"]] placeholderImage:nil];
        [bgImageView2 addSubview:imageView3];

    
    UILabel *titleLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(scrrenW/4+5, 25, scrrenW/4, 20)];
    titleLabel4.font = [UIFont systemFontOfSize:14];
    titleLabel4.text = self.dict[@"data"][@"chuxiao"][@"adImages"][1][@"title"];
    [bgImageView2 addSubview:titleLabel4];
    
    UILabel *titleLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(scrrenW/4+5, 50, scrrenW/4, 20)];
    titleLabel5.font = [UIFont systemFontOfSize:14];
    titleLabel5.text = self.dict[@"data"][@"chuxiao"][@"adImages"][1][@"subtitle"];
    [bgImageView2 addSubview:titleLabel5];
 
}



- (void)createPageControll{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, 0, scrrenW/2, 30);
    _pageControl.center = CGPointMake(scrrenW/2, CGRectGetMaxY(_scrollView.frame)-13);
    _pageControl.numberOfPages = self.DBImageNameArray.count - 2;
    _pageControl.currentPage = _currentPage - 1;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_scrollViewShow addSubview:_pageControl];
}


#pragma mark - 4、实现自动滚动
- (void)createTimer{
    [self startTimer];
}

- (void)startTimer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(upData) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)upData{
 
    // 滚动动画
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + scrrenW, 0) animated:YES];
}


#pragma mark - 3、实现分页控件与视图的联动
// 结束滚动(只有是拖拽的时候才会有滚动的操作)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 当前页
    _currentPage = _scrollView.contentOffset.x / scrrenW;

    // 改变
    _pageControl.currentPage = _currentPage - 1;
    
    // 循环处理
    [self scrollViewChangeOffSet];
}

// 滚动动画结束(偏移动画才会调用操作)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //    NSLog(@"----");
    _currentPage = _scrollView.contentOffset.x / scrrenW;
    _pageControl.currentPage =_currentPage - 1;
    
    
    // 循环处理
    [self scrollViewChangeOffSet];
}

// 开始拖动,停止时钟
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}


// 结束拖动,开启时钟
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewChangeOffSet{
    if (_currentPage == self.DBImageNameArray.count-1) {
        _currentPage = 1;
    }
    else if (_currentPage == 0){
        _currentPage = self.DBImageNameArray.count - 2;
    }
    
    [_scrollView setContentOffset:CGPointMake(scrrenW * _currentPage, 0) animated:NO];
    _pageControl.currentPage = _currentPage - 1;
}



- (void)createScrollView{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, scrrenW, scrrenW*0.625);
    
    
    
    // 图片的处理（头尾添加）
    // 数组前面添加最后一张图片
    NSString *str = self.DBImageNameArray[self.DBImageNameArray.count-1];
    [self.DBImageNameArray insertObject:str atIndex:0];
    // 数组最后面添加要显示的第一张图片

    [self.DBImageNameArray addObject:self.DBImageNameArray[1]];
    
    
    // 内容大小
    _scrollView.contentSize = CGSizeMake(scrrenW*self.DBImageNameArray.count, 0);
   

    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    // 设置成为代理
    _scrollView.delegate = self;
    
    // 图片的拼接
    for (int i=0; i<self.DBImageNameArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(scrrenW*i, 0, scrrenW, scrrenW*0.625);
        imageView.tag = 100+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        
        [imageView addGestureRecognizer:tap];

        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.DBImageNameArray[i]] placeholderImage:nil];
        
        //imageView.image = [UIImage imageNamed:self.DBImageNameArray[i]];
  
        [_scrollView addSubview:imageView];
        
       
    }
    // 当前页
    _scrollView.contentOffset = CGPointMake(scrrenW, 0);
    _currentPage = 1;
    
    //    [self.view addSubview:_scrollView];
    [_scrollViewShow addSubview:_scrollView];
    

}

- (void)imageViewClick:(UITapGestureRecognizer *)t
{

    ZWGoodsViewController *goodsVC = [[ZWGoodsViewController alloc] init];
    HomeModel *m = self.dataArray[t.view.tag-100-1];
    
    goodsVC.typeId = m.productType;
    goodsVC.title =@"排序";
    NSLog(@"%@",m.adImageId);

    [self.navigationController pushViewController:goodsVC animated:YES];

}

- (void)addTapGestureRecognizerInImageViewWithImageView:(UIImageView *)imageView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewXinpingAndChuxiaoClick:)];
    
    [imageView addGestureRecognizer:tap];
}



-(void)imageViewXinpingAndChuxiaoClick:(UIGestureRecognizer *)t
{
    ZWDetaiViewController *dVC = [[ZWDetaiViewController alloc] init];
    
   
    
    if (t.view.tag == 101) {
        dVC.goodsId =self.dict[@"data"][@"xinpin"][@"adImages"][0][@"productId"];
    }
    
    if (t.view.tag == 102) {
        dVC.goodsId =self.dict[@"data"][@"xinpin"][@"adImages"][1][@"productId"];
    }
    
    if (t.view.tag == 103) {
        dVC.goodsId =self.dict[@"data"][@"xinpin"][@"adImages"][2][@"productId"];
    }
    
    
    if (t.view.tag == 104) {
        dVC.goodsId =self.dict[@"data"][@"chuxiao"][@"adImages"][0][@"productId"];
    }
    
    if (t.view.tag == 105) {
        dVC.goodsId =self.dict[@"data"][@"chuxiao"][@"adImages"][2][@"productId"];
    }
    
    if (t.view.tag == 106) {
        dVC.goodsId =self.dict[@"data"][@"chuxiao"][@"adImages"][1][@"productId"];
    }
    
    [self.navigationController pushViewController:dVC animated:YES];


}

@end
