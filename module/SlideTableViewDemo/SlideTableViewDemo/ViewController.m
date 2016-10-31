//
//  ViewController.m
//  SlideTableViewDemo
//
//  Created by Baoyu on 16/6/27.
//  Copyright © 2016年 Instask.Me. All rights reserved.
//

#import "ViewController.h"
#import "BySlideTableView.h"


#define DOUBAN_BASE_PATH @"http://api.douban.com"

/** ***********2榜单****************** */
/** 2.1正在上映 */
#define THEATERS_PATH @"http://api.douban.com/v2/movie/in_theaters"

/** 2.2即将上映 */
#define COMING_SOON_PATH @"http://api.douban.com/v2/movie/coming_soon"

/** 2.3TOP250 */
#define TOP250_PATH @"http://api.douban.com/v2/movie/top250"

@interface ViewController ()<BySlideTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.502 alpha:1.000];
    
    NSArray *title = @[ @"ShowOn",@"ComingSoon",@"Top250",@"ShowOn",@"ComingSoon",@"Top250",@"ShowOn",@"ComingSoon",@"Top250",@"ShowOn",@"ComingSoon",@"Top250" ];
    NSArray *URLArray = @[ THEATERS_PATH,COMING_SOON_PATH,TOP250_PATH,THEATERS_PATH,COMING_SOON_PATH,TOP250_PATH,THEATERS_PATH,COMING_SOON_PATH,TOP250_PATH,THEATERS_PATH,COMING_SOON_PATH,TOP250_PATH ];
    
    
    BySlideTableView *bySlideTableView = [[BySlideTableView alloc] initWithFrame:CGRectMake(10, 60, 350, 600) withTitleArray:title withTopNumber:5 withTitleHeight:49 withURLArray:URLArray withDelegate:self];
    
    [self.view addSubview:bySlideTableView];
    
}



@end
