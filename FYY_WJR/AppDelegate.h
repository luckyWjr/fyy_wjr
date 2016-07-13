//
//  AppDelegate.h
//  FYY_WJR
//
//  Created by wjr on 16/4/20.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MyTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong ,nonatomic) MyTabBarViewController * tabBarViewController;

@end

