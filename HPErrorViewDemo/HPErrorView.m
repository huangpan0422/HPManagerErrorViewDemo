//
//  HPErrorView.m
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "HPErrorView.h"

#define DEFAULT_ERROR_TEXT @"加载失败，请检查网络..."

@interface HPErrorView ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation HPErrorView
#pragma mark - Init
+ (instancetype)viewWithType:(HPErrorType)type {
    HPErrorView *errorView = [[self alloc] initWithFrame:CGRectZero];
    errorView.errorType = type;
    return errorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    //
    _errorType = HPErrorTypeDefault;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //
    _contentLabel = [[UILabel alloc] init];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.font = [UIFont systemFontOfSize:16.0f];
    self.contentLabel.text = DEFAULT_ERROR_TEXT;
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.contentLabel];
    // 布局
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:-50]];
}

#pragma mark - Getter & Setter
- (void)setErrorType:(HPErrorType)errorType {
    if (_errorType != errorType) {
        _errorType = errorType;
        switch (_errorType) {
            case HPErrorTypeEmptyData: {
                self.contentLabel.text = _customText ? : DEFAULT_ERROR_TEXT;
                [self setNeedsLayout];
            } break;
            case HPErrorTypeUnavailableNetwork: {
                self.contentLabel.text = _customText ? : DEFAULT_ERROR_TEXT;
                [self setNeedsLayout];
            } break;
                
            default:
                break;
        }
    }
}
@end
