//
//  SQAlertViewBase.h
//  sq580.com.followup
//
//  Created by Faith on 16/4/20.
//  Copyright © 2016年 hjw. All rights reserved.
//

#import "SQPopOverView.h"

#define MainAlertViewHorizontalMargin  20  //水平对齐
#define MainAlertViewWidth ([UIScreen mainScreen].bounds.size.width - MainAlertViewHorizontalMargin * 2)  //消息框宽度
#define TitleViewHeight 24   //标题视图高度
#define ButtonPanelHeight 44  //按钮面板高度
#define ContentViewMinHeight 24   //内容视图最小高度
#define TitleViewMarginTop 10  ////标题视图距离顶部


@protocol SQAlertViewDelegate;

/**
 *  消息框基类
 */
@interface SQAlertViewBase : SQPopOverView

@property(strong,nonatomic,readonly) UIView* titleView;  //标题视图
@property(strong,nonatomic,readonly) UILabel* titleLabel;  //标题标签
@property(strong,nonatomic,readonly) UIView* contentView;  //内容视图
@property(strong,nonatomic,readonly) UIView* buttonPanel;  //按钮面板

@property(weak,nonatomic) id<SQAlertViewDelegate> delegate;  //事件委托
@property(strong,nonatomic,readonly) NSMutableArray* buttons;  //按钮集合

/**
 *  初始化
 *
 *  @param title         标题
 *  @param contentHeight 内容视图高度
 *  @param delegate      事件委托
 *  @param buttonTitles  按钮标题数组,如果为nil或者为空则不创建按钮
 *
 *  @return 消息框实例
 */
- (_Nonnull instancetype)initWithTitle:(nullable NSString *)title contentHeight:(CGFloat)contentHeight delegate:(nullable id<SQAlertViewDelegate>)delegate buttonTitles:(nullable NSArray*)buttonTitles;

@end

/**
 *  消息框事件委托
 */
@protocol SQAlertViewDelegate <NSObject>

/**
 *  点击消息框按钮
 *
 *  @param alertView   消息框
 *  @param buttonIndex 按钮索引
 */
- (void)alertView:(nonnull SQAlertViewBase *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
