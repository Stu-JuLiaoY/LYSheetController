//
//  LYSheetModel.h
//  NicelandCenterControl
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, LYSheetStyle) {
    kLYSheetStyleDefault = 1 << 0,
    kLYSheetStyleCancel  = 1 << 1
};

@interface LYSheetModel : NSObject
/**
 sheet action
 */
@property (nonatomic, assign, nullable) SEL sheetAction;

/**
 sheet title
 */
@property (nonatomic, copy) NSString *sheetTitle;

/**
 sheet style
 */
@property (nonatomic, assign) LYSheetStyle style;

/**
 the style default is kLYSheetStyleDefault

 @param aTitle title
 @param aSel action
 @return LYSheetModel object
 */
+ (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(nullable SEL)aSel;

+ (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(nullable SEL)aSel style:(LYSheetStyle)aStyle;

@end

NS_ASSUME_NONNULL_END
