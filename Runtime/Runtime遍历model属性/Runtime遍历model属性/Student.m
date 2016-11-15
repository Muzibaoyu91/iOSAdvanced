//
//  Student.m
//  Runtime遍历model属性
//
//  Created by Baoyu on 2016/11/15.
//  Copyright © 2016年 Baoy. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student

- (NSString *)description
{
    //存储所有属性的名称
    NSMutableDictionary *allProperties = [NSMutableDictionary dictionary];
    
    //储存属性的个数
    unsigned int propertyCount = 0;
    
    //通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i<propertyCount; i++) {
        objc_property_t property = propertys[i];
        NSString *propertyName = @(property_getName(property));
        id value = [self valueForKey:propertyName];
        [allProperties setObject:value forKey:propertyName];
    }
    
    free(propertys);
    
    return [NSString stringWithFormat:@"<%@:%p>--%@",[self class],self,allProperties];
}

@end
