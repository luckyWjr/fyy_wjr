//
//  DreamModelTool.m
//  FYY_WJR
//
//  Created by wjr on 16/5/5.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "ModelTool.h"
#import "MyTools.h"
#import "DreamModel.h"

@interface ModelTool()

@property(strong, nonatomic) NSMutableArray* modelArr;
@property(copy, nonatomic) NSString* filePath;

@end

@implementation ModelTool

//+ (ModelTool *)singleton {
//    static ModelTool *_sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedInstance = [[ModelTool alloc] init];
//    });
//    return _sharedInstance;
//}
-(instancetype)initByType:(ModelType)type{
    self = [super init];
    if (self) {
        self.filePath = [self getFilePathByType:type];
        if (!self.modelArr) {
            self.modelArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
            if (self.modelArr == nil) {
                self.modelArr = [NSMutableArray array];
            }
        }
    }
    return self;
}

-(NSMutableArray*)getModelArr{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
}

-(BOOL)addNewModel:(id)model{
    [self.modelArr addObject:model];
    return [NSKeyedArchiver archiveRootObject:self.modelArr toFile:self.filePath];
}

-(BOOL)editModel:(NSInteger)index model:(DreamModel*)model{
    [self.modelArr replaceObjectAtIndex:index withObject:model];
    return [NSKeyedArchiver archiveRootObject:self.modelArr toFile:self.filePath];
}

-(BOOL)removeModel:(NSInteger)index{
    [self.modelArr removeObjectAtIndex:index];
    return [NSKeyedArchiver archiveRootObject:self.modelArr toFile:self.filePath];
}

- (NSString*)getFilePathByType:(ModelType)type{
    if(type == ModelTypeDream){
        return DREAM_FILR_PATH;
    }
    else if(type == ModelTypeDate){
        return DATE_FILR_PATH;
    }
    else{
        return nil;
    }
}

@end
