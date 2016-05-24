//
//  ZWDetaiViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "ZWDetaiViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "Tool.h"
#import "DetaiModel.h"
#import "QuickCreateView.h"
#import "HWAccountTool.h"
#import "HWAccount.h"
#import "ZWBuyViewController.h"
#import "UIBarButtonItem+Extension.h"
#define padding1 10

@interface ZWDetaiViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollViewShow;
@property (nonatomic,strong) NSMutableArray *DBImageNameArray;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSDictionary *dict;


@end

@implementation ZWDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   UIBarButtonItem *rightbutton1 = [UIBarButtonItem itemWithTarget:self action:@selector(shooping) image:@"product_trolley" highImage:nil title:nil];

    UIBarButtonItem *rightbutton2 = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"product_more" highImage:nil title:nil];
    
    self.navigationItem.rightBarButtonItems = @[rightbutton2,rightbutton1];
    
    
    // 最外层滚动视图
    [self createShowCrollView];
    [self getDatas];
    [self createImageViewButton];
   
}
-(NSMutableArray *)DBImageNameArray{
    if (!_DBImageNameArray) {
        self.DBImageNameArray = [NSMutableArray array];
    }
    return _DBImageNameArray;
    
    
}



- (void)createShowCrollView{
    self.scrollViewShow = [[UIScrollView alloc] initWithFrame:CGRectMake(0 ,0 ,scrrenW , scrrenH-108)];
    
    self.scrollViewShow.backgroundColor = ZWColor(245, 245, 245);
    
    self.scrollViewShow.contentSize = CGSizeMake(scrrenW,1000);
    
    [self.view addSubview:self.scrollViewShow];
   

    UIView *view1 = [[NSBundle mainBundle]loadNibNamed:@"DetailView" owner:self options:nil][0];
    view1.frame = CGRectMake(0, 340, 375, 450);

    
    [self.scrollViewShow addSubview:view1];

}

//获取数据
- (void)getDatas{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters=@{@"goodsId":self.goodsId};
    NSString *url = @"http://116.204.13.36:7777/api/goods/getDetail";
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        self.dict = dict;
        
        NSLog( @"%@",dict);
        NSArray *array= dict[@"data"][@"goodsPic"];
    
        [self.DBImageNameArray addObjectsFromArray:array];

        DetaiModel *model = [DetaiModel objectWithKeyValues:dict[@"data"]];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 285, scrrenW, 55)];
        
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0,scrrenW-2*padding, 35)];
        label.text =model.goodsName;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        [view addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(padding, 35,100, 20)];
        label2.text =[NSString stringWithFormat:@"￥%@.00",model.goodsPrice];
        label2.font = [UIFont systemFontOfSize:14];
       //label2.numberOfLines = 0;
        [view addSubview:label2];

        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(110, 35,100, 20)];
        label3.text =[NSString stringWithFormat:@"￥%@.00", model.goodsOldPrice];
        label3.font = [UIFont systemFontOfSize:14];
        
        [view addSubview:label3];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 44,80, 2)];
        imageView.image = [UIImage imageNamed:@"home_bottom_bar.png"];
        [view addSubview:imageView];
       
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(280, 35,80, 20)];
        label4.text =[NSString stringWithFormat:@"销量%@件",model.goodsBuyCount];
        label4.font = [UIFont systemFontOfSize:14];
        //label2.numberOfLines = 0;
        [view addSubview:label4];
        
        
        [self.scrollViewShow addSubview:view];
        
        
        
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
        
        //读取模板内容
        NSString *temp = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSString *json =[NSString stringWithFormat:@"</br></br>%@",model.desc] ;
        
        NSString *html = [NSString stringWithFormat:temp, json];
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 545, scrrenW, 450)];
        
        [webView loadHTMLString:html baseURL:nil];
        webView.scalesPageToFit = YES;
        
        [self.scrollViewShow addSubview:webView];
        
        
        [self createScrollView];
        
        [self createPageControll];
        [self createTimer];
