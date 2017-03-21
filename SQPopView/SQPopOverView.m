//
//  SQPopOverView.m
//  sq580.com.followup
//
//  Created by Faith on 16/4/20.
//  Copyright © 2016年 hjw. All rights reserved.
//

#import "SQPopOverView.h"

static NSMutableDictionary* SQPopOverViewTargetCollection;

@implementation SQPopOverView


/**
 *  显示
 */
- (void)show {
    if ([NSThread isMainThread]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        if (self.backgroundView) {
            [self.backgroundView removeFromSuperview];
        }
        
        UIView* window = [UIApplication sharedApplication].keyWindow;
        if (!window) {
            window = [self getCurrentVC].view;
        }
        
        if (!self.backgroundView && !self.disableBackgroundView) {
            // 创建背景蒙板
            _backgroundView = [UIButton buttonWithType:UIButtonTypeCustom];
            self.backgroundView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            self.backgroundView.backgroundColor = [UIColor blackColor];
            self.backgroundView.alpha = 0.4;
            [self.backgroundView addTarget:self action:@selector(onTapBackgroundView:) forControlEvents:UIControlEventTouchUpInside];
            [window addSubview:self.backgroundView];
        }
        
        
        self.alpha = 0;
        [window addSubview:self];
        [window bringSubviewToFront:self];
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        }];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self show];
        });
    }
}


//获取当前显示的视图控制器
- (UIViewController *)getCurrentVC
{
    UIViewController* topVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 *  显示
 *  @param target 唯一性标识，同一个标识不会显示多个弹出视图实例
 */
- (void)showWithTarget:(NSInteger)target {
    BOOL needShow = NO;
    NSNumber* key =[NSNumber numberWithInteger:target];
    if (!SQPopOverViewTargetCollection) {
        SQPopOverViewTargetCollection = [NSMutableDictionary dictionary];
        [SQPopOverViewTargetCollection setObject:self forKey:key];
        needShow = YES;
    }
    else {
        if (![SQPopOverViewTargetCollection objectForKey:key]) {
            [SQPopOverViewTargetCollection setObject:self forKey:key];
            needShow = YES;
        }
    }
    if (needShow) {
        _target = target;
        [self show];
    }
}

/**
 *  关闭
 */
- (void)hide {
    if ([NSThread isMainThread]) {
        NSNumber* key =[NSNumber numberWithInteger:_target];
        if (SQPopOverViewTargetCollection && [SQPopOverViewTargetCollection objectForKey:key]) {
            [SQPopOverViewTargetCollection removeObjectForKey:key];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hide];
        });
    }
}

/**
 *  点击背景视图事件
 *
 *  @param sender 事件发出者
 */
- (void)onTapBackgroundView:(id)sender {
    if (self.backgroundViewDelegate && [self.backgroundViewDelegate respondsToSelector:@selector(popOverView:onTapBackgroundView:)]) {
        [self.backgroundViewDelegate popOverView:self onTapBackgroundView:sender];
    }
}

@end
