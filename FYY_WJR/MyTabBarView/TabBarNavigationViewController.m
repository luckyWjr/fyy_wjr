//
//  TabBarNavigationViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/23.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "TabBarNavigationViewController.h"

@interface TabBarNavigationViewController ()

@end

@implementation TabBarNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//push的时候判断到子控制器的数量。当大于零时隐藏BottomBar 也就是UITabBarController 的tababar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
