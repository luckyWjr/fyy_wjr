//
//  MyOnlyImgViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyOnlyImgPopupViewController.h"
#import "UIView+SDExtension.h"

@interface MyOnlyImgPopupViewController ()

@end

@implementation MyOnlyImgPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setContentView{
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    imgView.image = self.img;
    [self.contentView addSubview:imgView];
}

@end
