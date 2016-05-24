//
//  ZWBuyViewController.m
//  设计典范
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "ZWBuyViewController.h"
#import "Tool.h"
#import "QuickCreateView.h"
#import "DetaiModel.h"
#import "Item.h"
#import "UIImageView+WebCache.h"

@interface ZWBuyViewController ()
//头部图片
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *selectedLabel;
@property (nonatomic,strong) UIButton *colorButton;
@property (nonatomic,strong) UIButton *materialButton;
@property (nonatomic,strong) UIButton *standardButton;


@property (nonatomic,strong) UILabel *goodsCount;
@property (nonatomic,strong) UILabel *allPrice;

@property (nonatomic,strong)  UITextField *count;
@end

@implementation ZWBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.model.goodsId);
    [self createHeadView];
    
    [self createColorAndMaterialAndStandard];
    [self createBottomView];

}
#pragma mark - 头部标题和图片视图
- (void)createHeadView{

    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding,scrrenW*0.3 ,scrrenW*0.3)];
    _headImageView.backgroundColor=ZWRandomColor;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picUrl] placeholderImage:nil];
    
    [self.view addSubview:_headImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+padding, padding, scrrenW -3*padding-scrrenW*0.3, 50)];
    _titleLabel.text = self.model.goodsName;
    NSLog( @"%@",self.model.goodsTitle);
    _titleLabel.font = ZWFont;
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
//    _titleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_titleLabel];
    
    _selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+padding, padding*2 +50, scrrenW -3*padding-scrrenW*0.3, 50)];
    _selectedLabel.font = ZWFont;
    _selectedLabel.numberOfLines = 0;
    _selectedLabel.textAlignment = NSTextAlignmentLeft;
   // _selectedLabel.backgroundColor = ZWRandomColor;
    [self.view addSubview:_selectedLabel];


}

#pragma mark - 颜色材质规格
- (void)createColorAndMaterialAndStandard{

    //颜色
    UILabel *color = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.headImageView.frame)+padding, 80, 20)];
    color.text = [self.model.ppViews[0] name];
    color.font = ZWFont;
    color.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:color];
    
   
   
    
    Item *m = [self.model.ppViews[0] items][0];
    
    _colorButton = [QuickCreateView addCustomButtonWithFrame:CGRectMake(padding, CGRectGetMaxY(color.frame), (scrrenW-4*padding)/3, 30) title:m.val image:nil bgImage:[UIImage imageNamed:@"product_bg2"] tag:100 target:self action:@selector(click:)];
    _colorButton.titleLabel.font = ZWFont;
   // _colorButton setTitleColor:<#(nullable UIColor *)#> forState:<#(UIControlState)#>
    
   // _colorButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_colorButton];
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.colorButton.frame)+padding, scrrenW-2*padding,1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
   
    
    if (self.model.ppViews.count>1) {
    //材质
    UILabel *material = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.colorButton.frame)+padding*2, 80, 20)];
    material.text = [self.model.ppViews[1] name];
    material.font = ZWFont;
    material.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:material];
    Item *m2 = [self.model.ppViews[1] items][0];
    _materialButton = [QuickCreateView addCustomButtonWithFrame:CGRectMake(padding, CGRectGetMaxY(material.frame), (scrrenW-4*padding)/3, 30) title:m2.val image:nil bgImage:[UIImage imageNamed:@"product_bg2"] tag:101 target:self action:@selector(click:)];
    _materialButton.titleLabel.font = ZWFont;
   // _materialButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_materialButton];
   
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.materialButton.frame)+padding, scrrenW-2*padding,1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    }
     if (self.model.ppViews.count>2) {
    
    //规格
    UILabel *strand = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.materialButton.frame)+padding*2, 80, 20)];

    strand.text = [self.model.ppViews[2] name];
    strand.font = ZWFont;
    strand.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:strand];
    Item *m3 = [self.model.ppViews[2] items][0];
    _standardButton = [QuickCreateView addCustomButtonWithFrame:CGRectMake(padding, CGRectGetMaxY(strand.frame), (scrrenW-4*padding)/3, 30) title:m3.val image:nil bgImage:[UIImage imageNamed:@"product_bg2"] tag:102 target:self action:@selector(click:)];
    _standardButton.titleLabel.font = ZWFont;
   // _standardButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_standardButton];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.standardButton.frame)+padding, scrrenW-2*padding,1)];
    line3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line3];
     }
}

