//
//  DiaryModel.m
//  FYY_WJR
//
//  Created by wjr on 16/6/2.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "DiaryModel.h"

@implementation DiaryModel

+(instancetype)initWithYear:(NSString*)year Msg:(NSString*)msg{
    DiaryModel* model = [[DiaryModel alloc]init];
    model.year = year;
    model.msg = msg;
    return model;
}

@end
