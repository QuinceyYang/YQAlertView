//
//  YQAlertView.m
//  YQAlertView
//
//  Created by 杨清 on 2019/6/11.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import "YQAlertView.h"

@implementation YQAlertView


+ (instancetype)alertViewWithTitle:(NSString * _Nullable)title message:(NSString *)message actionArray:(NSArray * _Nullable)actionArr completion:(void (^)(NSInteger actionIndex))completion {
    
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
    if (title) {
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
    }
    else {
        //
    }
    //
    UIView *bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, title==nil?0:60, view.frame.size.width, 120)];
    //bodyView.backgroundColor = UIColor.whiteColor;
    [view addSubview:bodyView];
    //
    CGFloat hSpace = 12;
    CGFloat vSpace = 12;
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
    messageLab.frame = CGRectMake(hSpace, vSpace, bodyView.frame.size.width-2*hSpace, messageLab.frame.size.height);
    [bodyView addSubview:messageLab];
    alertView.messageLab = messageLab;
    if ([YQAlertView yq_widthOfString:messageLab.text font:messageLab.font] < bodyView.frame.size.width-2*hSpace) {
        messageLab.textAlignment = NSTextAlignmentCenter;
    }
    //
    bodyView.frame = CGRectMake(bodyView.frame.origin.x, bodyView.frame.origin.y, bodyView.frame.size.width, CGRectGetMaxY(messageLab.frame)+vSpace);
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - private
+ (CGFloat)yq_widthOfString:(NSString *)str font:(UIFont *)font
{
    if (str==nil || font==nil) {
        return 0;
    }

    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = str;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(INFINITY, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [str sizeWithFont:font constrainedToSize:CGSizeMake(INFINITY, INFINITY) lineBreakMode:NSLineBreakByWordWrapping];
    }
    textSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));

    return textSize.width;
}



@end
