//
//  TestTableViewCell.m
//  Example-SEAssociationMenu
//
//  Created by Joshua on 15/8/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestCellModel

- (NSDictionary *)displayDictionary {
    TestCellModel *model = [TestCellModel new];
    model.title = self.title;
    model.icon = self.icon;
    return @{ @"testCellModel": model };
}

@end

@interface TestTableViewCell ()
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIImageView *iconView;
@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        title.frame = (CGRect){ 20, 10, self.contentView.frame.size.width, 20 };
        self.titleLabel = title;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        imageView.frame = (CGRect){ 20, self.titleLabel.frame.size.height + 20, 44, 44 };
        self.iconView = imageView;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTestCellModel:(TestCellModel *)testCellModel {
    _testCellModel = testCellModel;
    
    self.titleLabel.text = testCellModel.title;
    self.iconView.image = [UIImage imageNamed:testCellModel.icon];
}

@end
