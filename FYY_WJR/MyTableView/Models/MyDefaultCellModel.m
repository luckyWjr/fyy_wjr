//
//  MyDefaultCellModel.m
//  FYY_WJR
//
//  Created by wjr on 16/5/25.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyDefaultCellModel.h"

@implementation MyDefaultCellModel

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title {
    MyDefaultCellModel *item = [[self alloc] init];
    
    item.icon = icon;
    item.title = title;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title {
    MyDefaultCellModel *item = [[self alloc] init];
    
    item.icon = nil;
    item.title = title;
    
    return item;
}

@end
