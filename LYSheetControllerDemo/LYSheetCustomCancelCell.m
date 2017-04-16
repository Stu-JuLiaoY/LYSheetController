//
//  LYSheetCustomCancelCell.m
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 17/4/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetCustomCancelCell.h"
#import "LYSheetCustomModel.h"

@interface LYSheetCustomCancelCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *rightView;

@end

@implementation LYSheetCustomCancelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    [self addSubview:self.rightView];
    [self addSubview:self.titleLabel];
}

- (void)bindModel:(LYSheetCustomModel *)model {
    self.titleLabel.text = model.sheetTitle;
    self.rightView.image = model.image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width - 150, 50);
        _titleLabel.font = [UIFont systemFontOfSize:19];
    }
    return _titleLabel;
}

- (UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [UIImageView new];
        _rightView.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 50);
        _rightView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightView;
}

@end
