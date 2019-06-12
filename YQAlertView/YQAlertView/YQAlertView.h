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

@property (strong, nonatomic) UIView * contentView;
@property (strong, nonatomic) UILabel *titleLab;
/// title Label下面的分割线，默认hidden=YES
@property (strong, nonatomic) UIView *separateLine1;
@property (strong, nonatomic) UILabel *messageLab;
/// message Label下面的分割线
@property (strong, nonatomic) UIView *separateLine2;
@property (strong, nonatomic) NSMutableArray <YQButton *> * actionButtonArr;
/// 用户某按钮后，是否自动关闭视图，默认为YES
@property (assign, nonatomic) BOOL isAutoCloseWhenTapAction;

+ (instancetype)alertViewWithTitle:(NSString * _Nullable)title message:(NSString *)message actionArray:(NSArray * _Nullable)actionArr completion:(void (^ _Nullable)(NSInteger actionIndex))completion;

/**
 * 显示提示消息message，在1.5秒后自动消失，类似于HUD
 */
+ (void)showMessage:(NSString *)message onView:(UIView *)view;

- (void)showOnView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
