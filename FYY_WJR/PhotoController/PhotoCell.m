//
//  PhotoCell.m
//  GETPHOTO
//
//  Created by ZJF on 16/5/26.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "PhotoCell.h"
#import "MyTools.h"

@implementation PhotoCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    NSInteger btnMargin = 1;
    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.iv.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.iv];
    CGFloat ivX = self.iv.frame.size.width;
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(ivX * 3 / 4 - btnMargin, btnMargin, ivX / 4, ivX / 4)];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btn];
}


- (void)touchBtn:(UIButton *)sender{
    self.btnAction();
}

@end
