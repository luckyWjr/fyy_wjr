//
//  MsgTableViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyTableViewController.h"

typedef enum {
    MsgTypeFood,
    MsgTypeToiletry,
    MsgTypeLove,
    MsgTypeFestival,
} MsgType;

@interface MsgTableViewController : MyTableViewController

@property (nonatomic, assign) MsgType msgType;
@property (nonatomic, assign) int index;

@end
