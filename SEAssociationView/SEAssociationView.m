//
//  SEAssociationView.m
//  SEAssociationMenu
//
//  Created by Joshua on 15/8/19.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SEAssociationView.h"
#import "SEAssociationMainCell.h"
#import "SEAssociationSubCell.h"

@interface SEAssociationView () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (assign, nonatomic) NSInteger selectedMainRow;
@property (assign, nonatomic) NSInteger selectedMainSection;
@property (assign, nonatomic, getter=isMainNibRegistered) BOOL mainNibRegistered;
@property (assign, nonatomic, getter=isMainClassRegistered) BOOL mainClassRegistered;
@property (assign, nonatomic, getter=isSubNibRegistered) BOOL subNibRegistered;
@property (assign, nonatomic, getter=isSubClassRegistered) BOOL subClassRegistered;
@property (copy, nonatomic) NSString *mainCellId;
@property (copy, nonatomic) NSString *subCellId;
@end

@implementation SEAssociationView

+ (instancetype)associationView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.mainTableView.tableFooterView = [UIView new];
    self.subTableView.tableFooterView = [UIView new];
    
    self.widthRadio = 0.5;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        return [self.dataSource numberOfRowsInMainTable:self];
    } else {
        
        if ([self.dataSource respondsToSelector:@selector(associationView:numberOfRowsForSubTableInMainTableAtIndexPath:)]) {
            return [self.dataSource associationView:self numberOfRowsForSubTableInMainTableAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMainRow inSection:self.selectedMainSection]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(associationView:subTitlesForRowInMainTableAtIndexPath:)]) {
            return [self.dataSource associationView:self subTitlesForRowInMainTableAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMainRow inSection:self.selectedMainSection]].count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        if (self.isMainNibRegistered || self.isMainClassRegistered) {
            cell = [tableView dequeueReusableCellWithIdentifier:self.mainCellId forIndexPath:indexPath];
            
            if ([self.dataSource respondsToSelector:@selector(associationView:mainModelAtIndexPath:)]) {
                id<SEAssociationViewModel> model = [self.dataSource associationView:self mainModelAtIndexPath:indexPath];
                NSDictionary *displayDict = [model displayDictionary];
                [displayDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [cell setValue:obj forKeyPath:key];
                }];
            }
            
            return cell;

        }
        cell = [SEAssociationMainCell cellWithTableView:tableView];
        
        cell.textLabel.text = [self.dataSource associationView:self titleInMainTableAtIndexPath:indexPath];
        
        [self configueMainTable:tableView cell:cell forIndexPath:indexPath];
        
    } else { // sub table
        
        if (self.isSubClassRegistered || self.isSubNibRegistered) {
            cell = [tableView dequeueReusableCellWithIdentifier:self.subCellId forIndexPath:indexPath];

            if ([self.dataSource respondsToSelector:@selector(associationView:subModelInMainTableAtIndexPath:inSubTableAtIndexPath:)]) {
                id<SEAssociationViewModel> model = [self.dataSource associationView:self subModelInMainTableAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMainRow inSection:self.selectedMainSection] inSubTableAtIndexPath:indexPath];
                NSDictionary *displayDict = [model displayDictionary];
                [displayDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [cell setValue:obj forKeyPath:key];
                }];
            }

            return cell;
        }
        
        cell = [SEAssociationSubCell cellWithTableView:tableView];
        
        NSArray *subdata = [self.dataSource associationView:self subTitlesForRowInMainTableAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMainRow inSection:self.selectedMainSection]];
        cell.textLabel.text = subdata[indexPath.row];
        [self configueSubTable:tableView cell:cell forIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        self.selectedMainRow = indexPath.row;
        self.selectedMainSection = indexPath.section;
        [self.subTableView reloadData];
        
        if ([self.delegate respondsToSelector:@selector(associationView:didSelectRowInMainTable:)]) {
            [self.delegate associationView:self didSelectRowInMainTable:indexPath.row];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(associationView:didSelectRowInSubTable:inMainTable:)]) {
            [self.delegate associationView:self didSelectRowInSubTable:indexPath.row inMainTable:self.selectedMainRow];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        if ([self.delegate respondsToSelector:@selector(associationView:heightForRowInMainTableAtIndexPath:)]) {
            return [self.delegate associationView:self heightForRowInMainTableAtIndexPath:indexPath];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(associationView:heightForRowInSubTableAtIndexPath:)]) {
            return [self.delegate associationView:self heightForRowInSubTableAtIndexPath:indexPath];
        }
    }
    return 44;
}

