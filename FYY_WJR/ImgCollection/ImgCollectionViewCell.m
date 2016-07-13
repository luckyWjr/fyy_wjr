//
//  ImgCollectionViewCell.m
//  FYY_WJR
//
//  Created by wjr on 16/7/5.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "ImgCollectionViewCell.h"

@implementation ImgCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.iv.contentMode = UIViewContentModeScaleAspectFill;
    self.iv.clipsToBounds = YES;
    [self.contentView addSubview:self.iv];
}

@end
