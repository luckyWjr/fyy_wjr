//
//  DreamModelTool.h
//  FYY_WJR
//
//  Created by wjr on 16/5/5.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamModel.h"

typedef enum{
    ModelTypeDream,
    ModelTypeDate
}ModelType;

@interface ModelTool : NSObject

//+ (ModelTool *)singleton;
-(instancetype)initByType:(ModelType)type;
-(NSMutableArray*)getModelArr;
-(BOOL)addNewModel:(id)date;
-(BOOL)editModel:(NSInteger)index model:(id)model;
-(BOOL)removeModel:(NSInteger)index;
@end
