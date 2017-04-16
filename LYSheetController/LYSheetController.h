//
//  LYSheetController.h
//  NicelandCenterControl
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSheetModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LYSheetController;
@class LYSheetCell;

@protocol LYSheetControllerDelegate <NSObject>

- (void)sheetController:(LYSheetController *)sheetController didSelectRowAtIndexPath:(NSInteger)indexPath;

@end

@interface LYSheetController : UIViewController
/**
  defalut is 50.f
 */
@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, weak) id<LYSheetControllerDelegate> delegate;

/**
 sheet controller data source
 */
@property (nonatomic, copy, nullable) NSArray<__kindof LYSheetModel *> *dataSource;

/**
 separator color
 */
@property (nonatomic, strong) UIColor *sheetSeparatorColor;

/**
 sheet background color
 */
@property (nonatomic, strong) UIColor *sheetBackgroundColor;

/**
 tap view dismiss. default is YES, if YES, - dismissSheetController: method `animated` always is YES whatever you set animated YES or NO.
 */
@property (nonatomic, assign, getter=isGestureEnable) BOOL gestureEnable;

/**
 sheet view max height. defalut is screen height * 2 / 3;
 */
@property (nonatomic, assign) CGFloat maxSheetHeight;

/**
 auto set scrollEnable value.
 when cell's height * cell's count > max sheet height , scrollEnable = YES, otherwise scrollEnable = NO.
 */
@property (nonatomic, assign, getter=isScrollEnableAuto) BOOL scrollEnableAuto;

/**
 default is auto
 */
@property (nonatomic, assign, getter=isScrollEnable) BOOL scrollEnable;

/**
 dismiss the sheet controller when selected one sheet cell, default is YES.
 */
@property (nonatomic, assign, getter=isDismissWhenSelected) BOOL dismissWhenSelected;

/**
 当 dismissWhenSelected 为 YES 时，选择某个 cell 后，sheet 消失后的回调。
 */
@property (nonatomic, copy) void(^dismissHandler)(BOOL);
/**
 初始化方式

 @param dataSource 数据源
 @return instance object
 */
- (instancetype)initWithDataSource:(NSArray<__kindof LYSheetModel *> * _Nullable)dataSource;

/**
 刷新 sheet
 */
- (void)reloadSheet;

/**
 注册 cell
 default is LYSheetCell, subclass LYSheetCell to custom.
 @param cell 要注册的 cell
 @param style cell's style
 */
- (void)registSheetControllerCell:(__kindof LYSheetCell *)cell forStyle:(LYSheetStyle)style;

/**
  展示 sheet

 @param animated animated
 @param completionHandler completionHandler
 */
- (void)showSheetControllerWithAnimated:(BOOL)animated completionHandler:(void(^ __nullable)(BOOL success))completionHandler;

/**
 移除 sheet

 @param animated animated
 @param completionHandler completionHandler
 */
- (void)dismissSheetControllerWithAnimated:(BOOL)animated completionHandler:(void(^ __nullable)(BOOL success))completionHandler;

@end

NS_ASSUME_NONNULL_END
