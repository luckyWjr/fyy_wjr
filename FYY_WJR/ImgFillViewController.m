//
//  ImgFillViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/6/15.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "ImgFillViewController.h"
#import "MyTools.h"

@interface ImgFillViewController ()

@end

@implementation ImgFillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
//    int w = DEVICE_WIDTH, h;
//    if (self.img.size.width / self.img.size.height > w / DEVICE_WIDTH) {
//        if (self.img.size.width < w) {
//            w = self.img.size.width;
//            h = self.img.size.height;
//        }
//        else{
//            h = self.img.size.height * w / self.img.size.width;
//        }
//    }
//    else{
//        if (self.img.size.height < DEVICE_WIDTH) {
//            w = self.img.size.width;
//            h = self.img.size.height;
//        }
//        else{
//            h = DEVICE_WIDTH;
//            w = DEVICE_WIDTH * self.img.size.width / self.img.size.height;
//        }
//    }
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH - w) / 2, (DEVICE_HEIGHT - h) / 2,  w, h)];
    
    CGFloat h = DEVICE_WIDTH * self.img.size.height / self.img.size.width;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (DEVICE_HEIGHT - h) / 2,  DEVICE_WIDTH, h)];
    
    imgView.image = self.img;
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClicked:)];
    [self.view addGestureRecognizer:imgTap];
    
    [self.view addSubview:imgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imgClicked:(UITapGestureRecognizer*)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