//        [self createButtonView];
//        [self createProductView];
//        [self createchuxiaoProductView];
//        [self createimagesView];
//        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
    
    
}

#pragma mark - 底部的购物车和购买按钮
- (void)createImageViewButton{

    UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrrenH-108, scrrenW, 44)];
    buttonImageView.backgroundColor = ZWColor(240, 240, 240);
   // buttonImageView.image  = [UIImage imageNamed:@"product_bg3"]
    buttonImageView .userInteractionEnabled = YES;
    [self.view addSubview:buttonImageView];

    UIButton *button = [QuickCreateView  addCustomButtonWithFrame:CGRectMake(50, 5, 110, 35) title:nil image:[UIImage imageNamed:@"product_add_btn"] bgImage:nil tag:100 target:self action:@selector(clickShooping:)];
    
    
    [buttonImageView addSubview:button];
    
    UIButton *button1 = [QuickCreateView  addCustomButtonWithFrame:CGRectMake(230, 5, 110, 35) title:nil image:[UIImage imageNamed:@"product_buy_btn"] bgImage:nil tag:101 target:self action:@selector(clickShooping:)];
    
    [buttonImageView addSubview:button1];

    

}

#pragma mark - 商品点击购买和假日购物车
- (void)clickShooping:(UIButton *)button{

    HWAccount *account = [HWAccountTool account];
    if (account) {
        if (button.tag ==100) {
            
            NSLog(@"100");
            
            
        }
        
        if (button.tag ==101) {
            ZWBuyViewController *buy = [[ZWBuyViewController alloc] init];
            
            buy.model = [DetaiModel objectWithKeyValues:self.dict[@"data"]];
            
            [self.navigationController pushViewController:buy animated:YES];
           

        }


    }
    
    else{
        NSLog(@"请登录");
    
    }

}

#pragma mark - 创建页码控件
- (void)createPageControll{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, 0, scrrenW/2, 30);
    _pageControl.center = CGPointMake(scrrenW/2, CGRectGetMaxY(_scrollView.frame)-13);
    _pageControl.numberOfPages = self.DBImageNameArray.count - 2;
    _pageControl.currentPage = _currentPage - 1;
    _pageControl.pageIndicatorTintColor = ZWColor(190, 190, 190);
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [_scrollViewShow addSubview:_pageControl];
}


#pragma mark - 4、实现自动滚动
- (void)createTimer{
    [self startTimer];
}

- (void)startTimer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(upData) userInfo:nil repeats:YES];
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
    _scrollView.frame = CGRectMake(0, 0, scrrenW, scrrenW*0.625+50);
    
    
    
    // 图片的处理（头尾添加）
    // 数组前面添加最后一张图片
    NSString *str = self.DBImageNameArray[self.DBImageNameArray.count-1];
    [self.DBImageNameArray insertObject:str atIndex:0];
    // 数组最后面添加要显示的第一张图片
    
    [self.DBImageNameArray addObject:self.DBImageNameArray[1]];
    
    
    // 内容大小
    _scrollView.contentSize = CGSizeMake(scrrenW*self.DBImageNameArray.count, 0);
    _scrollView.backgroundColor = [UIColor whiteColor];
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
        imageView.frame = CGRectMake(20+scrrenW*i, 20, scrrenW-40, scrrenW*0.625);
        imageView.tag = 100+i;

        [imageView sd_setImageWithURL:[NSURL URLWithString:self.DBImageNameArray[i]] placeholderImage:nil];
        
        [_scrollView addSubview:imageView];
        
        
    }
    
    
    // 当前页
    _scrollView.contentOffset = CGPointMake(scrrenW, 0);
    _currentPage = 1;
    
    //    [self.view addSubview:_scrollView];
    [_scrollViewShow addSubview:_scrollView];
    
    
}



@end
