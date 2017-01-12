//
//  UIViewController+HPAdd.h
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 错误页的tag
 */
extern NSUInteger const HPErrorViewTag;

@class HPErrorView;

@interface UIViewController (HPAdd)
/**
 显示错误页
 */
- (void)showErrorView;

/**
 移除错误页
 */
- (void)removeErrorView;

/**
 检测当前页面是否存在ErrorView
 
 @return ErrorView
 */
- (HPErrorView *)checkErrorViewExist;
@end
