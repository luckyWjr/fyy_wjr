//
//  DateModel.m
//  Calendar
//
//  Created by macairwkcao on 15/12/18.
//  Copyright © 2015年 CWK. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel

//将某个对象写入文件时会调用
- (void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:[NSString stringWithFormat:@"%ld", (long)self.day] forKey:@"day"];
    [encoder encodeObject:[NSString stringWithFormat:@"%ld", (long)self.month] forKey:@"month"];
    [encoder encodeObject:[NSString stringWithFormat:@"%ld", (long)self.year] forKey:@"year"];
    [encoder encodeObject:[NSString stringWithFormat:@"%ld", (long)self.weekday] forKey:@"weekday"];
    [encoder encodeObject:self.lunarDay forKey:@"lunarDay"];
}

//解析对象时调用
- (id)initWithCoder:(NSCoder*)decoder {
    if (self = [super init]) {
        self.day = [[decoder decodeObjectForKey:@"day"] integerValue];
        self.month = [[decoder decodeObjectForKey:@"month"] integerValue];
        self.year = [[decoder decodeObjectForKey:@"year"] integerValue];
        self.weekday = [[decoder decodeObjectForKey:@"weekday"] integerValue];
        self.lunarDay = [decoder decodeObjectForKey:@"lunarDay"];
    }
    return self;
}

@end
