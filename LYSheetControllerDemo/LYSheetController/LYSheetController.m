//
//  LYSheetController.m
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetController.h"
#import "UIViewController+LYActive.h"

#define LYScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define LYScreenHeight        [[UIScreen mainScreen] bounds].size.height

static NSString * const LYSheetControllerStyleDefault = @"LYSheetControllerStyleDefault";
static NSString * const LYSheetControllerStyleCancel = @"LYSheetControllerStyleCancel";
static const NSTimeInterval animationDuration = 0.2;
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

#pragma mark - private
#pragma mark

/// default config
- (void)defaultConfig {
    self.presenting = NO;
    self.gestureEnable = YES;
    self.scrollEnableAuto = YES;
    self.dismissWhenSelected = YES;
    self.rowHeight = LYSheetRowHeight;
    self.maxSheetHeight = LYScreenHeight * 2 / 3;
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}

- (void)tableViewScrollEnable {
    if (!self.scrollEnableAuto) {
        self.tableView.scrollEnabled = self.scrollEnable;
        return;
    }
    if ([self tableViewHeight] > self.maxSheetHeight) {
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableView.scrollEnabled = NO;
    }
}

- (CGFloat)tableViewHeight {
    return self.dataSource.count * self.rowHeight + [self tableView:self.tableView heightForHeaderInSection:0];
}

#pragma mark - public
#pragma mark
- (instancetype)initWithDataSource:(NSArray *)dataSource {
    self.dataSource = dataSource;
    return [self init];
}

- (void)registSheetControllerCell:(Class<LYSheetCell>)cell forStyle:(LYSheetStyle)style {
    if (style == LYSheetStyleDefault) {
        [self.tableView registerClass:cell forCellReuseIdentifier:LYSheetControllerStyleDefault];
    } else if (style == LYSheetStyleCancel) {
        [self.tableView registerClass:cell forCellReuseIdentifier:LYSheetControllerStyleCancel];
    } else if (style == (LYSheetStyleCancel | LYSheetStyleDefault)) {
        [self.tableView registerClass:cell forCellReuseIdentifier:LYSheetControllerStyleDefault];
        [self.tableView registerClass:cell forCellReuseIdentifier:LYSheetControllerStyleCancel];
    }
}

- (void)reloadSheet {
    [self.tableView reloadData];
}

- (void)showSheetControllerWithAnimated:(BOOL)animated completionHandler:(void (^ _Nullable)(BOOL))completionHandler {
    if (self.isPresenting) return;  // if current sheet view is showing, do nothing.
    [self tableViewScrollEnable];   // Determine whether the tableView can scroll
    UIViewController *active = [UIViewController activeViewController]; // Get the top of the navigation stack
    if (active && [active isKindOfClass:[UIViewController class]]) {
        [active presentViewController:self animated:NO completion:^{    // cancel present animation.
            if (animated) {
                [UIView animateWithDuration:animationDuration animations:^{  // add tableview animation.
                    self.tableView.frame = CGRectMake(0, LYScreenHeight - MIN(self.maxSheetHeight, [self tableViewHeight]), LYScreenWidth, MIN(self.maxSheetHeight, [self tableViewHeight]));
                }];
            } else {
                self.tableView.frame = CGRectMake(0, LYScreenHeight - MIN(self.maxSheetHeight, [self tableViewHeight]), LYScreenWidth, MIN(self.maxSheetHeight, [self tableViewHeight]));
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
        self.tableView.frame = CGRectMake(0, LYScreenHeight, LYScreenWidth, MIN(self.maxSheetHeight, [self tableViewHeight]));
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

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    [self tableViewScrollEnable];
}

- (void)setScrollEnableAuto:(BOOL)scrollEnableAuto {
    _scrollEnableAuto = scrollEnableAuto;
    [self tableViewScrollEnable];
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
    UITableViewCell<LYSheetCell> *cell = nil;
    id<LYSheetModel> model = self.dataSource[indexPath.row];
    NSAssert(model.sheetStyle, @"You must specify a type");
    if (model.sheetStyle == LYSheetStyleDefault) {
        cell = [tableView dequeueReusableCellWithIdentifier:LYSheetControllerStyleDefault forIndexPath:indexPath];
    }
    if (model.sheetStyle == LYSheetStyleCancel) {
        cell = [tableView dequeueReusableCellWithIdentifier:LYSheetControllerStyleCancel forIndexPath:indexPath];
    }

    if ([cell respondsToSelector:@selector(bindModel:)]) {
        [cell bindModel:model];
    }
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

/// full screen.
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerHeightForSheetContoller:)]) {
        return [self.delegate headerHeightForSheetContoller:self];
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewForSheetContoller:)]) {
        return [self.delegate headerViewForSheetContoller:self];
    }
    return nil;
}

- (void)tapGestureAction {
    if (!self.isGestureEnable) return;
    [self dismissSheetControllerWithAnimated:YES completionHandler:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // if touch point location in tableview , not response tap gesture.
    CGPoint location = [touch locationInView:self.tableView];
    if (CGRectContainsPoint(self.tableView.bounds, location)) {
        return  NO;
    }
    return YES;
}
#pragma mark - lazy load
#pragma mark

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LYScreenHeight, LYScreenWidth, MIN(LYScreenHeight * 2 / 3, 0)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
