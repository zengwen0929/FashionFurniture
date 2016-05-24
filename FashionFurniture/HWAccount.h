//
//  HWAccount.h
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *uid;


@property (nonatomic, copy) NSString *cartAmount;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic,copy) NSString *nickname;

@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *headUrl;
@property (nonatomic,copy) NSString *jifen;
@property (nonatomic,copy) NSString *mobile;
@end
