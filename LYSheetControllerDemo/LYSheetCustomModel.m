//
//  LYSheetCustomModel.m
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 17/4/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetCustomModel.h"

@implementation LYSheetCustomModel

@synthesize sheetTitle = _sheetTitle;
@synthesize sheetAction = _sheetAction;
@synthesize sheetStyle = _sheetStyle;
@synthesize sheetImage = _sheetImage;

- (instancetype)initWithSheetTitle:(NSString *)aTitle selector:(SEL)aSel style:(LYSheetStyle)aStyle{
    self = [super init];
    if (self) {
        self.sheetTitle = aTitle;
        self.sheetAction = aSel;
        self.sheetStyle = aStyle;
    }
    return self;
}



@end
