//
//  MsgTableViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyTableViewController.h"

typedef NS_ENUM(NSInteger, MsgType) {
    MsgTypeFood,
    MsgTypeToiletry,
    MsgTypeLove,
    MsgTypeFestival,
};

@interface MsgTableViewController : MyTableViewController

@property (nonatomic, assign) MsgType msgType;
@property (nonatomic, assign) NSInteger index;

@end
