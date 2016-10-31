//
//  BySlideTableView.h
//  SlideTableViewDemo
//
//  Created by Baoyu on 16/6/27.
//  Copyright © 2016年 Instask.Me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BySlideTableViewDelegate <NSObject>



@end


@interface BySlideTableView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withTopNumber:(NSInteger)topNum withTitleHeight:(CGFloat)titleHeight withURLArray:(NSArray *)URLArray withDelegate:(id<BySlideTableViewDelegate>)delegate;


@property (nonatomic, weak) id <BySlideTableViewDelegate> delegate;


@end
