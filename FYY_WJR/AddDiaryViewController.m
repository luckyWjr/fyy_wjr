//
//  AddDiaryViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/6/27.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "AddDiaryViewController.h"
#import "MyTools.h"
#import "UIPlaceHolderTextView.h"
#import "ImgCollectionView.h"
#import "PhotoViewController.h"
#import "UIView+SDExtension.h"

@interface AddDiaryViewController ()<ImgCollectionViewDelegate>

@end

@implementation AddDiaryViewController{
    UILabel* addLabel;
    NSMutableArray* imgArr;
    ImgCollectionView* imgCV;
    UIPlaceHolderTextView* diaryTextView;
    CGFloat imgCVRowHeight;
    UIButton* dateBtn;
    UIView* contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"写日记";
    self.view.backgroundColor = ColorGray;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(addDiary)];
    
    [self setView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setView{
    NSInteger textHeight = 200;
    NSInteger selectImgMargin = 20;
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 0)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    diaryTextView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, textHeight)];
    diaryTextView.placeholder = @"在这里记录下我们美好的事迹吧~";
    diaryTextView.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:diaryTextView];
    
    imgArr = [[NSMutableArray alloc]init];
    [imgArr addObject:[UIImage imageNamed:@"addImg"]];
    
    imgCV = [[ImgCollectionView alloc]initWithFrame:CGRectMake(selectImgMargin, textHeight, DEVICE_WIDTH - selectImgMargin * 2, 0) imgArr:imgArr isAddList:YES];
    imgCV.addDelegate = self;
    imgCVRowHeight = imgCV.height;
    
    addLabel = [[UILabel alloc]initWithFrame:CGRectMake(selectImgMargin + DEVICE_WIDTH / 4, (DEVICE_WIDTH - selectImgMargin * 2) / 8 - 10, 200, 20)];
    addLabel.text = @"添加照片";
    addLabel.font = [UIFont systemFontOfSize:14];
    addLabel.textColor = [UIColor lightGrayColor];
    [imgCV addSubview:addLabel];
    
    [contentView addSubview:imgCV];
    
    dateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, textHeight + imgCVRowHeight, DEVICE_WIDTH, NavHeight)];
    [dateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [dateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    dateBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
//    [contentView addSubview:dateBtn];
    
    contentView.height = textHeight + imgCVRowHeight + 10;// + NavHeight;
    [self.view addSubview:contentView];
}

- (void)addImg{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PhotoViewController * photo = [[PhotoViewController alloc]init];
        photo.popSelectArr = ^(NSMutableArray* arr){
            if (arr.count > 0) {
                addLabel.hidden = YES;
            }
            else{
                addLabel.hidden = NO;
            }
            [arr addObject:[UIImage imageNamed:@"addImg"]];
            NSInteger line = (arr.count - 1) / photoCountEachRow + 1;
            imgCV.height = line * imgCVRowHeight;
            contentView.height += (line - 1) * imgCVRowHeight;
            imgCV.imgArr = arr;
            [imgCV reloadData];
        };
        
        [self.navigationController pushViewController:photo animated:NO];
    }];
    
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机没写");
    }];
    
    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction: action1];
    [alert addAction: action2];
    [alert addAction: action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addDiary{
    self.addNewDiary(nil);
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 隐藏键盘
- (void)TextFieldDidEndOnExit:(id)sender{
    [sender resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
