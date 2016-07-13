//
//  MyDefaultPopupViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BtnCountTypeOne,
    BtnCountTypeTwo
} BtnCountType;

@interface MyDefaultPopupViewController : UIViewController

@property (nonatomic, assign) BtnCountType btnType;
@property (nonatomic, assign) float widthScale;
@property (nonatomic, assign) float heightScale;
@property (nonatomic, strong) UIView* contentView;

@end
