//
//  DreamDetailViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/4.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "DreamDetailViewController.h"
#import "MyTools.h"
#import "AddDreamViewController.h"
#import "UIView+SDExtension.h"

@interface DreamDetailViewController ()

@property (retain, nonatomic) UIScrollView *detailDreamScrollView;

@property (retain, nonatomic) UILabel *dreamNameLabel;
@property (retain, nonatomic) UILabel *dreamIsFinishLabel;
@property (retain, nonatomic) UILabel *dreamDetailLabel;
@property (retain, nonatomic) UILabel *dreamDateLabel;
@property (retain, nonatomic) UILabel *dreamImgLabel;
@property (retain, nonatomic) UIImageView *dreamImgView;
@property (retain, nonatomic) UIView *finishView;

@end

@implementation DreamDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showDreamDetail];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//    });
}

-(void)showDreamDetail{
    self.title = @"愿望详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDream)];
    
    self.navigationItem.rightBarButtonItem = editBtn;
    
    self.detailDreamScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    //隐藏滚动条设置（水平、跟垂直方向）
    self.detailDreamScrollView.alwaysBounceVertical = NO;
    self.detailDreamScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.detailDreamScrollView];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 2 - 100, 40, 200, VIEWBOX_DEFAULT_HEIGHT)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"愿望详情";
    [self.detailDreamScrollView addSubview:titleLabel];
    
    [self addRowView:@"愿望：" index:0];
    [self addRowView:@"完成：" index:1];
    [self addRowView:@"详情：" index:2];
    [self addRowView:@"时间：" index:3];
    [self addRowView:@"图片：" index:4];

    [self setValues];
}

-(void) addRowView:(NSString*)text index:(int)index{
    int rowWidth = HINTLABEL_WIDTH + TEXTFIELD_WIDTH;
    int textfieldMarginCenter = rowWidth / 2 - HINTLABEL_WIDTH;
    int marginTop = 100;
    int finishViewHeight = 300;
    
    int lineNum = 0;
    if (self.dreamModel.detail.length > 10) {
        lineNum = (int)self.dreamModel.detail.length / 10;
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((index < 2 ? (DEVICE_WIDTH - rowWidth) / 2 : 0), (index < 2 ? VIEWBOX_DEFAULT_HEIGHT * index + marginTop : VIEWBOX_DEFAULT_HEIGHT * (index - 2)) + (index > 2 ? VIEW_DEFAULT_HEIGHT * lineNum : 0), HINTLABEL_WIDTH, VIEW_DEFAULT_HEIGHT + (index == 2 ? VIEW_DEFAULT_HEIGHT * lineNum : 0))];
    label.text = text;
    label.textAlignment = NSTextAlignmentRight;
    
    if (index == 2) {
        self.finishView = [[UIView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH - rowWidth) / 2, VIEWBOX_DEFAULT_HEIGHT * index + marginTop, rowWidth, finishViewHeight)];
        [self.detailDreamScrollView addSubview:self.finishView];
    }
    
    UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake((index < 2 ? DEVICE_WIDTH / 2 - textfieldMarginCenter : HINTLABEL_WIDTH), (index < 2 ? VIEWBOX_DEFAULT_HEIGHT * index + marginTop : VIEWBOX_DEFAULT_HEIGHT * (index - 2))  + (index > 2 ? VIEW_DEFAULT_HEIGHT * lineNum : 0), TEXTFIELD_WIDTH, VIEW_DEFAULT_HEIGHT + (index == 2 ? VIEW_DEFAULT_HEIGHT * lineNum : 0))];
    //必须写，否则只显示一行
    [contentLabel setNumberOfLines:0];
    
    switch (index) {
        case 0:
            self.dreamNameLabel = contentLabel;
            break;
        case 1:
            self.dreamIsFinishLabel = contentLabel;
            break;
        case 2:
            self.dreamDetailLabel = contentLabel;
            break;
        case 3:
            self.dreamDateLabel = contentLabel;
            break;
        case 4:
            self.dreamImgLabel = contentLabel;
            self.dreamImgView = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * index + marginTop, TEXTFIELD_WIDTH, TEXTFIELD_WIDTH)];
            self.dreamImgView.layer.cornerRadius = DEFAULT_RADIUS;
            self.dreamImgView.layer.masksToBounds = YES;
            [self.detailDreamScrollView addSubview:self.dreamImgView];
            break;
            
        default:
            break;
    }

    if(index < 2){
        [self.detailDreamScrollView addSubview:label];
        [self.detailDreamScrollView addSubview:contentLabel];
    }
    else{
        [self.finishView addSubview:label];
        [self.finishView addSubview:contentLabel];
    }
}

- (void)setValues{
    self.dreamNameLabel.text = self.dreamModel.name;
    
    if ([self.dreamModel.isFinish isEqualToString:@"0"]) {
        self.dreamIsFinishLabel.text = @"未完成";
        self.finishView.hidden = YES;
    }
    else{
        self.dreamIsFinishLabel.text = @"已完成";
        self.finishView.hidden = NO;
        
        if ([self.dreamModel.detail isEqualToString:@""]) {
            self.dreamDetailLabel.text = @"暂无信息";
            self.dreamDetailLabel.textColor = [UIColor grayColor];
        }
        else{
            self.dreamDetailLabel.text = self.dreamModel.detail;
            self.dreamDetailLabel.textColor = [UIColor blackColor];
            //自动折行设置
            self.dreamDetailLabel.numberOfLines = 0;
        }
        
        self.dreamDateLabel.text = self.dreamModel.date;
        
        if ([self.dreamModel.imgPath isEqualToString:@""]) {
            self.dreamImgLabel.text = @"暂无信息";
            self.dreamImgLabel.textColor = [UIColor grayColor];
            self.dreamImgLabel.hidden = NO;
            self.dreamImgView.hidden = YES;
        }
        else{
            UIImage* image = [UIImage imageWithContentsOfFile:[DREAM_IMG_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", self.dreamModel.imgPath]]];
            self.dreamImgLabel.hidden = YES;
            self.dreamImgView.hidden = NO;
            
            self.dreamImgView.width = image.size.width;
            self.dreamImgView.height = image.size.height;
            
            self.dreamImgView.image = image;
            if(self.dreamImgView.y + self.dreamImgView.height > DEVICE_HEIGHT - NavHeight){
                self.detailDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, self.dreamImgView.y + self.dreamImgView.height + 50);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)editDream{
    AddDreamViewController* addVc = [[AddDreamViewController alloc] init];
    addVc.editDelegate = self;
    addVc.index = self.index;
    addVc.dreamModel = self.dreamModel;
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)editDreamFinish:(DreamModel*) newDream{
    self.dreamModel = newDream;
    [self setValues];
    if ([self.changedDelegate respondsToSelector:@selector(Dreamchanged)]) {
        [self.changedDelegate Dreamchanged];
    }
}

@end
