//
//  YQButton.m
//  YQButton
//
//  Created by 杨清 on 2017/6/13.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "YQButton.h"

#undef NSLog //yqing add for debug
#ifdef DEBUG
#define NSLog(format,args...)    NSLog(@"\n[yqing]<%@ %s line%d>" format"\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __PRETTY_FUNCTION__, __LINE__,##args)
#define printf(fmt,args...)   printf("\n[yqing]<%@ %s line%d>" fmt"\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __PRETTY_FUNCTION__, __LINE__, ##args)
#else
#define NSLog(fmt,args...)    {}
#define printf(fmt,args...)   {}
#endif

typedef NS_ENUM(NSUInteger, YQButtonType) {
    YQButtonTypeDefault,
    YQButtonTypeContentAtCenter,
    YQButtonTypeImageAtTop,
    YQButtonTypeImageAtTopAndContentAtCenter,
    YQButtonTypeImageAtBottom,
    YQButtonTypeImageAtBottomAndContentAtCenter,
    YQButtonTypeImageAtLeft,///<图片在左边，标题靠左，标题长度有限制
    YQButtonTypeImageAtLeftSelfAdaption, ///<图片在左边，标题自适应
    YQButtonTypeImageAtRight,///<图片在右边，标题靠左，标题长度有限制
    YQButtonTypeImageAtRightSelfAdaption, ///<图片在右边，标题自适应，且标题靠近图片
    YQButtonTypeCustomFrame
};

@implementation YQButton
{
    YQButtonType _yqButtonType;
    CGFloat _topOffset;
    CGFloat _space;
    CGFloat _leftOffset;
    CGFloat _rightOffset;
    
    CGRect _imageFrame;
    CGRect _titleFrame;
}

#pragma mark - init methods

/**
 * 图片在左，标题在右，且图片和标题整体居中
 */
- (instancetype)initWithFrame:(CGRect)frame contentAtCenterWithSpace:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeContentAtCenter;
        _space = space;
    }
    
    return self;
}

/**
 * 图片在上，图片和标题整体居中
 * @params space 图片与label之间的间隔
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtTopWithSpace:(CGFloat)space {
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtTopAndContentAtCenter;
        _space = space;
    }
    return self;
}

/**
 * 图片在上
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtTop:(CGFloat)topOffset space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtTop;
        _topOffset = topOffset;
        _space = space;
    }
    
    return self;
}

/**
 * 图片在下
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtBottom:(CGFloat)topOffset space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtBottom;
        _topOffset = topOffset;
        _space = space;
    }
    
    return self;
}


/**
 * 图片在左边，标题靠左，标题长度有限制
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtLeft:(CGFloat)leftOffset space:(CGFloat)space rightOffset:(CGFloat)rightOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtLeft;
        _leftOffset = leftOffset;
        _space = space;
        _rightOffset = rightOffset;
    }
    
    return self;
}

/**
 * 图片在左边，标题自适应
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtLeft:(CGFloat)leftOffset space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtLeftSelfAdaption;
        _leftOffset = leftOffset;
        _space = space;
    }
    
    return self;
}



/**
 * 图片在右边，标题靠左，标题长度有限制
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtRight:(CGFloat)leftOffset space:(CGFloat)space rightOffset:(CGFloat)rightOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtRight;
        _leftOffset = leftOffset;
        _space = space;
        _rightOffset = rightOffset;
    }
    
    return self;
}

/**
 * 图片在右边，标题自适应，且标题靠近图片
 */
- (instancetype)initWithFrame:(CGRect)frame imageAtRight:(CGFloat)rightOffset space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeImageAtRightSelfAdaption;
        _space = space;
        _rightOffset = rightOffset;
    }
    
    return self;
}


/**
 * 自定义图片和标题位置
 */
- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect)titleFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        _yqButtonType = YQButtonTypeCustomFrame;
        _imageFrame = imageFrame;
        _titleFrame = titleFrame;
    }
    
    return self;
}


