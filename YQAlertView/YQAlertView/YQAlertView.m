//
//  YQAlertView.m
//  YQAlertView
//
//  Created by 杨清 on 2019/6/11.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "YQAlertView.h"

@implementation YQAlertView


+ (instancetype)alertViewWithTitle:(NSString * _Nullable)title message:(NSString *)message actionArray:(NSArray * _Nullable)actionArr completion:(void (^ _Nullable)(NSInteger actionIndex))completion {
    
    YQAlertView *alertView = [[YQAlertView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    alertView.isAutoCloseWhenTapAction = YES;
    //
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width-80, alertView.frame.size.height-160)];
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.backgroundColor = UIColor.whiteColor;
    [alertView addSubview:view];
    alertView.contentView = view;
    //
    CGFloat tmpY = 0;
    if (title) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 23, view.frame.size.width-80, 22)];
        titleLab.text = title;
        titleLab.textColor = [UIColor colorWithRed:0x22/255.0 green:0x22/255.0 blue:0x22/255.0 alpha:1.0];
        titleLab.font = [UIFont boldSystemFontOfSize:18];
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
        tmpY = CGRectGetMaxY(titleLab.frame)+2;
    }
    else {
        //
    }
    //
    UIView *bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, tmpY, view.frame.size.width, 120)];
    //bodyView.backgroundColor = UIColor.whiteColor;
    [view addSubview:bodyView];
    //
    CGFloat hSpace = 12;
    CGFloat vSpace = 10;
    if (title == nil) {
        hSpace = 20;
        vSpace = 30;
    }
    //
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(hSpace, vSpace, bodyView.frame.size.width-2*hSpace, 10000)];
    messageLab.numberOfLines = 0;
    messageLab.text = message ?: @" ";
    messageLab.textColor = [UIColor colorWithRed:0x55/255.0 green:0x55/255.0 blue:0x55/255.0 alpha:1.0];
    messageLab.font = [UIFont systemFontOfSize:16];
    [messageLab sizeToFit];
    messageLab.frame = CGRectMake((bodyView.frame.size.width-messageLab.frame.size.width)/2, vSpace, messageLab.frame.size.width, messageLab.frame.size.height);
    [bodyView addSubview:messageLab];
    alertView.messageLab = messageLab;
    //
    bodyView.frame = CGRectMake(bodyView.frame.origin.x, bodyView.frame.origin.y, bodyView.frame.size.width, CGRectGetMaxY(messageLab.frame)+vSpace);
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, CGRectGetMaxY(bodyView.frame));
    //
    if (actionArr==nil || actionArr.count<=0) {
        if (title) {
            view.center = CGPointMake(alertView.frame.size.width/2, alertView.frame.size.height/2);
            return alertView;
        }
        else {
            //update frames
            view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            messageLab.textColor = UIColor.whiteColor;
            messageLab.frame = CGRectMake(15, 15, alertView.frame.size.width-60, 10000);
            [messageLab sizeToFit];
            view.frame = CGRectMake((alertView.frame.size.width-(messageLab.frame.size.width+2*15))/2, (alertView.frame.size.height-(messageLab.frame.size.height+2*15))/2, messageLab.frame.size.width+2*15, messageLab.frame.size.height+2*15);
            bodyView.frame = view.bounds;
            messageLab.center = CGPointMake(bodyView.frame.size.width/2, bodyView.frame.size.height/2);
            return alertView;
        }
    }
    //
    UIView *separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bodyView.frame)+(title==nil?0:4.5), view.frame.size.width, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithRed:0xe0/255.0 green:0xe0/255.0 blue:0xe0/255.0 alpha:1.0];
    [view addSubview:separateLine];
    alertView.separateLine = separateLine;
    //
    alertView.actionButtonArr = [NSMutableArray new];
    for (NSInteger i=0; i<actionArr.count; i++) {
        YQButton *btn;
        if (actionArr.count <= 2) {
            CGFloat btnWidth = view.frame.size.width/actionArr.count;
            btn = [[YQButton alloc] initWithFrame:CGRectMake(i*btnWidth, CGRectGetMaxY(separateLine.frame), btnWidth, 48)];
        }
        else {
            btn = [[YQButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(separateLine.frame)+i*48, view.frame.size.width, 48)];
        }
        btn.tag = i;
        [btn setTitle:actionArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0x22/255.0 green:0x22/255.0 blue:0x22/255.0 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [view addSubview:btn];
        [alertView.actionButtonArr addObject:btn];
        if (i<actionArr.count-1) {
            if (actionArr.count <= 2) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width-0.5, 0, 0.5, btn.frame.size.height)];
                line.tag = 101;
                line.backgroundColor = [UIColor colorWithRed:0xe0/255.0 green:0xe0/255.0 blue:0xe0/255.0 alpha:1.0];
                [btn addSubview:line];
            }
            else {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, btn.frame.size.height-0.5, btn.frame.size.width, 0.5)];
                line.tag = 101;
                line.backgroundColor = [UIColor colorWithRed:0xe0/255.0 green:0xe0/255.0 blue:0xe0/255.0 alpha:1.0];
                [btn addSubview:line];
            }
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

+ (void)showMessage:(NSString *)message onView:(UIView *)view {
    YQAlertView *alertView = [YQAlertView alertViewWithTitle:nil message:message actionArray:nil completion:nil];
    [alertView showOnView:view];
}

- (void)showOnView:(UIView *)view {
    if (view == nil) {
        return;
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
    self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    self.contentView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [view addSubview:self];
    if (self.titleLab==nil && (self.actionButtonArr==nil || self.actionButtonArr.count<=0)) {
        __weak __typeof(self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:nil];
            [weakSelf removeFromSuperview];
            [UIView commitAnimations];
        });
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
