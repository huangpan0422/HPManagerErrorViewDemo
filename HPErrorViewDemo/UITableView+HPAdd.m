//
//  UITableView+HPAdd.m
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "UITableView+HPAdd.h"
#import <objc/runtime.h>
#import "HPErrorView.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

static NSUInteger const HPErrorViewTag = 1024;

@implementation UITableView (HPAdd)
/**
 *  在这里将reloadData方法进行替换
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // 替换三个方法
        SEL originalSelector = @selector(reloadData);
        SEL swizzledSelector = @selector(_hp_reloadData);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL needAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if ( needAddMethod ) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)_hp_reloadData {
    if (self.isAutoControlErrorView) {
        [self _checkIsEmpty];
    }
    [self _hp_reloadData];
}

#pragma mark - Helper
- (void)_checkIsEmpty {
    BOOL isEmpty = YES;
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1; // 默认显示1组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];
    }
    
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];
        if (rows != 0) {
            isEmpty = NO; // 若行数存在，则数据不为空
            break;
        }
    }
    
    dispatch_main_async_safe(^{
        if (isEmpty) {
            [self _showErrorView];   // 显示错误页
        } else {
            [self _removeErrorView]; // 移除错误页
        }
    });
}

#pragma mark - Helper
/**
 显示错误页
 */
- (void)_showErrorView {
    HPErrorView *errorView = [self _checkErrorViewExist];
    if (!errorView) {
        errorView = [HPErrorView viewWithType:HPErrorTypeDefault];          // 创建
        errorView.tag = HPErrorViewTag;
        [self addSubview:errorView];      // 添加
        // 布局
        errorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:errorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    }
    [self bringSubviewToFront:errorView];
}

/**
 移除错误页
 */
- (void)_removeErrorView {
    // 检查是否存在
    HPErrorView *errorView = [self _checkErrorViewExist];
    if (errorView) {
        [errorView removeFromSuperview]; // 移除
    }
}

/**
 检测当前页面是否存在ErrorView
 
 @return ErrorView
 */
- (HPErrorView *)_checkErrorViewExist {
    return [self viewWithTag:HPErrorViewTag];
}


#pragma mark - Setter & Getter
- (BOOL)isAutoControlErrorView {
    return [objc_getAssociatedObject(self, @selector(isAutoControlErrorView)) boolValue];
}

- (void)setAutoControlErrorView:(BOOL)autoControlErrorView {
    objc_setAssociatedObject(self, @selector(isAutoControlErrorView), @(autoControlErrorView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
