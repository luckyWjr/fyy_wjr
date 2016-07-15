//
//  XYZPhoto.h
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYZPhotoState) {
    XYZPhotoStateNormal,
    XYZPhotoStateBig,
    XYZPhotoStateDraw,
    XYZPhotoStateTogether
};

@interface XYZPhoto : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CGFloat speed;
@property (nonatomic) CGRect oldFrame;
@property (nonatomic) CGFloat oldSpeed;
@property (nonatomic) CGFloat oldAlpha;
@property (nonatomic) NSInteger state;

- (void)updateImage:(UIImage *)image;
- (void)setImageAlphaAndSpeedAndSize:(CGFloat)alpha;

@end
