//
//  PhotoViewController.m
//  相片相机
//
//  Created by ZJF on 16/6/1.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "PhotoViewController.h"
#import "ImgCollectionView.h"
#import <Photos/Photos.h>
#import "PhotoCell.h"
#import "MyTools.h"
#import "ImgFillViewController.h"

#define ImgMargin 1

@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView * cv;

//图片数组
@property (nonatomic, strong)NSMutableArray * arr;
@property (nonatomic, assign)BOOL isup;
@property (nonatomic, copy)NSString * identifier;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isup = NO;
    self.arr = [[NSMutableArray alloc]init];
    self.selectArr = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(popto)];
    self.title = @"所有图片";
    
    [self getPhotoData];
}

#pragma mark --- 获取所有图片资源
- (void)getPhotoData{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
        PHAsset *asset = assetsFetchResults[i];
        //资源转图片
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            UIImage * image = [UIImage imageWithData:imageData];
            [self.arr addObject:image];
            
            if (self.arr.count == assetsFetchResults.count){
                [self createUI];
            }
        }];
    }
}

#pragma mark -- 主界面
- (void)createUI{
    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight + StatusBarHeight, DEVICE_WIDTH, DEVICE_HEIGHT) collectionViewLayout:fl];
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = RGBColor(239, 239, 244);
    [self.cv registerClass:NSClassFromString(@"PhotoCell")forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.cv];
    
    _isup = NO;
}

#pragma mark ---- cv协议
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger width = (DEVICE_WIDTH - (photoCountEachRow - 1) * ImgMargin) / photoCountEachRow;
    return CGSizeMake(width, width);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.iv.image = self.arr[indexPath.row];
    
    //使cell.btn的图片在block中可修改
    __block UIButton * btn = cell.btn;
    
    //判断是否选中
    cell.btnAction = ^{
        if (self.selectArr.count == 9 && cell.btn.selected == NO) {
            [MyTools showOneBtnAlertView:@"最多只能选择9张图片"];
            return;
        }
        if (cell.btn.selected == NO) {
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.selectArr addObject: self.arr[indexPath.row]];
            btn.selected = YES;
        }
        else{
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.selectArr removeObject: self.arr[indexPath.row]];
            btn.selected = NO;
        }
    };
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return ImgMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return ImgMargin;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgFillViewController* imgVc = [[ImgFillViewController alloc] init];
    imgVc.img = self.arr[indexPath.row];
    UIViewController* Vc = [[UIApplication sharedApplication].keyWindow rootViewController];
    [Vc addChildViewController:imgVc];
    [Vc.view addSubview:imgVc.view];
}

#pragma mark --- 返回
- (void)popto{
    self.popSelectArr(self.selectArr);
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
