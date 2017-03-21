//
//  SQPopOverView.h
//  sq580.com.followup
//
//  Created by Faith on 16/4/20.
//  Copyright © 2016年 hjw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SQPopOverViewDelegate;

/**
 *  弹出视图
 */
@interface SQPopOverView : UIView

@property(strong,nonatomic,readonly) UIButton* backgroundView;  //背景视图
@property(weak,nonatomic) id<SQPopOverViewDelegate> backgroundViewDelegate;  //背景视图事件委托
@property(nonatomic) BOOL disableBackgroundView;  //是否禁用背景视图
@property(nonatomic,readonly) NSInteger target;  //唯一性标识

/**
 *  显示
 */
- (void)show;

/**
 *  显示
 *  @param target 唯一性标识，同一个标识不会显示多个弹出视图实例
 */
- (void)showWithTarget:(NSInteger)target;

/**
 *  关闭
 */
- (void)hide;

@end

/**
 *  弹出视图事件委托
 */
@protocol SQPopOverViewDelegate <NSObject>

/**
 *  点击弹出视图背景层
 *
 *  @param popOverView 弹出视图实例
 *  @param sender 事件发出者
 */
- (void)popOverView:(SQPopOverView*)popOverView onTapBackgroundView:(id)sender;

@end
