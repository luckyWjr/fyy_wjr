//
//  MyImgScrollView.h
//  FYY_WJR
//
//  Created by wjr on 16/5/25.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ImgScrollViewDotsAlimentRight,
    ImgScrollViewDotsAlimentCenter
} ImgScrollViewDotsAliment;

@class MyImgScrollView;

@protocol MyImgScrollViewDelegate <NSObject>

- (void)cycleScrollView:(MyImgScrollView *)ImgScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface MyImgScrollView : UIView

@property (nonatomic, strong) NSArray *imagesGroup;
@property (nonatomic, strong) NSArray *titlesGroup;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, assign) ImgScrollViewDotsAliment dotsAliment;
@property (nonatomic, weak) id<MyImgScrollViewDelegate> delegate;

+ (instancetype)ImgScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;

@end
