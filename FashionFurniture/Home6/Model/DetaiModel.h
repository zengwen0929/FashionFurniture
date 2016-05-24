//
//  DetaiModel.h
//  设计典范
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetaiModel : NSObject
@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,strong) NSArray *productList;

@property (nonatomic,copy) NSString *goodsOldPrice;
@property (nonatomic,strong) NSArray *ppViews;
@property (nonatomic,copy) NSString *goodsBuyCount;
@property (nonatomic,copy) NSString *deliverFeeNoneLeast;

@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *isCollection;
@property (nonatomic,copy) NSString *saleType1;
@property (nonatomic,copy) NSString *goodsTitle;
@property (nonatomic,copy) NSString *goodsPrice;

@property (nonatomic,copy) NSString *goodsName;

@end
