//
//  YQAlertView.m
//  YQAlertView
//
//  Created by 杨清 on 2019/6/11.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "YQAlertView.h"

@implementation YQAlertView


+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message actionArray:(NSArray * _Nullable)actionArr completion:(void (^)(NSInteger actionIndex))completion {
    
    YQAlertView *alertView = [[YQAlertView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    alertView.isAutoCloseWhenTapAction = YES;
    //
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width-80, alertView.frame.size.height-160)];
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.backgroundColor = UIColor.whiteColor;
    [alertView addSubview:view];
    //
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 21, view.frame.size.width-40, 22)];
    titleLab.text = title;
    titleLab.textColor = [UIColor colorWithRed:0x22/255.0 green:0x22/255.0 blue:0x22/255.0 alpha:1.0];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
    alertView.titleLab = titleLab;
    //
    YQButton *closeBtn = [[YQButton alloc] initWithFrame:CGRectMake(view.frame.size.width-40, 0, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [view addSubview:closeBtn];
    closeBtn.tapAction = ^(YQButton *sender) {
        [UIView beginAnimations:nil context:nil];
        [sender.superview.superview removeFromSuperview];
        [UIView commitAnimations];
    };
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, view.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xe0/255.0 green:0xe0/255.0 blue:0xe0/255.0 alpha:1.0];
    [view addSubview:line];
    //
    UIView *bodyView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame), view.frame.size.width-20, 120)];
    //bodyView.backgroundColor = UIColor.whiteColor;
    [view addSubview:bodyView];
    //
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, bodyView.frame.size.width, 10000)];
    messageLab.numberOfLines = 0;
    messageLab.text = message ?: @" ";
    messageLab.textColor = [UIColor colorWithRed:0x55/255.0 green:0x55/255.0 blue:0x55/255.0 alpha:1.0];
    messageLab.font = [UIFont systemFontOfSize:16];
    [messageLab sizeToFit];
    [bodyView addSubview:messageLab];
    alertView.messageLab = messageLab;
    //
    bodyView.frame = CGRectMake(bodyView.frame.origin.x, bodyView.frame.origin.y, bodyView.frame.size.width, CGRectGetMaxY(messageLab.frame)+10);
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, CGRectGetMaxY(bodyView.frame));
    //
    if (actionArr==nil || actionArr.count<=0) {
        view.center = CGPointMake(alertView.frame.size.width/2, alertView.frame.size.height/2);
        return alertView;
    }
    //
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bodyView.frame)-0.5, view.frame.size.width, 0.5)];
    line2.backgroundColor = [UIColor colorWithRed:0xe0/255.0 green:0xe0/255.0 blue:0xe0/255.0 alpha:1.0];
    [view addSubview:line2];
    //
    alertView.actionButtonArr = [NSMutableArray new];
    CGFloat btnWidth = view.frame.size.width/actionArr.count;
    for (NSInteger i=0; i<actionArr.count; i++) {
        YQButton *btn = [[YQButton alloc] initWithFrame:CGRectMake(i*btnWidth, CGRectGetMaxY(bodyView.frame), btnWidth, 50)];
        btn.tag = i;
        [btn setTitle:actionArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0x22/255.0 green:0x22/255.0 blue:0x22/255.0 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [view addSubview:btn];
        [alertView.actionButtonArr addObject:btn];
        if (i<actionArr.count-1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)-0.5, btn.frame.origin.y, 0.5, btn.frame.size.height)];
            line.backgroundColor = [UIColor colorWithRed:0xe0/255.0 green:0xe0/255.0 blue:0xe0/255.0 alpha:1.0];
            [view addSubview:line];
        }
        //
        btn.tapAction = ^(YQButton *sender) {
            if (completion) {
                completion(sender.tag);
            }
            if (alertView.isAutoCloseWhenTapAction == YES) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView beginAnimations:nil context:nil];
                    [alertView removeFromSuperview];
                    [UIView commitAnimations];
                });
            }
        };
    }
    //
    if (alertView.actionButtonArr.lastObject) {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, CGRectGetMaxY(alertView.actionButtonArr.lastObject.frame));
    }
    //
    view.center = CGPointMake(alertView.frame.size.width/2, alertView.frame.size.height/2);
    return alertView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
