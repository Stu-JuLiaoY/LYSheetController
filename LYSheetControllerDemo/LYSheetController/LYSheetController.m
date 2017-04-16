//
//  LYSheetController.m
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetController.h"
#import "LYSheetCell.h"
#import "LYSheetModel.h"
#import "UIViewController+Active.h"

static NSString * const LYSheetControllerStyleDefault = @"LYSheetControllerStyleDefault";
static NSString * const LYSheetControllerStyleCancel = @"LYSheetControllerStyleCancel";
static const NSTimeInterval animationDuration = 0.2;

#define LYScreenWidth         [[UIScreen mainScreen]bounds].size.width
#define LYScreenHeight        [[UIScreen mainScreen] bounds].size.height

static CGFloat LYSheetRowHeight = 50.f;

@interface LYSheetController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign, getter=isPresenting) BOOL presenting;

@end

@implementation LYSheetController

#pragma mark - life cycle
#pragma mark
- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self isBeingPresented]) {
        self.presenting = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self isBeingDismissed]) {
        self.presenting = NO;
    }
}

/// 初始化默认值
- (void)defaultConfig {
    self.presenting = NO;
    self.scrollEnableAuto = YES;
    self.gestureEnable = YES;
    self.dismissWhenSelected = YES;
    self.rowHeight = LYSheetRowHeight;
    self.maxSheetHeight = LYScreenHeight * 2 / 3;
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}

#pragma mark - public
#pragma mark
- (instancetype)initWithDataSource:(NSArray<__kindof LYSheetModel *> *)dataSource {
    self.dataSource = dataSource;
    return [self init];
}

- (void)registSheetControllerCell:(__kindof LYSheetCell *)cell forStyle:(LYSheetStyle)style {
    if (style == kLYSheetStyleDefault) {
        [self.tableView registerClass:[cell class] forCellReuseIdentifier:LYSheetControllerStyleDefault];
    } else if (style == kLYSheetStyleCancel) {
        [self.tableView registerClass:[cell class] forCellReuseIdentifier:LYSheetControllerStyleCancel];
    } else if (style == (kLYSheetStyleCancel | kLYSheetStyleDefault)) {
        [self.tableView registerClass:[cell class] forCellReuseIdentifier:LYSheetControllerStyleDefault];
        [self.tableView registerClass:[cell class] forCellReuseIdentifier:LYSheetControllerStyleCancel];
    }
}

- (void)reloadSheet {
    [self.tableView reloadData];
}

- (void)showSheetControllerWithAnimated:(BOOL)animated completionHandler:(void (^ _Nullable)(BOOL))completionHandler {
    if (self.isPresenting) return;
    UIViewController *active = [UIViewController activeViewController];
    if (active && [active isKindOfClass:[UIViewController class]]) {
        [active presentViewController:self animated:NO completion:^{
            if (animated) {
                [UIView animateWithDuration:animationDuration animations:^{
                    self.tableView.frame = CGRectMake(0, LYScreenHeight - MIN(self.maxSheetHeight, self.dataSource.count * self.rowHeight), LYScreenWidth, MIN(self.maxSheetHeight, self.dataSource.count * self.rowHeight));
                }];
            } else {
                self.tableView.frame = CGRectMake(0, LYScreenHeight - MIN(self.maxSheetHeight, self.dataSource.count * self.rowHeight), LYScreenWidth, MIN(self.maxSheetHeight, self.dataSource.count * self.rowHeight));
            }
            !completionHandler ? : completionHandler(YES);
        }];
    } else {
        !completionHandler ? : completionHandler(NO);
    }
}

- (void)dismissSheetControllerWithAnimated:(BOOL)animated completionHandler:(void (^ _Nullable)(BOOL))completionHandler {
    if (!animated) {
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    [UIView animateWithDuration:animationDuration animations:^{
        self.tableView.frame = CGRectMake(0, LYScreenHeight, LYScreenWidth, MIN(self.maxSheetHeight, self.dataSource.count * self.rowHeight));
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        !completionHandler ? : completionHandler(finished);
    }];
}

#pragma mark - custom
#pragma mark

- (void)setSheetSeparatorColor:(UIColor *)sheetSeparatorColor {
    _sheetSeparatorColor = sheetSeparatorColor;
    self.tableView.separatorColor = sheetSeparatorColor;
}

- (void)setSheetBackgroundColor:(UIColor *)sheetBackgroundColor {
    _sheetBackgroundColor = sheetBackgroundColor;
    self.tableView.backgroundColor = sheetBackgroundColor;
}

- (void)setDataSource:(NSArray<__kindof LYSheetModel *> *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    self.tableView.scrollEnabled = scrollEnable;
}

- (void)setScrollEnableAuto:(BOOL)scrollEnableAuto {
    _scrollEnableAuto = scrollEnableAuto;
    if (!scrollEnableAuto) return;
    if (self.dataSource.count * self.rowHeight > self.maxSheetHeight) {
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableView.scrollEnabled = NO;
    }
}

#pragma mark - delegate && datasource
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYSheetCell *cell = nil;
    LYSheetModel *model = self.dataSource[indexPath.row];
    NSAssert(model.style, @"必须要指定 cell 的 style");
    if (model.style == kLYSheetStyleDefault) {
        cell = [tableView dequeueReusableCellWithIdentifier:LYSheetControllerStyleDefault forIndexPath:indexPath];
    }
    if (model.style == kLYSheetStyleCancel) {
        cell = [tableView dequeueReusableCellWithIdentifier:LYSheetControllerStyleCancel forIndexPath:indexPath];
    }
    [cell bindModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetController:didSelectRowAtIndexPath:)]) {
        if (self.isDismissWhenSelected) {
            [self dismissSheetControllerWithAnimated:YES completionHandler:^(BOOL success) {
                [self.delegate sheetController:self didSelectRowAtIndexPath:indexPath.row];
                !self.dismissHandler ? : self.dismissHandler(success);
            }];
        } else {
            [self.delegate sheetController:self didSelectRowAtIndexPath:indexPath.row];
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tapGestureAction {
    if (!self.isGestureEnable) return;
    [self dismissSheetControllerWithAnimated:YES completionHandler:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return NO;
    }
    return YES;
}
#pragma mark - lazy load
#pragma mark

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LYScreenHeight, LYScreenWidth, MIN(LYScreenHeight * 2 / 3, self.dataSource.count * LYSheetRowHeight)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LYSheetCell class] forCellReuseIdentifier:LYSheetControllerStyleDefault];
        [_tableView registerClass:[LYSheetCell class] forCellReuseIdentifier:LYSheetControllerStyleCancel];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
