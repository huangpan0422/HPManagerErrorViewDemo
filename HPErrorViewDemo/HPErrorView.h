//
//  HPErrorView.h
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HPErrorType) {
    HPErrorTypeUnavailableNetwork,
    HPErrorTypeEmptyData,
    HPErrorTypeDefault = HPErrorTypeUnavailableNetwork
};

@interface HPErrorView : UIView
/**
 当前错误类型【默认为Default】
 */
@property (nonatomic, assign) HPErrorType errorType;
/**
 要显示的文案【为nil使用默认文案】
 */
@property (nonatomic, copy) NSString *customText;
/**
 实例化
 */
+(instancetype)viewWithType:(HPErrorType)type;

@end

