//
//  MyTableViewGroupModel.m
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyTableViewGroupModel.h"

@implementation MyTableViewGroupModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc]init];
    }
    return self;
}
@end
