//
//  LYSheetCustomCell.m
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetCustomTextCell.h"

@implementation LYSheetCustomTextCell

@synthesize titleLabel = _titleLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.self.frame.size.width, self.frame.size.height);
}

- (void)bindModel:(id<LYSheetModel>)model {
    self.titleLabel.text = model.sheetTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