#pragma mark - public
- (void)setMainTableViewSeparatorStyle:(UITableViewCellSeparatorStyle)mainTableViewSeparatorStyle {
    self.mainTableView.separatorStyle = self.mainTableViewSeparatorStyle;
}

- (void)setSubTableViewSeparatorStyle:(UITableViewCellSeparatorStyle)subTableViewSeparatorStyle {
    self.subTableView.separatorStyle = self.subTableViewSeparatorStyle;
}

- (void)setWidthRadio:(CGFloat)widthRadio {
    _widthRadio = widthRadio;
    
    [self.widthConstraint setValue:@(widthRadio) forKeyPath:@"multiplier"];
}

- (void)reloadData {
    [self.mainTableView reloadData];
    [self.subTableView reloadData];
    self.selectedMainRow = 0;
    self.selectedMainSection = 0;
}

- (void)registerNib:(UINib *)nib ofMainTableforCellReuseIdentifier:(NSString *)identifier {
    [self.mainTableView registerNib:nib forCellReuseIdentifier:identifier];
    self.mainNibRegistered = YES;
    self.mainCellId = identifier;
}

- (void)registerNib:(UINib *)nib ofSubTableforCellReuseIdentifier:(NSString *)identifier {
    [self.subTableView registerNib:nib forCellReuseIdentifier:identifier];
    self.subNibRegistered = YES;
    self.subCellId = identifier;
}

- (void)registerClass:(Class)cellClass ofMainTableforCellReuseIdentifier:(NSString *)identifier {
    [self.mainTableView registerClass:cellClass forCellReuseIdentifier:identifier];
    self.mainClassRegistered = YES;
    self.mainCellId = identifier;
}

- (void)registerClass:(Class)cellClass ofSubTableforCellReuseIdentifier:(NSString *)identifier {
    [self.subTableView registerClass:cellClass forCellReuseIdentifier:identifier];
    self.subClassRegistered = YES;
    self.subCellId = identifier;
}

#pragma mark - private
- (void)configueMainTable:(UITableView *)tableView cell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSource respondsToSelector:@selector(associationView:iconForRowInMainTableAtIndexPath:)]) {
        cell.imageView.image = [self.dataSource associationView:self iconForRowInMainTableAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:selectedIconForRowInMainTableAtIndexPath:)]) {
        cell.imageView.highlightedImage = [self.dataSource associationView:self selectedIconForRowInMainTableAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:backgroundImageForRowInMainTableAtIndexPath:)]) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[self.dataSource associationView:self backgroundImageForRowInMainTableAtIndexPath:indexPath]];
        cell.backgroundView = imgV;
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:selectedBackgroundImageForRowInMainTableAtIndexPath:)]) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[self.dataSource associationView:self selectedBackgroundImageForRowInMainTableAtIndexPath:indexPath]];
        cell.selectedBackgroundView = imgV;
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:subTitlesForRowInMainTableAtIndexPath:)]) {
        NSArray *subdata = [self.dataSource associationView:self subTitlesForRowInMainTableAtIndexPath:indexPath];
        if (subdata.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }

}

- (void)configueSubTable:(UITableView *)tableView cell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(associationView:backgroundImageForRowInSubTableAtIndexPath:)]) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[self.dataSource associationView:self backgroundImageForRowInSubTableAtIndexPath:indexPath]];
        cell.backgroundView = imgV;
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:selectedBackgroundImageForRowInSubTableAtIndexPath:)]) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[self.dataSource associationView:self selectedBackgroundImageForRowInSubTableAtIndexPath:indexPath]];
        cell.selectedBackgroundView = imgV;
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:iconForRowInSubTableAtIndexPath:)]) {
        cell.imageView.image = [self.dataSource associationView:self iconForRowInSubTableAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(associationView:selectedIconForRowInSubTableAtIndexPath:)]) {
        cell.imageView.highlightedImage = [self.dataSource associationView:self selectedIconForRowInSubTableAtIndexPath:indexPath];
    }
}

@end
