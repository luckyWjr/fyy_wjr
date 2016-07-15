//
//  MyTabBarViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/4/28.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "TabBarButton.h"
#import "TabBarNavigationViewController.h"
#import "DreamTableViewController.h"
#import "IndexViewController.h"
#import "UIView+SDExtension.h"
#import "XYZViewController.h"

@interface MyTabBarViewController ()
    
@property(nonatomic, strong) UIImageView* tabBarView;//自定义的覆盖原先的tarbar的控件
    
@property(nonatomic, weak) TabBarButton* previousBtn;//记录前一次选中的按钮

@end

@implementation MyTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    self.selectedIndex = 1;
    
    self.tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    self.tabBarView.userInteractionEnabled = YES;
//    self.tabBarView.backgroundColor = [UIColor blackColor];

    [self.tabBar addSubview:self.tabBarView];
    
    XYZViewController * first = [[XYZViewController alloc]init];
    TabBarNavigationViewController * navi1 = [[TabBarNavigationViewController alloc]initWithRootViewController:first];
    
    IndexViewController * indexController = [[IndexViewController alloc]init];
    TabBarNavigationViewController * navi2 = [[TabBarNavigationViewController alloc]initWithRootViewController:indexController];
    
    DreamTableViewController * dreamController = [[DreamTableViewController alloc]init];
    TabBarNavigationViewController * navi3 = [[TabBarNavigationViewController alloc]initWithRootViewController:dreamController];
    
    self.viewControllers = [NSArray arrayWithObjects: navi1, navi2, navi3, nil];
    
    [self creatButtonWithNormalName:@"cat_gray" andSelectName:@"cat_black" andTitle:@"嘿嘿" andIndex:0];
    [self creatButtonWithNormalName:@"rabbit_gray" andSelectName:@"rabbit_black" andTitle:@"首页" andIndex:1];
    [self creatButtonWithNormalName:@"heart_gray" andSelectName:@"heart_black" andTitle:@"愿望" andIndex:2];
    
    TabBarButton * button = self.tabBarView.subviews[1];
    [self changeViewController:button];
}

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(NSInteger)index{
    TabBarButton * customButton = [TabBarButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = self.tabBarView.width / 3;
    CGFloat buttonH = self.tabBarView.height;
    
    customButton.frame = CGRectMake(buttonW * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [self.tabBarView addSubview:customButton];
    self.previousBtn.selected = YES;
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(TabBarButton *)sender{
    if(self.selectedIndex != sender.tag){
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        self.previousBtn.selected = ! self.previousBtn.selected;
        self.previousBtn = sender;
        self.previousBtn.selected = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    for (UIView* obj in self.tabBar.subviews) {
        if (obj != self.tabBarView) {
            [obj removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
