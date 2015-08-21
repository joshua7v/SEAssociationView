//
//  SEAssociationView.h
//  SEAssociationMenu
//
//  Created by Joshua on 15/8/19.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SEAssociationView;

@protocol SEAssociationViewModel <NSObject>

/**
 *  cell has a value named title, model has a value title, then @{ @"title": self.title } is all right.
 *  if use model, should create a model first, @{ @"cellDataModel": AModel }.
 */
- (NSDictionary *)displayDictionary;

@end

@protocol SEAssociationViewDataSource <NSObject>
/**
 *  return the number of rows in main table (left table)
 */
- (NSInteger)numberOfRowsInMainTable:(SEAssociationView *)associationView;
/**
 *  return the title of that row in main table (left table)
 */
- (NSString *)associationView:(SEAssociationView *)associationView titleInMainTableAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  return the subData array of the row display in sub table
 */
- (NSArray *)associationView:(SEAssociationView *)associationView subTitlesForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the number of rows in sub table (not required)
 */
- (NSInteger)associationView:(SEAssociationView *)associationView numberOfRowsForSubTableInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the icon of the row in main table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView iconForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the selected icon of the row in main table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView selectedIconForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the icon of the row in main table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView iconForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the selected icon of the row in main table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView selectedIconForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the background image of the row in main table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView backgroundImageForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the selected background image of the row in main table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView selectedBackgroundImageForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the background image of the row in sub table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView backgroundImageForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the selected background image of the row in sub table
 */
- (UIImage *)associationView:(SEAssociationView *)associationView selectedBackgroundImageForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  return the model for a specific row in sub table
 */
- (id<SEAssociationViewModel>)associationView:(SEAssociationView *)associationView subModelInMainTableAtIndexPath:(NSIndexPath *)mIndexPath inSubTableAtIndexPath:(NSIndexPath *)sIndexPath;
/**
 *  return the model for a specific row in main table
 */
- (id<SEAssociationViewModel>)associationView:(SEAssociationView *)associationView mainModelAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol SEAssociationViewDelegate <NSObject>

@optional
/**
 *  Called after the user changes the selection
 */
- (void)associationView:(SEAssociationView *)associationView didSelectRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  Called after the user changes the selection
 */
- (void)associationView:(SEAssociationView *)associationView didSelectRowInSubTableAtIndexPath:(NSIndexPath *)sIndexPath inMainTableAtIndexPath:(NSIndexPath *)mIndexPath;
/**
 *  Variable height support
 */
- (CGFloat)associationView:(SEAssociationView *)associationView heightForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  Variable height support
 */
- (CGFloat)associationView:(SEAssociationView *)associationView heightForRowInSubTableAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SEAssociationView : UIView
+ (instancetype)associationView;
@property (weak, nonatomic) id<SEAssociationViewDataSource> dataSource;
@property (weak, nonatomic) id<SEAssociationViewDelegate> delegate;
/**
 *  main table's width = superview's width * widthRadio, default is 0.5
 */
@property (assign, nonatomic) CGFloat widthRadio;

@property (nonatomic) UITableViewCellSeparatorStyle mainTableViewSeparatorStyle;
@property (nonatomic) UITableViewCellSeparatorStyle subTableViewSeparatorStyle;

- (void)registerNib:(UINib *)nib ofMainTableforCellReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib ofSubTableforCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)cellClass ofMainTableforCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)cellClass ofSubTableforCellReuseIdentifier:(NSString *)identifier;
- (void)reloadData;
@end
