//
//  MyDefaultPopupViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyDefaultPopupViewController.h"
#import "MyTools.h"
#import "UIView+SDExtension.h"

@interface MyDefaultPopupViewController ()

@property (nonatomic, strong) UIView* popupView;

@end

@implementation MyDefaultPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDefaultPopup];
    // Do any additional setup after loading the view.
}

-(void)setDefaultPopup{
    self.view.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    
    self.popupView = [[UIView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH * (1 - self.widthScale) / 2, DEVICE_HEIGHT * (1 - self.heightScale) / 2, DEVICE_WIDTH * self.widthScale, DEVICE_HEIGHT * self.heightScale)];
    self.popupView.layer.cornerRadius = DEFAULT_RADIUS;
    self.popupView.layer.masksToBounds = YES;
    self.popupView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.popupView];
    
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.popupView.width, NavHeight)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    
    UIView* titleLine = [[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, self.popupView.width, LineHegiht)];
    titleLine.backgroundColor = RGBHexColor(@"e3e1e4");
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight + LineHegiht, self.popupView.width, self.popupView.height - (NavHeight + LineHegiht) * 2)];
    
    UIView* btnLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.popupView.height - NavHeight - LineHegiht, self.popupView.width, LineHegiht)];
    btnLine.backgroundColor = RGBHexColor(@"e3e1e4");
    
    UIView* btnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.popupView.height - NavHeight, self.popupView.width, NavHeight)];
    if (self.btnType == BtnCountTypeOne) {
        UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnView.width, btnView.height)];
        confirmBtn.tag = 0;
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:confirmBtn];
        
    }
    else if(self.btnType == BtnCountTypeTwo){
        UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (btnView.width - LineHegiht) / 2, btnView.height)];
        cancelBtn.tag = 0;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* btnVLine = [[UIView alloc] initWithFrame:CGRectMake((btnView.width - LineHegiht) / 2, 0, LineHegiht, btnView.height)];
        btnLine.backgroundColor = RGBHexColor(@"e3e1e4");
        
        UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((btnView.width + LineHegiht) / 2, 0, (btnView.width - LineHegiht) / 2, btnView.height)];
        confirmBtn.tag = 1;
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnView addSubview:cancelBtn];
        [btnView addSubview:btnVLine];
        [btnView addSubview:confirmBtn];
    }
    [self setContentView];
    
    [self.popupView addSubview:titleLabel];
    [self.popupView addSubview:titleLine];
    [self.popupView addSubview:self.contentView];
    [self.popupView addSubview:btnLine];
    [self.popupView addSubview:btnView];
}

-(void)setContentView{
}

- (void)btnClick:(UIButton *)sender{
    if(sender.tag == 0){
//        if ([self.dateDelegate respondsToSelector:@selector(setDateValue:)]) {
//            [self.dateDelegate setDateValue:@""];
//        }
    }
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
//    if ([self.viewDelegate respondsToSelector:@selector(hidePickerViewSuc)]) {
//        [self.viewDelegate hidePickerViewSuc];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
