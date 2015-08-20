//
//  TestTableViewCell.h
//  Example-SEAssociationMenu
//
//  Created by Joshua on 15/8/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEAssociationView.h"

@interface TestCellModel : NSObject <SEAssociationViewModel>
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *icon;
@end

@interface TestTableViewCell : UITableViewCell
@property (strong, nonatomic) TestCellModel *testCellModel;
@end
