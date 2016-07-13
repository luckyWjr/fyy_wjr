//
//  DreamTableViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddDreamViewController.h"
#import "DreamDetailViewController.h"

@interface DreamTableViewController : UITableViewController <AddDreamDelegate, DreamChangedDelegate>

@end
