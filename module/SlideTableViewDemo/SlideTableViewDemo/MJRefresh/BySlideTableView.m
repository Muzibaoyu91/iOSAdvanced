//
//  BySlideTableView.m
//  SlideTableViewDemo
//
//  Created by Baoyu on 16/6/27.
//  Copyright © 2016年 Instask.Me. All rights reserved.
//

#import "BySlideTableView.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

#define titleBtnTag  1000

#define tableTag 2000

#define scrollTag 3000

@interface BySlideTableView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

//  color

@property (nonatomic, strong) UIColor *btnBackDefaultColor;

@property (nonatomic, strong) UIColor *btnSelectColor;

@property (nonatomic, strong) UIColor *btnTitleDefaultColor;

@property (nonatomic, strong) UIColor *btnTitleSeclectColor;


//  Array

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) NSMutableArray *tableArray;

@property (nonatomic, strong) NSMutableArray *AllDataSource;



//  data
@property (nonatomic, strong) NSMutableArray *urlArray;


//  UI
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIScrollView *topScrollView;


//  lenght
@property (nonatomic, assign) CGFloat topBtnLenght;

@property (nonatomic, assign) NSInteger topNum;

@property (nonatomic, assign) NSInteger current_Num;



@end

@implementation BySlideTableView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withTopNumber:(NSInteger)topNum withTitleHeight:(CGFloat)titleHeight withURLArray:(NSArray *)URLArray withDelegate:(id<BySlideTableViewDelegate>)delegate{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.topNum = topNum;
        
        
        _btnBackDefaultColor = [UIColor whiteColor];
        _btnSelectColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        _btnTitleDefaultColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        _btnTitleSeclectColor = [UIColor whiteColor];
        
        _btnArray = [NSMutableArray array];
        _tableArray = [NSMutableArray array];
        
        _urlArray = [NSMutableArray arrayWithArray:URLArray];
        _AllDataSource = [NSMutableArray array];
        
        
        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        
        
        
        //  TopUI
        self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, titleHeight)];
        self.topScrollView.userInteractionEnabled = YES;
        [self.topScrollView setShowsVerticalScrollIndicator:NO];
        [self.topScrollView setShowsHorizontalScrollIndicator:NO];
        self.topScrollView.bounces = NO;
        self.topScrollView.tag = scrollTag + 0;
        self.topScrollView.delegate = self;
        
        [self addSubview:self.topScrollView];
        
        
        //  buttons
        CGFloat BtnWidth = frame.size.width/topNum;
        self.topBtnLenght = BtnWidth;
        
        for (int i = 0; i<titleArray.count; i++) {
            UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(i*BtnWidth, 0, BtnWidth, titleHeight)];
            NSString *title = titleArray[i];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = titleBtnTag + i;
            [button addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
            //  color
            button.backgroundColor = _btnBackDefaultColor;
            [button setTitleColor:_btnTitleDefaultColor forState:UIControlStateNormal];
            if (i==0) {
                button.backgroundColor = _btnSelectColor;
                [button setTitleColor:_btnTitleSeclectColor forState:UIControlStateNormal];
            }
            
            [_btnArray addObject:button];
            [self.topScrollView addSubview:button];
            
            self.topScrollView.contentSize = CGSizeMake((i+1)*BtnWidth, titleHeight);
        }
        
        
        
        //  content
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, frame.size.width, frame.size.height-titleHeight)];
        self.contentScrollView.userInteractionEnabled = YES;
        [self.contentScrollView setShowsVerticalScrollIndicator:NO];
        [self.contentScrollView setShowsHorizontalScrollIndicator:NO];
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.bounces = NO;
        self.contentScrollView.tag = scrollTag + 1;
        self.contentScrollView.delegate = self;
        
        
        
        for (int i = 0; i< titleArray.count; i++) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height-titleHeight)];
            tableView.tag = tableTag + i;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

            
            [self.contentScrollView addSubview:tableView];
            [self.tableArray addObject:tableView];
            self.contentScrollView.contentSize = CGSizeMake((i+1)*frame.size.width, 0);
        }
        
        [self addSubview:self.contentScrollView];
        
        
        //  data
        [self requestData];
    
    }
    return self;
}

#pragma mark - function
- (void)titleBtnAction:(UIButton *)btn{
    NSInteger num = btn.tag - titleBtnTag;
    
    //  改变坐标
    self.current_Num = num;
    
    //  改变颜色
    [self btnChangeColor:num];
    
    
    //  调整下方content位置
    [self contentChangeX:num];
    
    
    //  调整上方的位置
    [self changeTopX:num];
    
}
  
