//
//  UIViewController+HPAdd.m
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "UIViewController+HPAdd.h"
#import "HPErrorView.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

NSUInteger const HPErrorViewTag = 1024;

@implementation UIViewController (HPAdd)
/**
 显示错误页
 */
- (void)showErrorView {
    dispatch_main_async_safe(^{
        HPErrorView *errorView = [self checkErrorViewExist];
        if (!errorView) {
            errorView = [HPErrorView viewWithType:HPErrorTypeDefault];          // 创建
            errorView.tag = HPErrorViewTag;
            [self.view addSubview:errorView]; // 添加
            // 布局
            errorView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
        }
        [self.view bringSubviewToFront:errorView];
    });
}


/**
 移除错误页
 */
- (void)removeErrorView {
    dispatch_main_async_safe(^{
        HPErrorView *errorView = [self checkErrorViewExist];            // 检查是否存在
        if (errorView) {
            [errorView removeFromSuperview]; // 移除
        }
    });
}

/**
 检测当前页面是否存在ErrorView
 
 @return ErrorView
 */
- (HPErrorView *)checkErrorViewExist {
    return [self.view viewWithTag:HPErrorViewTag];
}


@end
