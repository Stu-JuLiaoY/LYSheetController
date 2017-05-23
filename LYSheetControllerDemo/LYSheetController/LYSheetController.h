//
//  LYSheetController.h
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSheetProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LYSheetControllerStyle) {
    LYSheetControllerStylePlain,
    LYSheetControllerStyleGroup
};

@interface LYSheetController : UIViewController
/**
  defalut is 50.f
 */
@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, weak) id<LYSheetControllerDelegate> delegate;

/**
 sheet controller data source
 */
@property (nonatomic, copy, nullable) NSArray *dataSource;

/**
 separator color
 */
@property (nonatomic, strong) UIColor *sheetSeparatorColor;

/**
 sheet background color
 */
@property (nonatomic, strong) UIColor *sheetBackgroundColor;

/**
 tap background view(not sheet view) dismiss. default is YES, if YES, - dismissSheetController: method `animated` always is YES whatever you set animated YES or NO.
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
 when dismissWhenSelected is YES ， callback after selected cell。
 */
@property (nonatomic, copy) void(^dismissHandler)(BOOL);

/**
 initialization

 @param dataSource datasource
 @return instance object
 */
- (instancetype)initWithDataSource:(NSArray * _Nullable)dataSource;

/**
 reload sheet
 */
- (void)reloadSheet;

/**
 regist cell
 default is LYSheetCell, inherit `LYSheetCell` protocol to custom.
 @param cell custom cell
 @param style cell's style
 */
- (void)registSheetControllerCell:(Class<LYSheetCell>)cell forStyle:(LYSheetStyle)style;

/**
  show sheet

 @param animated animated
 @param completionHandler completionHandler
 */
- (void)showSheetControllerWithAnimated:(BOOL)animated completionHandler:(void(^ __nullable)(BOOL success))completionHandler;

/**
 remove sheet

 @param animated animated
 @param completionHandler completionHandler
 */
- (void)dismissSheetControllerWithAnimated:(BOOL)animated completionHandler:(void(^ __nullable)(BOOL success))completionHandler;

@end

NS_ASSUME_NONNULL_END
