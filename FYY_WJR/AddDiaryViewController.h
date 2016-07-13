//
//  AddDiaryViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/6/27.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryModel.h"

@interface AddDiaryViewController : UIViewController

@property (nonatomic,copy) void(^addNewDiary)(DiaryModel* model);

@end