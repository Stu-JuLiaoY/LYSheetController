//
//  LYSheetProtocal.h
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 2017/5/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#ifndef LYSheetProtocal_h
#define LYSheetProtocal_h

@class LYSheetProtocol;
@class LYSheetController;

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, LYSheetStyle) {
    LYSheetStyleDefault = 1 << 0,
    LYSheetStyleCancel  = 1 << 1
};

#pragma mark - LYSheetControllerDelegate
#pragma mark

@protocol LYSheetControllerDelegate <NSObject>

@optional

- (void)sheetController:(LYSheetController *)sheetController didSelectRowAtIndexPath:(NSInteger)indexPath;

- (CGFloat)headerHeightForSheetContoller:(LYSheetController *)sheetController;

- (UIView *)headerViewForSheetContoller:(LYSheetController *)sheetController;

@end

#pragma mark - LYSheetModel
#pragma mark

@protocol LYSheetModel <NSObject>

@required

/**
 sheet style, required.
 */
@property (nonatomic, assign) LYSheetStyle sheetStyle;

@optional

/**
 sheet action
 */
@property (nonatomic, assign, nullable) SEL sheetAction;

/**
 sheet title
 */
@property (nonatomic, copy, nullable) NSString *sheetTitle;

/**
 sheet image;
 */
@property (nonatomic, strong, nullable) UIImage *sheetImage;

- (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(nullable SEL)aSel;

- (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(nullable SEL)aSel style:(LYSheetStyle)aStyle;

@end

#pragma mark - LYSheetCell
#pragma mark

@protocol LYSheetCell <NSObject>

@optional

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;

- (void)bindModel:(id<LYSheetModel>)model;

@end

NS_ASSUME_NONNULL_END

#endif /* LYSheetProtocal_h */
