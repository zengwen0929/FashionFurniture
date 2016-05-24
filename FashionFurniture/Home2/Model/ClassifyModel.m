
//
//  ClassifyModel.m
//  设计典范
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ClassifyModel.h"
#import "MJExtension.h"
#import "LevelData.h"

@implementation ClassifyModel

-(NSDictionary *)objectClassInArray{

    return @{@"levelData":[LevelData class]};

}

@end
