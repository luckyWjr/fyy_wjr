//
//  MyTableViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewController : UITableViewController

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataList;

/** cell右边Label字体 */
@property (nonatomic, strong) UIFont *rightLabelFont;

/** cell右边Label字体颜色 */
@property (nonatomic, strong) UIColor *rightLabelFontColor;

@end
