//
//  SEAssociationSubCell.m
//  SEAssociationMenu
//
//  Created by Joshua on 15/8/19.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SEAssociationSubCell.h"

@implementation SEAssociationSubCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SEAssociationSubCell";
    SEAssociationSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SEAssociationSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIImageView *bg = [[UIImageView alloc] init];
//        bg.image = [UIImage imageNamed:@"SEAssociationView.assets.bundle/bg_associationview_sub"];
//        self.backgroundView = bg;
//        
//        UIImageView *selectedBg = [[UIImageView alloc] init];
//        selectedBg.image = [UIImage imageNamed:@"SEAssociationView.assets.bundle/bg_associationview_sub_selected"];
//        self.selectedBackgroundView = selectedBg;
    }
    return self;
}

@end