- (void)loadNewData{
    
    [self loadDataWithNumber:self.current_Num];
}
                                                                                                         



//  调整上方的位置
- (void)changeTopX:(NSInteger)num{
    
    if (num == 0) {
        //  点击了top第一个
        [UIView animateWithDuration:0.3 animations:^{
            self.topScrollView.contentOffset = CGPointMake(0, 0);
        }];
        return;
    }
    
    if (num == self.btnArray.count -1) {
        //  点击了top的最后一个
        [UIView animateWithDuration:0.3 animations:^{
            self.topScrollView.contentOffset = CGPointMake(self.topScrollView.contentSize.width - self.topScrollView.frame.size.width, 0);
        }];
        return;
    }
    
    
    //  剩下的点击的btn在左边不足一个单位
    CGFloat nowX = self.topScrollView.contentOffset.x;
    
    if ( (nowX >= num * self.topBtnLenght)&&(nowX <= (num +1) * self.topBtnLenght) ) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.topScrollView.contentOffset = CGPointMake((num -1)*self.topBtnLenght, 0);
        }];
        
        return;
    }
    
    //  点击的btn在右边不足一个单位
    if ((nowX + self.topScrollView.frame.size.width >= (num)* self.topBtnLenght)&&(nowX +self.topScrollView.frame.size.width <= (num + 1)*self.topBtnLenght)) {
        [UIView animateWithDuration:0.2 animations:^{
            self.topScrollView.contentOffset = CGPointMake((num + 2)*self.topBtnLenght - self.topScrollView.frame.size.width, 0) ;
        }];
        return;
    }
    
    
    //  下方滑动引起的超出了边界
    if (nowX > (num +1)*self.topBtnLenght) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.topScrollView.contentOffset = CGPointMake((num -1)*self.topBtnLenght, 0);
        }];
    }

    if (nowX + self.topScrollView.frame.size.width< (num +1)*self.topBtnLenght) {
        [UIView animateWithDuration:0.3 animations:^{
            self.topScrollView.contentOffset = CGPointMake((num + 2)*self.topBtnLenght - self.topScrollView.frame.size.width, 0) ;
        }];
    }
}


//  调整下方content的位置
- (void)contentChangeX:(NSInteger)num{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(num *self.contentScrollView.frame.size.width, 0);
    }];
}


//  btn效果
- (void)btnChangeColor:(NSInteger)btnNum{
    //  恢复所有btn的颜色
    for (UIButton *btn in self.btnArray) {
        btn.backgroundColor = _btnBackDefaultColor;
        [btn setTitleColor:_btnTitleDefaultColor forState:UIControlStateNormal];
    }
    
    //  点击的btn改变颜色
    UIButton *btn = self.btnArray[btnNum];
    btn.backgroundColor = _btnSelectColor;
    [btn setTitleColor:_btnTitleSeclectColor forState:UIControlStateNormal];
}


- (void)requestData{
    
    //  初始化数组
    for (int i = 0; i<_urlArray.count; i++) {
        NSMutableArray *oneArray = [NSMutableArray array];
        [self.AllDataSource addObject:oneArray];
    }
    
    //  请求数据装进AllDataSource
    for (int i = 0; i<_urlArray.count; i++) {
        [self loadDataWithNumber:i];
    }
}


- (void)loadDataWithNumber:(NSInteger)num{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:_urlArray[num] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *sub = [dic objectForKey:@"subjects"];
        
        NSMutableArray *oneArray = self.AllDataSource[num];
        [oneArray addObjectsFromArray:sub];
        UITableView *tableView = self.tableArray[num];
        
        [tableView reloadData];
        
        [tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---%zd----%@",num,error);
    }];
}


#pragma mark - tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.AllDataSource.count > (tableView.tag - tableTag)) {
        NSArray *arr = self.AllDataSource[tableView.tag - tableTag];
        return arr.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.AllDataSource[tableView.tag - tableTag][indexPath.row][@"title"];
    
    return cell;
}


#pragma mark - scrollerDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!(scrollView.tag - scrollTag)) {
        // top
    }else if((scrollView.tag - scrollTag) == 1){
        //  content
        CGPoint nowPoint = scrollView.contentOffset;
        CGFloat nowX = nowPoint.x;
        NSInteger nowNum = nowX/scrollView.frame.size.width;
        
        self.current_Num = nowNum;
        
        [self btnChangeColor:nowNum];
        
        [self changeTopX:nowNum];
        
    }
    
    
    
    
    
    
}




@end
