//
//  MyImgScrollView.h
//  FYY_WJR
//
//  Created by wjr on 16/5/25.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImgScrollViewDotsAliment) {
    ImgScrollViewDotsAlimentRight,
    ImgScrollViewDotsAlimentCenter
};

@class MyImgScrollView;

@protocol MyImgScrollViewDelegate <NSObject>

- (void)cycleScrollView:(MyImgScrollView *)ImgScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface MyImgScrollView : UIView

@property (nonatomic, copy) NSArray *imagesGroup;
@property (nonatomic, copy) NSArray *titlesGroup;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, assign) ImgScrollViewDotsAliment dotsAliment;
@property (nonatomic, weak) id<MyImgScrollViewDelegate> delegate;

+ (instancetype)ImgScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;

@end
