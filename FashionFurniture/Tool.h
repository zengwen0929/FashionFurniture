//
//  Tool.h
//  zengwenaixianmian
//
//  Created by qianfeng on 15/12/8.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

// RGB颜色
#define ZWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define ZWRandomColor ZWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define scrrenW [UIScreen mainScreen].bounds.size.width
#define scrrenH [UIScreen mainScreen].bounds.size.height

#define padding 10

#define ZWFont [UIFont systemFontOfSize:14]

#define Kpage @"page"

#define goodsURL @"http://116.204.13.36:7777/api/goods/getTypeGoods"
/**
   分类连接
 */
#define classifyURL @"http://116.204.13.36:7777/api/goods/getTypeList"
#define mianfei @"http://1000phone.net:8088/app/iAppFree/api/free.php?page=1&number=20"
#define rebang @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=1&number=20"
#define zhuanti @"http://iappfree.candou.com:8080/free/special?page=1&limit=5"





@interface Tool : NSObject



@end
