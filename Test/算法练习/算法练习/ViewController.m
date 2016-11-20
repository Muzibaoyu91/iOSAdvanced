//
//  ViewController.m
//  算法练习
//
//  Created by 李宝瑜 on 2016/11/20.
//  Copyright © 2016年 Baoy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithArray:@[
                                                       @"shuffle"
                                                       ]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
}

#pragma mark --------- tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *title = self.dataSource[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark --------- tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.dataSource[indexPath.row];
    NSString *viewControllerName = [title stringByAppendingString:@"ViewController"];
    Class class = NSClassFromString(viewControllerName);
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
