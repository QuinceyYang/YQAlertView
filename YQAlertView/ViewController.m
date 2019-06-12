//
//  ViewController.m
//  YQAlertView
//
//  Created by 杨清 on 2019/6/11.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "ViewController.h"
#import <YQButton/YQButton.h>
#import "YQAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak __typeof(self)weakSelf = self;
    YQButton *btn = [[YQButton alloc] initWithFrame:CGRectMake(0, 66, 250, 100)];
    btn.backgroundColor = UIColor.greenColor;
    [btn setTitle:@"YQAlertView show" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.tapAction = ^(YQButton *sender) {
        YQAlertView *view = [YQAlertView alertViewWithTitle:@"温馨提示" message:@"YQAlertView 是一个很好用的控件哦😯" actionArray:nil completion:^(NSInteger actionIndex) {
            //
        }];
        [weakSelf.view.window addSubview:view];
    };
    //
    YQButton *btn2 = [[YQButton alloc] initWithFrame:CGRectMake(0, 175, 250, 100)];
    btn2.backgroundColor = UIColor.greenColor;
    [btn2 setTitle:@"YQAlertView show 2" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn2];
    btn2.tapAction = ^(YQButton *sender) {
        NSArray *acionArr = @[@"确定"];
        YQAlertView *view = [YQAlertView alertViewWithTitle:@"温馨提示" message:@"YQAlertView 是一个很好用的控件哦😯" actionArray:acionArr completion:^(NSInteger actionIndex) {
            //
        }];
        [view showOnView:weakSelf.view];
    };
    //
    YQButton *btn3 = [[YQButton alloc] initWithFrame:CGRectMake(0, 285, 250, 100)];
    btn3.backgroundColor = UIColor.greenColor;
    [btn3 setTitle:@"YQAlertView show 3" forState:UIControlStateNormal];
    //btn.center = self.view.center;
    [self.view addSubview:btn3];
    btn3.tapAction = ^(YQButton *sender) {
        NSArray *acionArr = @[@"取消",@"确定"];
        YQAlertView *view = [YQAlertView alertViewWithTitle:@"温馨提示" message:@"YQAlertView 是一个很好用的控件哦😯" actionArray:acionArr completion:^(NSInteger actionIndex) {
            //
        }];
        [view.actionButtonArr.lastObject setTitleColor:[UIColor colorWithRed:0xff/255.0 green:0xa7/255.0 blue:0x26/255.0 alpha:1.0] forState:UIControlStateNormal];
        [view showOnView:weakSelf.view.window];
    };

}


@end
