//
//  ViewController.m
//  Runtime遍历model属性
//
//  Created by Baoyu on 2016/11/15.
//  Copyright © 2016年 Baoy. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

/** DEBUG */
#ifdef DEBUG
#    define kDebugLog(...)   NSLog(__VA_ARGS__)
#    define kDebugMethod(...)   NSLog(@"%s", __func__) // 打印当前所在function
#else
#    define kDebugLog(...)
#    define kDebugMethod(...)
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *Xiaoming = [[Student alloc] init];
    Xiaoming.name = @"小明";
    Xiaoming.age = 18;
    Xiaoming.gender = LBYGenderMan;
    kDebugLog(@"%@",Xiaoming);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
