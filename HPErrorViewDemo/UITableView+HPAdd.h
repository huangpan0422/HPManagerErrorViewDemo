//
//  UITableView+HPAdd.h
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HPAdd)
/**
 是否需要自动管理显示错误页【默认不需要】
 */
@property (nonatomic, assign, getter=isAutoControlErrorView) BOOL autoControlErrorView;
@end
