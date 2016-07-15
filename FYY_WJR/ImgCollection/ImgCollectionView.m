//
//  ImgCollectionView.m
//  FYY_WJR
//
//  Created by wjr on 16/7/5.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "ImgCollectionView.h"
#import "ImgCollectionViewCell.h"
#import "MyTools.h"
#import "UIView+SDExtension.h"
#import "ImgFillViewController.h"

#define imgCellId @"imgCollectionCell"
#define imgMargin 5

@interface ImgCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ImgCollectionView{
    CGFloat w, h;
    BOOL isAddList;
}

-(instancetype)initWithFrame:(CGRect)frame imgArr:(NSMutableArray*)arr isAddList:(BOOL)is{
    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.imgArr = arr;
    isAddList = is;
    
    if (self == [super initWithFrame:frame collectionViewLayout:fl]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:NSClassFromString(@"ImgCollectionViewCell") forCellWithReuseIdentifier:imgCellId];
    self.backgroundColor = [UIColor clearColor];
    
    if (isAddList) {
        w = self.width / 4;
        h = w;
        self.height = h * ((self.imgArr.count - 1) / 4 + 1);
    }
    else{
        if (self.imgArr.count == 1) {
            UIImage* img = self.imgArr[0];
            NSInteger imgMaxHeight = 200;
            w = self.width;
            if (img.size.width / img.size.height > w / imgMaxHeight) {
                if (img.size.width < w) {
                    w = img.size.width;
                    h = img.size.height;
                }
                else{
                    h = img.size.height * w / img.size.width;
                }
            }
            else{
                if (img.size.height < imgMaxHeight) {
                    w = img.size.width;
                    h = img.size.height;
                }
                else{
                    h = imgMaxHeight;
                    w = imgMaxHeight * img.size.width / img.size.height;
                }
            }
            w = w - 10;
            h = h - 10;
            self.height = h;
        }
        else if (self.imgArr.count == 2 || self.imgArr.count == 4){
            w = self.width / 2;
            h = w;
            self.height = h * self.imgArr.count / 2;
        }
        else{
            w = self.width / 3;
            h = w;
            self.height = h * ((self.imgArr.count - 1) / 3 + 1);
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(w - imgMargin, h - imgMargin);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imgCellId forIndexPath:indexPath];
    cell.iv.image = self.imgArr[indexPath.row];
    
    return cell;
}

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return imgMargin;
}

//行内间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return imgMargin;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (isAddList && indexPath.row == self.imgArr.count - 1) {
        if ([self.addDelegate respondsToSelector:@selector(addImg)]) {
            [self.addDelegate addImg];
        }
        return;
    }
    
    ImgFillViewController* imgVc = [[ImgFillViewController alloc] init];
    imgVc.img = self.imgArr[indexPath.row];
    UIViewController* Vc = [[UIApplication sharedApplication].keyWindow rootViewController];
    [Vc addChildViewController:imgVc];
    [Vc.view addSubview:imgVc.view];
}
@end
