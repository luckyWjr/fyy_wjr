//
//  MyDefaultPopupViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BtnCountType) {
    BtnCountTypeOne,
    BtnCountTypeTwo
};

@interface MyDefaultPopupViewController : UIViewController

@property (nonatomic, assign) BtnCountType btnType;
@property (nonatomic, assign) CGFloat widthScale;
@property (nonatomic, assign) CGFloat heightScale;
@property (nonatomic, strong) UIView* contentView;

@end
