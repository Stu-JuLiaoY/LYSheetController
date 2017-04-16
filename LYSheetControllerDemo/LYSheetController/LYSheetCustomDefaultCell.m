//
//  LYSheetTableViewCell.m
//  NicelandCenterControl
//
//  Created by Ju Liaoyuan on 17/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetCustomDefaultCell.h"
#import "LYSheetCustomModel.h"

@interface LYSheetCustomDefaultCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *leftView;

@end

@implementation LYSheetCustomDefaultCell

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
    [self addSubview:self.leftView];
    [self addSubview:self.titleLabel];
}

- (void)bindModel:(LYSheetCustomModel *)model {
    self.titleLabel.text = model.sheetTitle;
    self.leftView.image = model.image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(100, 0, self.frame.size.width - 150, 50);
        _titleLabel.font = [UIFont systemFontOfSize:19];
    }
    return _titleLabel;
}

- (UIImageView *)leftView {
    if (!_leftView) {
        _leftView = [UIImageView new];
        _leftView.frame = CGRectMake(0, 0, 50, 50);
        _leftView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftView;
}

@end
