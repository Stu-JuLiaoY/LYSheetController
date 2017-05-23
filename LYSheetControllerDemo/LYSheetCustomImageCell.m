//
//  LYSheetCustomImageCell.m
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LYSheetCustomImageCell.h"
@implementation LYSheetCustomImageCell

@synthesize titleLabel = _titleLabel;
@synthesize imageView = _imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 50, 50);
    self.titleLabel.frame = CGRectMake(50, 0, self.self.frame.size.width, self.frame.size.height);
}

- (void)bindModel:(id<LYSheetModel>)model {
    
    self.titleLabel.text = model.sheetTitle;
    self.imageView.image = model.sheetImage;
    
}


@end
