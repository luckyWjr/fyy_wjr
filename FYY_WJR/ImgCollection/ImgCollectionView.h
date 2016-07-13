//
//  ImgCollectionView.h
//  FYY_WJR
//
//  Created by wjr on 16/7/5.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImgCollectionViewDelegate <NSObject>

@optional

- (void)addImg;

@end

@interface ImgCollectionView : UICollectionView

@property(copy, atomic) NSMutableArray* imgArr;
@property (nonatomic, weak) id<ImgCollectionViewDelegate> addDelegate;

-(instancetype)initWithFrame:(CGRect)frame imgArr:(NSMutableArray*)imgArr isAddList:(BOOL)is;

@end
