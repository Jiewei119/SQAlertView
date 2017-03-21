//
//  SQAlertViewBase.m
//  sq580.com.followup
//
//  Created by Faith on 16/4/20.
//  Copyright © 2016年 hjw. All rights reserved.
//

#import "SQAlertViewBase.h"



@implementation SQAlertViewBase

/**
 *  初始化
 *
 *  @param title         标题
 *  @param contentHeight 内容视图高度
 *  @param delegate      事件委托
 *  @param buttonTitles  按钮标题数组,如果为nil或者为空则不创建按钮,最多两个
 *
 *  @return 消息框实例
 */
- (_Nonnull instancetype)initWithTitle:(nullable NSString *)title contentHeight:(CGFloat)contentHeight delegate:(nullable id<SQAlertViewDelegate>)delegate buttonTitles:(nullable NSArray*)buttonTitles {
    if ([NSThread isMainThread]) {
        self.delegate = delegate;
        if (contentHeight < ContentViewMinHeight) {
            contentHeight = ContentViewMinHeight;
        }
        //设置固定宽度
        CGRect frame = CGRectMake(0, 0, 290,TitleViewMarginTop + TitleViewHeight + contentHeight + ButtonPanelHeight+ 20);
        self = [super initWithFrame:frame];
        //设置圆角
        self.layer.cornerRadius = 10;
        if (self) {
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
            
            _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, TitleViewMarginTop, frame.size.width, TitleViewHeight)];
            [self addSubview:_titleView];
            
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _titleView.frame.size.width - MainAlertViewHorizontalMargin * 2, TitleViewHeight)];
            [_titleView addSubview:_titleLabel];
            _titleLabel.text = title;
            _titleLabel.textColor = [UIColor darkGrayColor];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.center = CGPointMake(_titleView.frame.size.width / 2, _titleView.frame.size.height / 2);
            
            _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.frame.origin.y + _titleView.frame.size.height+10, frame.size.width, contentHeight)];
            [self addSubview:_contentView];
            
            //设置水平分割线
            UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, _contentView.frame.origin.y + _contentView.frame.size.height + 10, frame.size.width, 1)];
            horizontalLine.backgroundColor = [UIColor lightGrayColor];
            horizontalLine.alpha = 0.4;
            [self addSubview:horizontalLine];
            
            _buttonPanel = [[UIView alloc] initWithFrame:CGRectMake(0, _contentView.frame.origin.y + _contentView.frame.size.height + 10, frame.size.width, ButtonPanelHeight)];
            [self addSubview:_buttonPanel ];
            
            if (self.buttons) {
                _buttons = [NSMutableArray array];
            }
            if (buttonTitles && buttonTitles.count > 0 && buttonTitles.count < 3) {
                switch (buttonTitles.count) {
                    case 1:
                    {
                        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake(0, 0, _buttonPanel.frame.size.width, _buttonPanel.frame.size.height);
                        [button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                        [button setTitle:buttonTitles[0] forState:UIControlStateNormal];
                        button.titleLabel.font = [UIFont systemFontOfSize:16];
                        [_buttonPanel addSubview:button];
                        [self.buttons addObject:button];
                    }
                        break;
                    case 2:
                    {
                        UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                        button1.frame = CGRectMake(0, 0, _buttonPanel.frame.size.width / 2, _buttonPanel.frame.size.height);
                        [button1 addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                        button1.tag = 1;
                        [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                        [button1 setTitle:buttonTitles[0] forState:UIControlStateNormal];
                        button1.titleLabel.font = [UIFont systemFontOfSize:16];
                        [_buttonPanel addSubview:button1];
                        [self.buttons addObject:button1];
                        
                        //设置垂直分割线
                        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(_buttonPanel.frame.size.width / 2, 0, 1, _buttonPanel.frame.size.height)];
                        verticalLine.backgroundColor = [UIColor lightGrayColor];
                        verticalLine.alpha = 0.4;
                        [_buttonPanel addSubview:verticalLine];
                        
                        UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
                        button2.frame = CGRectMake(_buttonPanel.frame.size.width / 2, 0, _buttonPanel.frame.size.width / 2, _buttonPanel.frame.size.height);
                        [button2 addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                        button2.tag = 2;
                        button2.titleLabel.font = [UIFont systemFontOfSize:16];
                        [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                        [button2 setTitle:buttonTitles[1] forState:UIControlStateNormal];
                        [_buttonPanel addSubview:button2];
                        [self.buttons addObject:button2];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
    }
    else {
        __block id curObj = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            curObj = [self initWithTitle:title contentHeight:contentHeight delegate:delegate buttonTitles:buttonTitles];
        });
        while (!curObj) {
            [NSThread sleepForTimeInterval:0.5];
        }
        self = curObj;
    }
    return self;
}

- (void)onButton:(UIButton*)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:sender.tag - 1];
    }
    [self hide];
}

@end
