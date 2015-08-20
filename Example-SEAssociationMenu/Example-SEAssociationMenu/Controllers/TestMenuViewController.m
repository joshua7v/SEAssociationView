//
//  TestMenuViewController.m
//  Example-SEAssociationMenu
//
//  Created by Joshua on 15/8/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "TestMenuViewController.h"
#import "SEAssociationView.h"
#import "TestTableViewCell.h"

@interface TestMenuViewController () <SEAssociationViewDataSource, SEAssociationViewDelegate>
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *subModels;
@end

@implementation TestMenuViewController

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
    
}

- (void)configueViews {
    SEAssociationView *associationView = [SEAssociationView associationView];
    associationView.frame = (CGRect){ 0, 20, self.view.frame.size.width, 400 };
    associationView.dataSource = self;
    associationView.delegate = self;
    [self.view addSubview:associationView];
    associationView.widthRadio = 0.3;
    
    [associationView registerClass:[TestTableViewCell class] ofSubTableforCellReuseIdentifier:NSStringFromClass([TestTableViewCell class])];
}

- (void)configueNotifications {
    
}

#pragma mark - SEAssociationViewDataSource
- (NSInteger)numberOfRowsInMainTable:(SEAssociationView *)associationView {
    return self.titles.count;
}

- (NSString *)associationView:(SEAssociationView *)associationView titleInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    return self.titles[indexPath.row];
}

- (NSInteger)associationView:(SEAssociationView *)associationView numberOfRowsForSubTableInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    return [self.subModels[indexPath.row] count];
}

- (id<SEAssociationViewModel>)associationView:(SEAssociationView *)associationView subModelInMainTableAtIndexPath:(NSIndexPath *)mIndexPath inSubTableAtIndexPath:(NSIndexPath *)sIndexPath {
    
    return self.subModels[mIndexPath.row][sIndexPath.row];
}

//- (NSArray *)associationView:(SEAssociationView *)associationView subTitlesForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
//    return @[@"hehe"];
//}

- (CGFloat)associationView:(SEAssociationView *)associationView heightForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - actions

#pragma mark - private methods

#pragma mark - lazy load
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"招牌", @"饮料"];
    }
    return _titles;
}

- (NSArray *)subModels {
    if (!_subModels) {
        TestCellModel *model1 = [TestCellModel new];
        model1.title = @"酸辣土豆丝";
        model1.icon = @"food";
        
        TestCellModel *model2 = [TestCellModel new];
        model2.title = @"青椒土豆丝";
        model2.icon = @"pizza";
        
        TestCellModel *model3 = [TestCellModel new];
        model3.title = @"酸辣白菜";
        model3.icon = @"food";
        
        TestCellModel *model4 = [TestCellModel new];
        model4.title = @"蓝色海洋";
        model4.icon = @"pizza";
        
        TestCellModel *model5 = [TestCellModel new];
        model5.title = @"草莓奇缘";
        model5.icon = @"pizza";
        
        _subModels = @[@[model1, model2, model3],
                       @[model4, model5]];
    }
    return _subModels;
}

@end
