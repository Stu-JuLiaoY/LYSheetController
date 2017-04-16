//
//  LYSheetModel.m
//  NicelandCenterControl
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetModel.h"

@implementation LYSheetModel

+ (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(SEL)aSel {
    return [self initWithSheetTitle:aTitle selector:aSel style:kLYSheetStyleDefault];
}

+ (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(SEL)aSel style:(LYSheetStyle)aStyle {
    LYSheetModel *model = [[LYSheetModel alloc] init];
    model.sheetTitle = aTitle;
    model.sheetAction = aSel;
    model.style = aStyle;
    return model;
}
@end
