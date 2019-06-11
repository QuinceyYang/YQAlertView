//
//  YQAlertView.h
//  YQAlertView
//
//  Created by 杨清 on 2019/6/11.
//  Copyright © 2019 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YQButton/YQButton.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQAlertView : UIView

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *messageLab;
@property (strong, nonatomic) NSMutableArray <YQButton *> * actionButtonArr;
/// 用户某按钮后，是否自动关闭视图，默认为YES
@property (assign, nonatomic) BOOL isAutoCloseWhenTapAction;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArr completion:(void (^)(NSInteger actionIndex))completion;


@end

NS_ASSUME_NONNULL_END
