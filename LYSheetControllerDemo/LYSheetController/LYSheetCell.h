//
//  LYSheetCell.h
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSheetModel.h"

@interface LYSheetCell : UITableViewCell

- (void)bindModel:(__kindof LYSheetModel *)model;

@end
