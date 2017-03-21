//
//  SQTextAlertView.h
//  sq580.com.followup
//
//  Created by Faith on 16/4/20.
//  Copyright © 2016年 hjw. All rights reserved.
//

#import "SQAlertViewBase.h"
#import "RTLabel.h"

@interface SQTextAlertView : SQAlertViewBase

@property(strong,nonatomic,readonly) RTLabel* rtContentLabel;  //富文本内容标签

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
- (_Nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString*)message messageRealSize:(nullable NSValue*)messageRealSize delegate:(nullable id<SQAlertViewDelegate>)delegate buttonTitles:(nullable NSArray*)buttonTitles;

@end
