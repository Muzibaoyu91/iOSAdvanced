//
//  Student.h
//  Runtime遍历model属性
//
//  Created by Baoyu on 2016/11/15.
//  Copyright © 2016年 Baoy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LBYGender) {
    LBYGenderMan,
    LBYGenderFemale
};

@interface Student : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign)  NSUInteger age;

@property (nonatomic, assign) LBYGender gender;

@end
