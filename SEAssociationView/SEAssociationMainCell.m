//
//  SEAssociationMainCell.m
//  SEAssociationMenu
//
//  Created by Joshua on 15/8/19.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SEAssociationMainCell.h"

@implementation SEAssociationMainCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SEAssociationMainCell";
    SEAssociationMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SEAssociationMainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIImageView *bg = [[UIImageView alloc] init];
//        bg.image = [UIImage imageNamed:@"SEAssociationView.assets.bundle/bg_associationview_main"];
//        self.backgroundView = bg;
//        
//        UIImageView *selectedBg = [[UIImageView alloc] init];
//        selectedBg.image = [UIImage imageNamed:@"SEAssociationView.assets.bundle/bg_associationview_main_selected"];
//        self.selectedBackgroundView = selectedBg;
    }
    return self;
}

@end
