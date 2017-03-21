//
//  SQTextAlertView.m
//  sq580.com.followup
//
//  Created by Faith on 16/4/20.
//  Copyright © 2016年 hjw. All rights reserved.
//

#import "SQTextAlertView.h"
#import "NSString+Size.h"


@implementation SQTextAlertView

/**
 *  初始化
 *
 *  @param title         标题
 *  @param message       消息
 *  @param delegate      事件委托
 *  @param buttonTitles  按钮标题数组,如果为nil或者为空则不创建按钮,最多两个
 *
 *  @return 消息框实例
 */
- (_Nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString*)message messageRealSize:(nullable NSValue*)messageRealSize delegate:(nullable id<SQAlertViewDelegate>)delegate buttonTitles:(nullable NSArray*)buttonTitles {
    if ([NSThread isMainThread]) {
        UIFont* messageFont = [UIFont systemFontOfSize:17];
        CGFloat contentHeight = 44;
        if (message) {
            CGSize size=CGSizeMake([UIScreen mainScreen].bounds.size.width - MainAlertViewHorizontalMargin * 4, NSIntegerMax);
            CGSize contentSize;
            if (messageRealSize) {
                CGSize size = [messageRealSize CGSizeValue];
                contentSize = size;
            }
            else {
                contentSize = [message boundingSizeWithFont:messageFont  maxBoundingSize:size];
            }
            
            if (contentSize.height > contentHeight) {
                contentHeight = contentSize.height;
            }
        }
        
        self = [super initWithTitle:title contentHeight:contentHeight delegate:delegate buttonTitles:buttonTitles];
        if (self) {
            _rtContentLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width - MainAlertViewHorizontalMargin * 2, self.contentView.frame.size.height)];
            _rtContentLabel.text = message;
            _rtContentLabel.font = [UIFont systemFontOfSize:16];;
            _rtContentLabel.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);
            _rtContentLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
            [_rtContentLabel setTextAlignment:RTTextAlignmentCenter];
            _rtContentLabel.textColor = [UIColor grayColor];
            [self.contentView addSubview:_rtContentLabel];
        }
    }
    else {
        __block id curObj = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            curObj = [self initWithTitle:title message:message messageRealSize:messageRealSize delegate:delegate buttonTitles:buttonTitles];
        });
        while (!curObj) {
            [NSThread sleepForTimeInterval:0.5];
        }
        self = curObj;
    }
    return self;
}

@end
