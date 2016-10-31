//
//  ViewController.m
//  LocalNotification
//
//  Created by long on 16/3/4.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ViewController.h"

#define kLocalNotificationKey @"kLocalNotificationKey"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnSendLocalNotification_Click:(id)sender
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //触发通知时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //重复间隔
//    localNotification.repeatInterval = kCFCalendarUnitMinute;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    //通知内容
    localNotification.alertBody = @"i am a test local notification";
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //通知参数
    localNotification.userInfo = @{kLocalNotificationKey: @"觉醒吧，少年"};
    
    localNotification.category = kNotificationCategoryIdentifile;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (IBAction)btnCancelSend_Click:(id)sender
{
    for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
        if ([obj.userInfo.allKeys containsObject:kLocalNotificationKey]) {
            [[UIApplication sharedApplication] cancelLocalNotification:obj];
        }
    }
    //直接取消全部本地通知
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
