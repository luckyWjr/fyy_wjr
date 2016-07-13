//
//  MyTableViewGroupModel.h
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyTableViewGroupModel : NSObject

/** TableView每组的数据 */
@property(nonatomic, strong) NSMutableArray *items;

/** group 唯一标准 */
@property(nonatomic, copy) NSString* index;

/** TableView头部高度 */
@property(nonatomic, assign) CGFloat headerHeight;

/** TableView头部文本 */
@property(nonatomic, copy) NSString *header;

/** TableView底部高度 */
@property(nonatomic, assign) CGFloat footerHeight;

/** TableView底部文本 */
@property(nonatomic, copy) NSString *footer;

/** TableView头部视图 */
@property(nonatomic, strong) UIView *headerView;

/** TableView底部视图 */
@property(nonatomic, strong) UIView *footerrView;

@end
