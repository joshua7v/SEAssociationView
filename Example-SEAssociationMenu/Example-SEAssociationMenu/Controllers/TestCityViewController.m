//
//  TestCityViewController.m
//  Example-SEAssociationMenu
//
//  Created by Joshua on 15/8/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "TestCityViewController.h"
#import "SEAssociationView.h"

@interface TestCityViewController () <SEAssociationViewDataSource>
@property (strong, nonatomic) NSArray *presentingRegions;
@property (strong, nonatomic) NSArray *suzhouRegions;
@property (strong, nonatomic) NSArray *guangzhouRegions;
@property (strong, nonatomic) NSArray *tianjinRegions;
@property (weak, nonatomic) SEAssociationView *associationView;
@end

@implementation TestCityViewController

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
    NSArray *cities = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@", self.cities);
    
    self.guangzhouRegions = [cities[0] objectForKey:@"regions"];
    self.suzhouRegions = [cities[1] objectForKey:@"regions"];
    self.tianjinRegions = [cities[2] objectForKey:@"regions"];
}

- (void)configueViews {
    SEAssociationView *associationView = [SEAssociationView associationView];
    associationView.frame = (CGRect){ 0, 20, self.view.frame.size.width, 400 };
    associationView.dataSource = self;
    [self.view addSubview:associationView];
    self.associationView = associationView;
    
    UIButton *suzhou = [[UIButton alloc] init];
    suzhou.tag = 1;
    suzhou.frame = (CGRect){ 20, CGRectGetMaxY(associationView.frame) + 20, 44, 44 };
    [self.view addSubview:suzhou];
    [suzhou setTitle:@"苏州" forState:UIControlStateNormal];
    [suzhou setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [suzhou setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIButton *guangzhou = [[UIButton alloc] init];
    guangzhou.tag = 2;
    guangzhou.frame = (CGRect){ CGRectGetMaxX(suzhou.frame) + 20, CGRectGetMaxY(associationView.frame) + 20, 44, 44 };
    [self.view addSubview:guangzhou];
    [guangzhou setTitle:@"广州" forState:UIControlStateNormal];
    [guangzhou setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [guangzhou setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIButton *tianjin = [[UIButton alloc] init];
    tianjin.tag = 3;
    tianjin.frame = (CGRect){ CGRectGetMaxX(guangzhou.frame) + 20, CGRectGetMaxY(associationView.frame) + 20, 44, 44 };
    [self.view addSubview:tianjin];
    [tianjin setTitle:@"天津" forState:UIControlStateNormal];
    [tianjin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tianjin setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [suzhou addTarget:self action:@selector(handleSwitchCity:) forControlEvents:UIControlEventTouchUpInside];
    [guangzhou addTarget:self action:@selector(handleSwitchCity:) forControlEvents:UIControlEventTouchUpInside];
    [tianjin addTarget:self action:@selector(handleSwitchCity:) forControlEvents:UIControlEventTouchUpInside];
    
    [self handleSwitchCity:suzhou];
}

- (void)configueNotifications {
    
}

#pragma mark - SEAssociationViewDataSource
- (NSInteger)numberOfRowsInMainTable:(SEAssociationView *)associationView {
    return self.presentingRegions.count;
}

- (NSString *)associationView:(SEAssociationView *)associationView titleInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    return [self.presentingRegions[indexPath.row] objectForKey:@"name"];
}

- (NSArray *)associationView:(SEAssociationView *)associationView subTitlesForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    return [self.presentingRegions[indexPath.row] objectForKey:@"subregions"];
}

#pragma mark - actions
- (void)handleSwitchCity:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.presentingRegions = self.suzhouRegions;
            [self.associationView reloadData];
            break;
        case 2:
            self.presentingRegions = self.guangzhouRegions;
            [self.associationView reloadData];
            break;
        case 3:
            self.presentingRegions = self.tianjinRegions;
            [self.associationView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - private methods

#pragma mark - lazy load

@end