#pragma mark -
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView==nil || self.titleLabel==nil || _yqButtonType==YQButtonTypeDefault) {
        return;
    }
    else {
        NSLog(@"  ++++++++++++");
        switch (_yqButtonType) {
                
            case YQButtonTypeContentAtCenter:
            {
                CGFloat leftSpace = (self.frame.size.width-self.imageView.frame.size.width-_space-self.titleLabel.frame.size.width)/2;
                self.imageView.frame = CGRectMake(leftSpace, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.titleLabel.frame = CGRectMake(leftSpace+self.imageView.frame.size.width+_space, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtTop:
            {
                self.imageView.frame = CGRectMake((self.frame.size.width-self.imageView.frame.size.width)/2, _topOffset, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+_space, self.frame.size.width, self.titleLabel.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtTopAndContentAtCenter:
            {
                CGFloat topOffset = (self.frame.size.height-self.imageView.frame.size.height-_space-self.titleLabel.frame.size.height)/2;
                self.imageView.frame = CGRectMake((self.frame.size.width-self.imageView.frame.size.width)/2, topOffset, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+_space, self.frame.size.width, self.titleLabel.frame.size.height);
            }
                break;

            case YQButtonTypeImageAtBottom:
            {
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                self.titleLabel.frame = CGRectMake(0, _topOffset, self.frame.size.width, self.titleLabel.frame.size.height);
                self.imageView.frame = CGRectMake((self.frame.size.width-self.imageView.frame.size.width)/2, CGRectGetMaxY(self.titleLabel.frame)+_space, self.imageView.frame.size.width, self.imageView.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtBottomAndContentAtCenter:
            {
                CGFloat topOffset = (self.frame.size.height-self.imageView.frame.size.height-self.titleLabel.frame.size.height-_space)/2;
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                self.titleLabel.frame = CGRectMake(0, topOffset, self.frame.size.width, self.titleLabel.frame.size.height);
                self.imageView.frame = CGRectMake((self.frame.size.width-self.imageView.frame.size.width)/2, CGRectGetMaxY(self.titleLabel.frame)+_space, self.imageView.frame.size.width, self.imageView.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtLeft:
            {
                if (self.frame.size.width-_leftOffset-_space-_rightOffset-self.imageView.frame.size.width < 0) {
                    NSLog(@"Error : self width is short");
                    return;
                }
                self.imageView.frame = CGRectMake(_leftOffset, (self.frame.size.height-self.imageView.frame.size.height)/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
                self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+_space, (self.frame.size.height-self.titleLabel.frame.size.height)/2, self.frame.size.width-(CGRectGetMaxX(self.imageView.frame)+_space)-_rightOffset, self.titleLabel.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtLeftSelfAdaption:
            {
                if (self.frame.size.width-_leftOffset-_space-self.imageView.frame.size.width < 0) {
                    NSLog(@"Error : self width is short");
                    return;
                }
                self.imageView.frame = CGRectMake(_leftOffset, (self.frame.size.height-self.imageView.frame.size.height)/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
                self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+_space, (self.frame.size.height-self.titleLabel.frame.size.height)/2, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtRight:
            {
                if (self.frame.size.width-_leftOffset-_space-_rightOffset-self.imageView.frame.size.width < 0) {
                    NSLog(@"Error : self width is short");
                    return;
                }
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
                CGFloat titleW = self.frame.size.width-_leftOffset-_space-self.imageView.frame.size.width-_rightOffset;
                self.titleLabel.frame = CGRectMake(_leftOffset, (self.frame.size.height-self.titleLabel.frame.size.height)/2, titleW, self.titleLabel.frame.size.height);
                self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+_space, (self.frame.size.height-self.imageView.frame.size.height)/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
            }
                break;
                
            case YQButtonTypeImageAtRightSelfAdaption:
            {
                if (self.frame.size.width-_space-self.imageView.frame.size.width-_rightOffset < 0) {
                    NSLog(@"Error : self width is short");
                    return;
                }
                self.imageView.frame = CGRectMake(self.frame.size.width-_rightOffset-self.imageView.frame.size.width, (self.frame.size.height-self.imageView.frame.size.height)/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.titleLabel.frame = CGRectMake(self.frame.size.width-_rightOffset-self.imageView.frame.size.width-_space-self.titleLabel.frame.size.width, (self.frame.size.height-self.titleLabel.frame.size.height)/2, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            }
                break;
                
            case YQButtonTypeCustomFrame:
            {
                self.imageView.frame = _imageFrame;
                self.titleLabel.frame = _titleFrame;
            }
                break;
                
            default:
                break;
        }
        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - setter

- (void)setTapAction:(void (^)(YQButton *))tapAction {
    _tapAction = tapAction;
    if (_tapAction) {
        [self removeTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -
- (void)tapButton:(YQButton *)sender {
    if (self.tapAction) {
        self.tapAction(sender);
    }
}

@end
