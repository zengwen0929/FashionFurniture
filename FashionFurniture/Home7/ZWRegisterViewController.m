//
//  ZWRegisterViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "ZWRegisterViewController.h"
#import "AFNetworking.h"

@interface ZWRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;



@end

@implementation ZWRegisterViewController

- (IBAction)getCode:(id)sender {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *url = @"http://116.204.13.36:7777/api/user/getValidateCode";
    NSDictionary *parameter= @{@"type":@"1",@"mobile":self.telephoneNumber.text};
    [mgr GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];

        NSLog(@"请求失败-%@", error);
    }];
    


}

- (IBAction)registerUser:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *reg = @"http://116.204.13.36:7777/api/user/register";
    
    NSDictionary *paramters = @{@"code":self.code.text,
                                @"mobile":self.telephoneNumber.text,
                                
                                @"nickName":self.nickName.text,
                                @"password":self.passWord.text};
    NSLog(@"%@",paramters);
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:reg parameters:paramters success:^(AFHTTPRequestOperation *operation, NSData * responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"code"]);
        NSString *code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        
        
        if ([code isEqualToString:@"0"])
        {
            NSLog(@"12343");
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }
        
        
        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   self.title =@"注册";
    self.navigationItem.rightBarButtonItem = nil;
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
