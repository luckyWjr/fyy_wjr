//
//  DiaryModel.h
//  FYY_WJR
//
//  Created by wjr on 16/6/2.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryModel : NSObject

@property(nonatomic, copy) NSString* year;
@property(nonatomic, copy) NSString* month;
@property(nonatomic, copy) NSString* day;
@property(nonatomic, copy) NSString* msg;

+(instancetype)initWithYear:(NSString*)year Msg:(NSString*)msg;

@end
