//
//  shuffleViewController.m
//  算法练习
//
//  Created by 李宝瑜 on 2016/11/20.
//  Copyright © 2016年 Baoy. All rights reserved.
//

#import "shuffleViewController.h"

@interface shuffleViewController ()

@end

@implementation shuffleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *array = @[
                       @"0_路飞",
                       @"1_佐罗",
                       @"2_Sanji",
                       @"3_娜美",
                       @"4_乔巴",
                       @"5_乌索普",
                       @"6_弗兰奇",
                       @"7_罗宾",
                       @"8_布鲁克"
                       ];
    
    NSArray *resultArray = [self RandomlySelected:9 InArray:array];
    for (NSString *string in resultArray) {
        NSLog(@"%@",string);
    }
}


- (NSArray *)RandomlySelected:(NSUInteger )selectedNum InArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSUInteger arrayCount = mutableArray.count;
    
    for (int i = 0; i<selectedNum; i++) {
        int random = arc4random()%arrayCount;
        NSString *chooseString = mutableArray[random];
        [resultArray addObject:chooseString];
        [mutableArray exchangeObjectAtIndex:random withObjectAtIndex:arrayCount -1];
        arrayCount --;
    }
    
    return resultArray;
}



@end
