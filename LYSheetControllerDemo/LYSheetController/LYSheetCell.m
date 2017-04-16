//
//  LYSheetCell.m
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetCell.h"

@implementation LYSheetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindModel:(__kindof LYSheetModel *)model {
    self.textLabel.text = model.sheetTitle;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    // Subclass handle
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
