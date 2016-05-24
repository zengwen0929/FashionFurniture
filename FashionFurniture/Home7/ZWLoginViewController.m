//
//  ZWLoginViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "ZWLoginViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Tool.h"
#import "QuickCreateView.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "MJExtension.h"
#import "ZWLoginViewController.h"

@interface ZWLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (nonatomic,strong) NSDictionary *dict;


@end

@implementation ZWLoginViewController
- (IBAction)login {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *login = @"http://116.204.13.36:7777/api/user/login";
    
    NSDictionary *parameter = @{@"mobile":self.telephoneNumber.text,
                                @"password":self.passWord.text};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //上传字符串
    [manager POST:login parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //  NSLog(@"%@", dict[@"msg"]);
        //   NSLog(@"%@", dict[@"code"]);
        
        

        
        NSString *code = [NSString stringWithFormat:@"%@",dict[@"code"]];
 
        
        if ([code isEqualToString:@"0"])
        {
        
            
            HWAccount *account = [HWAccount objectWithKeyValues:dict[@"data"]];
            NSLog(@"%@",dict[@"data"]);
            // 存储账号信息
            [HWAccountTool saveAccount:account];
            
            [self.vc hideloginAndRegeditButton];
            
            [self.navigationController popToRootViewControllerAnimated:nil];
            
            
        }

        
        if ([code isEqualToString:@"40002"])
        {
            NSLog(@"登录失败");

        }

        if ([code isEqualToString:@"40019"])
        {
            NSLog(@"用户不存在");
            
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

   
}

- (void)viewDidLoad {
    [super viewDidLoad];

//UIImage *image = [UIImage imageNamed:@"shopping_btn_bg.png"];
//UIButton *button = [QuickCreateView addCustomButtonWithFrame:CGRectMake(0, 0, 80, 30) title:@"去挑选" image:nil bgImage:image tag:100 target:self action:@selector(click)];
//button.center = CGPointMake(scrrenW/2, scrrenH/2);
//button.titleLabel.font = [UIFont systemFontOfSize:12];
//
//[self.view addSubview:button];

}

- (void)click{
//    NSLog(@"12323");
//    NSString *code = [NSString stringWithFormat:@"%@",self.dict[@"code"]];
//
//    if ([code isEqualToString:@"0"])
//    {
//     
//        self.tabBarController.selectedIndex = 4;
//        
//        NSLog(@"12343");
//    }
    
    
   // self.tabBarController.selectedIndex = 2;
    
}


@end
