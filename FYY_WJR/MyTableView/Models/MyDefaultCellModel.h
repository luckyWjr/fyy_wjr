//
//  MyDefaultCellModel.h
//  FYY_WJR
//
//  Created by wjr on 16/5/25.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyDefaultCellModel : NSObject

/** cell 唯一标准 */
@property(nonatomic, copy) NSString* index;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** cell文本 */
@property(nonatomic, copy) NSString *title;

/** cell图标 */
@property(nonatomic, copy) NSString *icon;

/** cell子文本 */
@property(nonatomic, copy) NSString *subTitle;

/** cell全部自定义 */
@property(atomic, strong) UIView *contentView;

@property(nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

/** 使用block保存一段功能，在恰当的时候调用 */
//@property(nonatomic, copy) CFSettingItemOpration opration;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;

@end
