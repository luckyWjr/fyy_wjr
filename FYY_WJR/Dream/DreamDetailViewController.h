//
//  DreamDetailViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/5/4.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamModel.h"
#import "AddDreamViewController.h"

@protocol DreamChangedDelegate <NSObject>

@optional

- (void)Dreamchanged;

@end

@interface DreamDetailViewController : UIViewController <EditDreamDelegate>

@property (nonatomic, weak) id<DreamChangedDelegate> changedDelegate;

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)DreamModel *dreamModel;

@end
