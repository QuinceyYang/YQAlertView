//
//  YQButton.h
//  YQButton
//
//  Created by 杨清 on 2017/6/13.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQButton : UIButton

@property (nonatomic, copy) void (^tapAction)(YQButton *sender);

/**
 * 图片在左，标题在右，且图片和标题整体居中
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame contentAtCenterWithSpace:(CGFloat)space;

/**
 * 图片在上，图片和标题整体居中
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtTopWithSpace:(CGFloat)space;

/**
 * 图片在上
 * @params topOffset 图片与上边缘的间隔
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtTop:(CGFloat)topOffset space:(CGFloat)space;

/**
 * 图片在下
 * @params topOffset label与上边缘的间隔
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtBottom:(CGFloat)topOffset space:(CGFloat)space;

/**
 * 图片在左边，标题靠左，标题长度有限制
 * @params leftOffset 图片与左边缘的间隔
 * @params space 图片与label之间的间隔
 * @params rightOffset label与右边缘的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtLeft:(CGFloat)leftOffset space:(CGFloat)space rightOffset:(CGFloat)rightOffset;

/**
 * 图片在左边，标题自适应
 * @params leftOffset 图片与左边缘的间隔
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtLeft:(CGFloat)leftOffset space:(CGFloat)space;

/**
 * 图片在右边，标题靠左，标题长度有限制
 * @params leftOffset label与左边缘的间隔
 * @params space 图片与label之间的间隔
 * @params rightOffset 图片与右边缘的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtRight:(CGFloat)leftOffset space:(CGFloat)space rightOffset:(CGFloat)rightOffset;

/**
 * 图片在右边，标题自适应，且标题靠近图片
 * @params rightOffset 图片与右边缘的间隔
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtRight:(CGFloat)rightOffset space:(CGFloat)space;

/**
 * 自定义图片和标题位置
 */
- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect)titleFrame;

@end
