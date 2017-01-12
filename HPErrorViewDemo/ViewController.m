//
//  ViewController.m
//  HPErrorViewDemo
//
//  Created by huangpan on 17/1/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "ViewController.h"
#import "HPErrorView.h"
#import "UIViewController+HPAdd.h"
#import "UITableView+HPAdd.h"

static NSString *const cellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface ViewController ()
@property (nonatomic, weak) UIBarButtonItem *item;
@property (nonatomic, assign) NSUInteger numberOfRows;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 显示或者隐藏
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(changErrorViewStatus:)];
    item.title = @"展示";
    [self.navigationItem setLeftBarButtonItem:item];
    self.item = item;
    
    self.numberOfRows = 20;
    //
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    self.tableView.rowHeight = 45.0f;
    self.tableView.autoControlErrorView = YES;
}


- (void)changErrorViewStatus:(id)sender {
    if ([self.item.title isEqualToString:@"展示"]) {
        self.item.title = @"隐藏";
        // 1. 直接显示
        // [self directShowErrorView];
        
        // 2. 分类控制
        // [self showErrorView];
        
        // 3. 自动控制
        self.numberOfRows = 0;
        [self.tableView reloadData];
    } else {
        self.item.title = @"展示";
        // 1. 直接隐藏
        // [self directRemoveErrorView];
        
        // 2. 分类控制
        // [self removeErrorView];
        
        // 3. 自动控制
        self.numberOfRows = 20;
        [self.tableView reloadData];
    }
}

/**
 显示错误页
 */
- (void)directShowErrorView {
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
}


/**
 移除错误页
 */
- (void)directRemoveErrorView {
    HPErrorView *errorView = [self checkErrorViewExist];            // 检查是否存在
    if (errorView) {
        [errorView removeFromSuperview]; // 移除
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"当前是第%zd行", indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
