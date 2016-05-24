
//
//  DetaiModel.m
//  设计典范
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import "DetaiModel.h"

#import "PpView.h"
#import "ProductList.h"

@implementation DetaiModel
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id", @"desc" : @"description",@"color":@"3",@"material":@"2",@"strand":@"7"};
}

- (NSDictionary *)objectClassInArray{

    return @{@"productList":[ProductList class],@"ppViews":[PpView class]};

}

@end
