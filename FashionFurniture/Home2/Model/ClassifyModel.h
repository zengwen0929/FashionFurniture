//
//  ClassifyModel.h
//  设计典范
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject
@property (nonatomic,copy) NSString *levelName;
@property (nonatomic,strong) NSArray *levelData;
@end
