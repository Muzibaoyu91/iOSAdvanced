//
//  ViewController.m
//  ExampleObjective-C
//
//  Created by  东海 on 15/9/2.
//  Copyright (c) 2015年 ouy.Aberi. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "HyTransitions.h"
#import "HyLoglnButton.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *Switch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPresentControllerButton];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

-(void)createPresentControllerButton{

    HyLoglnButton *log = [[HyLoglnButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + 80), [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [log setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [self.view addSubview:log];
    [log setTitle:@"登录" forState:UIControlStateNormal];
    [log addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
 
}

-(void)PresentViewController:(HyLoglnButton *)button{
    
    typeof(self) __weak weak = self;
    //模拟网络访问
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weak LoginButton:button];
    });
}

-(void)LoginButton:(HyLoglnButton *)button
{
    typeof(self) __weak weak = self;
    if (_Switch.on) {
        //网络正常 或者是密码账号正确跳转动画
        [button ExitAnimationCompletion:^{
            if (weak.Switch.on) {
                [weak didPresentControllerButtonTouch];
            }
        }];
    }else{
        //网络错误 或者是密码不正确还原动画
        [button ErrorRevertAnimationCompletion:^{
            if (weak.Switch.on) {
                [weak didPresentControllerButtonTouch];
            }
        }];
    }
}

- (void)didPresentControllerButtonTouch
{
    
    UIViewController *controller = [SecondViewController new];
    
    controller.transitioningDelegate = self;
    
    UINavigationController *nai = [[UINavigationController alloc] initWithRootViewController:controller];
    nai.transitioningDelegate = self;
    
    [self presentViewController:nai animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
