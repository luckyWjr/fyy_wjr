//
//  DreamModel.m
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "DreamModel.h"

@implementation DreamModel

//将某个对象写入文件时会调用
- (void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.isFinish forKey:@"isFinish"];
    [encoder encodeObject:self.detail forKey:@"detail"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.imgPath forKey:@"imgPath"];
}

//解析对象时调用
- (id)initWithCoder:(NSCoder*)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.isFinish = [decoder decodeObjectForKey:@"isFinish"];
        self.detail = [decoder decodeObjectForKey:@"detail"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.imgPath = [decoder decodeObjectForKey:@"imgPath"];
    }
    return self;
}

@end
