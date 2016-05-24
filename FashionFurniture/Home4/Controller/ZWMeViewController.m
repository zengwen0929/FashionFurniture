//
//  ZWMeViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWMeViewController.h"
#import "MeDataModel.h"
#import "Tool.h"
#import "QuickCreateView.h"
#import "UIBarButtonItem+Extension.h"
#import "ZWRegisterViewController.h"
#import "ZWLoginViewController.h"
#import "HWAccountTool.h"
#import "HWAccount.h"



@interface ZWMeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIView *headView;

@property (nonatomic, strong) UIButton *login;
@property (nonatomic, strong)UIButton *registering;
@property (nonatomic, strong) UIButton *dlimageView;
@end

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
  
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(seting) image:@"me_set.png" highImage:@"me_set_click.png"title:nil];

    
}
-(void)seting{
    
    
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        alertView.title = @"请先登录账号";
    
        [alertView addButtonWithTitle:@"取消"];
        [alertView addButtonWithTitle:@"确定"];

        
        [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
            NSLog(@"1");
//        ZWRegisterViewController *registering = [[ZWRegisterViewController alloc] init];
//
        
        ZWLoginViewController *login = [[ZWLoginViewController alloc] init];
        
       [self.navigationController pushViewController:login animated:YES];
        
    

    }
}

//加载头部视图headView
- (UIView *)headView{

    if (_headView ==nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrrenH, 241)];
    }
    return _headView;
}

//创建数组的数据模型
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        // 1.创建模型
        MeDataModel *model1 = [[MeDataModel alloc] init];
        model1.title = @[@"全部订单"];
        model1.iconName = @[@"me_indent"];
        
        
        MeDataModel *model2= [[MeDataModel alloc] init];
        model2.title = @[@"我的现金券",@"我的收货地址",@"我的收藏"];
       model2.iconName =  @[@"me_coupon",@"me_site",@"me_collect"];
      
        MeDataModel *model3= [[MeDataModel alloc] init];
        model3.title = @[@"联系客服",@"我的邀请码"];
        model3.iconName =  @[@"me_contact",@"me_invite"];
   
        _dataArray= @[model1,model2,model3];
    }
    // 3.返回数组
    return _dataArray;
}

#pragma mark - UITableViewDataSource
/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
    
}
/**
 *  2.第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 1.取出对应的组模型
    MeDataModel *m = self.dataArray[section];
    // 2.返回对应组的行数
    return m.iconName.count;
}
/**
 *  3.告知系统每一行显示什么内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    static NSString *ID = @"zw";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 2.设置数据
    // 2.1取出对应组的模型
    MeDataModel *m = self.dataArray[indexPath.section];
    // 2.2取出对应行的数据
    // 2.3设置cell要显示的数据
    cell.textLabel.text = m.title[indexPath.row];
    //2.4 设置cell要显示的图片
    cell.imageView.image = [UIImage imageNamed:m.iconName[indexPath.row]];
    //2.5设置cell要显示的箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // 3.返回要显示的控件
    return cell;
    
}
#pragma mark - Table view delegate
//返回头部视图的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 241;
    }
    else{
        return 0.5;
    }
    
}
//添加头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    
    if (section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
        imageView.image = [UIImage imageNamed:@"me_bg.png"];
        imageView.userInteractionEnabled = YES;
        UIImage *bgImage = [UIImage imageNamed:@"me_select"];
       
        
        _login = [QuickCreateView addCustomButtonWithFrame:CGRectMake(80, 80, 80, 20) title:@"登录" image:nil bgImage:bgImage tag:101 target:self action:@selector(denglu)];
        [imageView addSubview:_login];
        
        
       _registering  = [QuickCreateView addCustomButtonWithFrame:CGRectMake(180, 80, 80, 20) title:@"注册" image:nil bgImage:bgImage tag:101 target:self action:@selector(zhuce)];
        [imageView addSubview:_registering];
        
        
        
        _dlimageView = [QuickCreateView addCustomButtonWithFrame:CGRectMake(120, 50, 100, 100) title:nil image:[UIImage imageNamed:@"default_picture"] bgImage:nil tag:150 target:self action:@selector(clickNickImage)];
        
        _dlimageView.hidden = YES;
        [imageView addSubview:_dlimageView];
         HWAccount *account = [HWAccountTool account];
        if (account) {
            [self hideloginAndRegeditButton];
        }

        [self.headView addSubview:imageView];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 180, scrrenW, 60)];
        view.backgroundColor = [UIColor whiteColor];
        [self.headView addSubview:view];
     
        
        
        UIImage *image1 = [UIImage imageNamed:@"me_payment@2x.png"];
        UIButton *paymentButton = [QuickCreateView addCustomButtonDeviateWithFrame:CGRectMake(padding, 0, (scrrenW-20)/5, 60) title:@"待付款" image:image1 bgImage:nil tag:101 target:self action:@selector(click:)];
         [view addSubview:paymentButton];
        UIImage *image2 = [UIImage imageNamed:@"me_send@2x.png"];
        UIButton *sendButton = [QuickCreateView addCustomButtonDeviateWithFrame:CGRectMake(padding+(scrrenW-20)/5, 0, (scrrenW-20)/5, 60) title:@"待发货" image:image2 bgImage:nil tag:102 target:self action:@selector(click:)];

         [view addSubview:sendButton];
        UIImage *image3 = [UIImage imageNamed:@"me_receive@2x.png"];
        UIButton *receiveButton = [QuickCreateView addCustomButtonDeviateWithFrame:CGRectMake(padding +2*(scrrenW-20)/5, 0, (scrrenW-20)/5, 60) title:@"待收货" image:image3 bgImage:nil tag:103 target:self action:@selector(click:)];
        [view addSubview:receiveButton];
        
        UIImage *image4 = [UIImage imageNamed:@"me_evaluate@2x.png"];
        UIButton *evaluateButton = [QuickCreateView addCustomButtonDeviateWithFrame:CGRectMake(padding+3*(scrrenW-20)/5, 0, (scrrenW-20)/5, 60) title:@"待评价" image:image4 bgImage:nil tag:104 target:self action:@selector(click:)];
        [view addSubview:evaluateButton];
        
        UIImage *image5 = [UIImage imageNamed:@"me_reimburse@2x.png"];
        UIButton *reimburseButton = [QuickCreateView addCustomButtonDeviateWithFrame:CGRectMake(padding+4*(scrrenW-20)/5, 0, (scrrenW-20)/5, 60) title:@"退款中" image:image5 bgImage:nil tag:105 target:self action:@selector(click:)];

        [view addSubview:reimburseButton];
        
    
        return self.headView;
  
    }
    else{
    
        return nil;
    }
}

- (void)clickNickImage{

    NSLog(@"clickNickImage");
}

- (void)denglu{


    ZWLoginViewController *login = [[ZWLoginViewController alloc] init];
    
    login.vc = self;
    
    [self.navigationController pushViewController:login animated:YES];
}

-(void)hideloginAndRegeditButton{
  
    self.login.hidden = YES;
    self.registering.hidden = YES;
    self.dlimageView.hidden = NO;
}

- (void)zhuce{
    ZWRegisterViewController *registering = [[ZWRegisterViewController alloc] init];
  
  
    
    [self.navigationController pushViewController:registering animated:YES];

}
- (void)click:(UIButton *)button{

    HWAccount *account = [HWAccountTool account];
    if (account) {
        NSLog(@"ok");
   
    }
    
  

}

//创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scrrenW ,scrrenH-108) style:UITableViewStyleGrouped];
    tableView.rowHeight = 48;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    
}

@end
