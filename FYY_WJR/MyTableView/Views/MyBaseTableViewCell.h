//
//  MyTableViewCell.h
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDefaultCellModel.h"

@interface MyBaseTableViewCell : UITableViewCell

/** 模型 */
@property (nonatomic, strong) MyDefaultCellModel *item;

/** cell右边Label字体 */
@property (nonatomic, strong) UIFont *rightLabelFont;

/** cell右边Label字体颜色 */
@property (nonatomic, strong) UIColor *rightLabelFontColor;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
