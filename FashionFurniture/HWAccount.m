//
//  HWAccount.m
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.cartAmount forKey:@"cartAmount"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.headUrl forKey:@"headUrl"];
    [encoder encodeObject:self.jifen forKey:@"jifen"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
}



/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.cartAmount = [decoder decodeObjectForKey:@"cartAmount"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.headUrl = [decoder decodeObjectForKey:@"headUrl"];
        self.jifen = [decoder decodeObjectForKey:@"jifen"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];

    
    
    }
    return self;
}
@end
