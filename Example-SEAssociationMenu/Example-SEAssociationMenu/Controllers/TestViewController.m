//
//  ViewController.m
//  Example-SEAssociationMenu
//
//  Created by Joshua on 15/8/19.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "TestViewController.h"
#import "SEAssociationView.h"
#import "TestTableViewCell.h"

@interface TestViewController () <SEAssociationViewDataSource, SEAssociationViewDelegate>
@property (strong, nonatomic) NSArray *categories;
@end

@implementation TestViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configueData];
    [self configueViews];
    [self configueNotifications];
}

- (void)dealloc {
    
}

#pragma mark - configues
- (void)configueData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
    self.categories = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@", self.categories);
}

- (void)configueViews {
    SEAssociationView *associationView = [SEAssociationView associationView];
    associationView.dataSource = self;
    associationView.delegate = self;
    [self.view addSubview:associationView];
    
    associationView.frame = (CGRect){ 0, 20, self.view.frame.size.width, self.view.frame.size.height };
    
    associationView.mainTableViewSeparatorStyle = UITableViewCellSeparatorStyleNone;
    associationView.subTableViewSeparatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configueNotifications {
    
}

#pragma mark - SEAssociationViewDataSource
- (NSInteger)numberOfRowsInMainTable:(SEAssociationView *)associationView {
    return self.categories.count;
}

- (NSString *)associationView:(SEAssociationView *)associationView titleInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.categories[indexPath.row] objectForKey:@"name"];
    return title;
}

- (NSArray *)associationView:(SEAssociationView *)associationView subTitlesForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subData = [self.categories[indexPath.row] objectForKey:@"subcategories"];
    return subData;
}

- (UIImage *)associationView:(SEAssociationView *)associationView backgroundImageForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *bg = [UIImage imageNamed:@"bg_associationview_main"];
    return bg;
}

- (UIImage *)associationView:(SEAssociationView *)associationView selectedBackgroundImageForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *bg = [UIImage imageNamed:@"bg_associationview_main_selected"];
    return bg;
}

- (UIImage *)associationView:(SEAssociationView *)associationView backgroundImageForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *bg = [UIImage imageNamed:@"bg_associationview_sub"];
    return bg;
}

- (UIImage *)associationView:(SEAssociationView *)associationView selectedBackgroundImageForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *bg = [UIImage imageNamed:@"bg_associationview_sub_selected"];
    return bg;
}

- (UIImage *)associationView:(SEAssociationView *)associationView iconForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *icon = [UIImage imageNamed:@"pizza"];
    return icon;
}

- (UIImage *)associationView:(SEAssociationView *)associationView selectedIconForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *icon = [UIImage imageNamed:@"pizza_selected"];
    return icon;
}

//- (Class)classForSubTable:(SEAssociationView *)associationView {
//    return [TestTableViewCell class];
//}
//
//- (id<SEAssociationViewSubTableModel>)associationView:(SEAssociationView *)associationView subModelInMainTableAtIndexPath:(NSIndexPath *)mIndexPath inSubTableAtIndexPath:(NSIndexPath *)sIndexPath {
//    TestCellModel *model = [[TestCellModel alloc] init];
//    model.title = [NSString stringWithFormat:@"食品 %02ld", sIndexPath.row];
//    return model;
//}

#pragma mark - SEAssociationViewDataSource
//- (CGFloat)associationView:(SEAssociationView *)associationView heightForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

#pragma mark - actions

#pragma mark - private methods

#pragma mark - lazy load

@end