- (void)click:(UIButton *)button{
    if (button.tag ==100) {
            NSLog(@"颜色");
        
        self.selectedLabel.text =button.currentTitle;
    }

}

#pragma mark - 购买数量和确定取消

-(void)createBottomView{
    
     CGFloat Y =CGRectGetMaxY(self.standardButton.frame)+padding*2;

    if (self.model.ppViews.count<3) {
     Y=400;
        
    }
   
    UILabel *buycount = [[UILabel alloc] initWithFrame:CGRectMake(padding,Y , 80, 30)];
    
    buycount.text = @"购买数量";
  //  buycount.backgroundColor = [UIColor redColor];
    buycount.font = [UIFont systemFontOfSize:15];
    buycount.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:buycount];

    UIButton *reduce = [QuickCreateView addCustomButtonWithFrame:CGRectMake(scrrenW -15*padding, Y, 30, 30) title:nil image:[UIImage imageNamed:@"product_reduce_click"] bgImage:nil tag:110 target:self action:@selector(clickButton:)];
    
    [self.view addSubview:reduce];
    
    _count = [[UITextField alloc ] initWithFrame:CGRectMake(CGRectGetMaxX(reduce.frame), Y, 30, 30)];
   // text.backgroundColor = [UIColor redColor];
    _count.placeholder = @"1";
    _count.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_count];
    

    
    UIButton *add = [QuickCreateView addCustomButtonWithFrame:CGRectMake(scrrenW -6*padding, Y, 30, 30) title:nil image:[UIImage imageNamed:@"product_add_click"] bgImage:nil tag:111 target:self action:@selector(clickButton:)];
    
    [self.view addSubview:add];

    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.count.frame)+padding/2, scrrenW-2*padding,1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    

    _goodsCount = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(line1.frame)+padding, 150, 30)];
    
    _goodsCount.text = @"共计买1件数量";
   // buycount.backgroundColor = [UIColor redColor];
    _goodsCount.font = [UIFont systemFontOfSize:15];
    _goodsCount.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:_goodsCount];

    
    _allPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsCount.frame), CGRectGetMaxY(line1.frame)+padding, 150, 30)];
    
    _allPrice.text = @"30000.00";
    // buycount.backgroundColor = [UIColor redColor];
    _allPrice.font = [UIFont systemFontOfSize:15];
    _allPrice.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:_allPrice];

    
   // [NSJSONSerialization dataWithJSONObject:<#(nonnull id)#> options:<#(NSJSONWritingOptions)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]

    UIButton *certainty = [QuickCreateView addCustomButtonWithFrame:CGRectMake(100,CGRectGetMaxY(self.allPrice.frame), 60, 30) title:@"取消"image:nil bgImage:[UIImage imageNamed:@"shopping_btn_bg"] tag:121 target:self action:@selector(clickBut:)];

    certainty.titleLabel.font = ZWFont;
    [self.view addSubview:certainty];
    
    
    
    UIButton *cancel = [QuickCreateView addCustomButtonWithFrame:CGRectMake(200,CGRectGetMaxY(self.allPrice.frame), 60, 30) title:@"确定" image: nil bgImage:[UIImage imageNamed:@"shopping_btn_bg"] tag:122 target:self action:@selector(clickBut:)];
    cancel.titleLabel.font =ZWFont;
    [self.view addSubview:cancel];

    
}


- (void)clickButton:(UIButton *)button{


    NSLog(@"123");


}

- (void)clickBut:(UIButton *)button{

       [self.navigationController popViewControllerAnimated:YES];
    
    if (button.tag ==122) {
        NSLog(@"122");
    }

    
    
    if (button.tag ==121) {
        NSLog(@"121");
    }

    
}


@end
