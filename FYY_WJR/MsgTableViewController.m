//
//  MsgTableViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/26.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MsgTableViewController.h"
#import "MyOnlyTitleCellModel.h"
#import "MyTableViewGroupModel.h"
#import "MyDefaultCellModel.h"
#import "MyOnlyImgPopupViewController.h"
#import "MyTools.h"
#import "UIView+SDExtension.h"
#import "DiaryModel.h"
#import "ImgFillViewController.h"
#import "AddDiaryViewController.h"
#import "ImgCollectionView.h"

@interface MsgTableViewController ()

@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation MsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    
    if(self.msgType == MsgTypeFood){
        [self showFoodList];
    }
    else if(self.msgType == MsgTypeToiletry){
        [self showToiletryList];
    }
    else if(self.msgType == MsgTypeLove){
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDiary)];
        self.navigationItem.rightBarButtonItem = addBtn;
        
        [self showLoveList];
    }
    else if(self.msgType == MsgTypeFestival){
        [self showFestivalList];
    }
    
}
- (void)showLoveList{
    self.title = @"Love";

    [self setLineLong];
    
    int topViewHeight = 100;
    int topImgHeight = 30;
    int textHeight = 12;
    int listMarginTopAndBottom = 40;
    
    UIView* topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, topViewHeight)];
    for (int i = 0; i < 3; i++) {
        UIButton* btnView = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_WIDTH / 3 * i, 0, DEVICE_WIDTH / 3, topViewHeight)];
        btnView.tag = i;
        [btnView addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchDown];
        [btnView addTarget:self action:@selector(topBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (topViewHeight - topImgHeight - textHeight) / 2, DEVICE_WIDTH / 3, topImgHeight)];
        imgView.contentMode = UIViewContentModeCenter;
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, (topViewHeight + topImgHeight - textHeight) / 2, DEVICE_WIDTH / 3, textHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize: 12.0];
        
        if(i == 0){
            label.text = @"测试";
            
            imgView.image = [UIImage imageNamed:@"sitdown"];
        }
        else if(i == 1){
            label.text = @"测试";
            
            imgView.image = [UIImage imageNamed:@"siji"];
        }
        else if(i == 2){
            label.text = @"测试";
            
            imgView.image = [UIImage imageNamed:@"sons"];
        }
        [btnView addSubview:imgView];
        [btnView addSubview:label];
        
        [topView addSubview:btnView];
    }
    MyTableViewGroupModel *topGroup = [[MyTableViewGroupModel alloc] init];
    topGroup.headerHeight = 0.00001;
    
    MyOnlyTitleCellModel *topItem = [MyOnlyTitleCellModel itemWithTitle:nil];
    topItem.contentView = topView;
    topItem.cellHeight = topViewHeight;
    [topGroup.items addObject:topItem];
    [self.dataList addObject:topGroup];
    
    MyTableViewGroupModel *listGroup = [[MyTableViewGroupModel alloc] init];
    listGroup.header = @"日记";
    
    int yearLabelWidth = 80;
    int contentWidth = DEVICE_WIDTH - yearLabelWidth;
    
    for(int i = 0; i < 6; i++){
        DiaryModel* model = [[DiaryModel alloc]init];
        model.year = @"2016";
        model.month = @"6";
        model.day = @"1";
        model.msg = @"\t测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        UIFont* msgFont = [UIFont systemFontOfSize:14.0];
        
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        if (i == 2) {
            arr = nil;
            model.msg = @"\t测试测试测试测试测试";
        }
        else if(i == 1){
            [arr addObject:[UIImage imageNamed:@"d0"]];
            model.msg = @"\t还是测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        }
        else if(i == 0){
            arr = nil;
        }
        else if(i == 3){
            arr = nil;
            model.msg = @"\t还是测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        }
        else if(i == 4){
            [arr addObject:[UIImage imageNamed:@"IMG_6725"]];
            [arr addObject:[UIImage imageNamed:@"IMG_6339"]];
            [arr addObject:[UIImage imageNamed:@"IMG_6179"]];
            [arr addObject:[UIImage imageNamed:@"IMG_7836"]];
            model.msg = @"\t还是测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        }
        else if(i == 5){
            [arr addObject:[UIImage imageNamed:@"IMG_6179"]];
            [arr addObject:[UIImage imageNamed:@"IMG_6725"]];
            [arr addObject:[UIImage imageNamed:@"IMG_7836"]];
            [arr addObject:[UIImage imageNamed:@"d0"]];
            [arr addObject:[UIImage imageNamed:@"IMG_6339"]];
            model.msg = @"\t还是测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        }
        
        NSDictionary *attribute = @{NSFontAttributeName: msgFont};
        CGSize msgSize = [model.msg boundingRectWithSize:CGSizeMake(DEVICE_WIDTH - yearLabelWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        
        int height;
        ImgCollectionView* imgCollectionView = nil;
        if (arr != nil) {
            imgCollectionView = [[ImgCollectionView alloc] initWithFrame:CGRectMake(yearLabelWidth, listMarginTopAndBottom / 2 + msgSize.height, contentWidth, 0) imgArr:arr isAddList:NO];
            height = msgSize.height + listMarginTopAndBottom + imgCollectionView.height;
        }
        else{
            height = msgSize.height + listMarginTopAndBottom;
        }
        
        UIView* listView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, height)];
        
        UILabel* dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, yearLabelWidth, height)];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont boldSystemFontOfSize:12.0];
        dateLabel.text = [NSString stringWithFormat:@"%@-%@-%@", model.year, model.month, model.day];
        [listView addSubview:dateLabel];
        
        UILabel* msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabelWidth, listMarginTopAndBottom / 2, contentWidth, msgSize.height)];
        msgLabel.font = msgFont;
        msgLabel.text = model.msg;
        msgLabel.numberOfLines = 0;
        [listView addSubview:msgLabel];
        
        if (arr != nil) {
            [listView addSubview:imgCollectionView];
        }
        
        MyOnlyTitleCellModel *listItem = [MyOnlyTitleCellModel itemWithTitle:nil];
        listItem.contentView = listView;
        listItem.cellHeight = listView.height;
        [listGroup.items addObject:listItem];
    }
    
    [self.dataList addObject:listGroup];
}

- (void)addDiary{
    AddDiaryViewController* addVc = [[AddDiaryViewController alloc] init];
    addVc.addNewDiary = ^(DiaryModel* model){
        NSLog(@"addNewDiary");
    };
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)imgClicked:(UITapGestureRecognizer *)sender{
    ImgFillViewController* imgVc = [[ImgFillViewController alloc] init];
    UIImageView* view = (UIImageView*)sender.view;
    imgVc.img = view.image;
    UIViewController* Vc = [[UIApplication sharedApplication].keyWindow rootViewController];
    [Vc addChildViewController:imgVc];
    [Vc.view addSubview:imgVc.view];
}

- (void)showFestivalList{
    [self setLineLong];
    NSString* name = nil;
    NSString* date = nil;
    NSString* detail = nil;
    
    NSMutableArray* festivalArr = [[NSMutableArray alloc]init];
    
    date = [NSString stringWithFormat:@"%d月14号", self.index];
    switch (self.index) {
        case 1:
        {
            name = @"日记情人节";
            detail = @"交换日记";
        }
            break;
        case 2:
        {
            name = @"情人节";
            detail = @"女生送男生巧克力";
            
            [festivalArr addObject:[DiaryModel initWithYear:@"2016" Msg:@"\t测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"]];
        }
            break;
        case 3:
        {
            name = @"白色情人节";
            detail = @"男生送女生白色巧克力";
            
            [festivalArr addObject:[DiaryModel initWithYear:@"2016" Msg:@"\t测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"]];
        }
            break;
        case 4:
        {
            name = @"黑色情人节";
            detail = @"要一起吃炸酱面哦";
            
            [festivalArr addObject:[DiaryModel initWithYear:@"2016" Msg:@"\t测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试\n\t测试测试测试测试测试测试测试测试\n\t测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"]];
        }
            break;
        case 5:
        {
            name = @"玫瑰情人节";
            detail = @"男生送女生一束红玫瑰";
            
            [festivalArr addObject:[DiaryModel initWithYear:@"2016" Msg:@"\t测试"]];
        }
            break;
        case 6:
        {
            name = @"亲亲情人节";
            detail = @"相互唱各自喜欢的歌";
            [festivalArr addObject:[DiaryModel initWithYear:@"2016" Msg:@"\t测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"]];
        }
            break;
        case 7:
        {
            name = @"银色情人节";
            detail = @"送情侣戒";
        }
            break;
        case 8:
        {
            name = @"绿色情人节";
            detail = @"去郊游";
        }
            break;
        case 9:
        {
            name = @"相片情人节";
            detail = @"拍大头贴";
        }
            break;
        case 10:
        {
            name = @"葡萄酒情人节";
            detail = @"共进烛光晚餐";
        }
            break;
        case 11:
        {
            name = @"电影情人节";
            detail = @"喝橙汁，看电影";
        }
            break;
        case 12:
        {
            name = @"拥抱情人节";
            detail = @"拥抱，表示仍然相爱";
        }
            break;
        case 13:
        {
            name = @"七夕节";
            detail = @"在一起";
            date = @"农历7月初7";
        }
            break;
        case 14:
        {
            name = @"圣诞节";
            detail = @"苹果，在一起";
            date = @"12月25号";
        }
            break;
        default:
            break;
    }
    
    self.title = name;
    
    int topViewHeight = 100;
    int topTextHeight = 50;
    int imgWidth = 80;
    int imgMargin = 5;
    
    UIView* topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, topViewHeight)];
    
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(imgMargin * 2, imgMargin, imgWidth, topViewHeight - 2 * imgMargin)];
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"loveday_%d", self.index]];
    imgView.layer.cornerRadius = DEFAULT_RADIUS;
    imgView.layer.masksToBounds = YES;
    [topView addSubview:imgView];
    
    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth + imgMargin * 4, 0, DEVICE_WIDTH / 3, topTextHeight)];
    nameLabel.text = name;
    [topView addSubview:nameLabel];
    
    UILabel* dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH / 3 * 2, 0, DEVICE_WIDTH / 3, topTextHeight)];
    dateLabel.text = date;
    dateLabel.font = [UIFont systemFontOfSize:12.0];
    dateLabel.textColor = [UIColor grayColor];
    [topView addSubview:dateLabel];
    
    UILabel* detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth + imgMargin * 4, topTextHeight, DEVICE_WIDTH, (detail.length / 15 + 1) * topTextHeight / 3)];
    detailLabel.text = [NSString stringWithFormat:@"简介：%@", detail];
    detailLabel.font = [UIFont systemFontOfSize:12.0];
    detailLabel.textColor = [UIColor grayColor];
    [topView addSubview:detailLabel];
    
    MyTableViewGroupModel *topGroup = [[MyTableViewGroupModel alloc] init];
    topGroup.headerHeight = 0.00001;
    
    MyOnlyTitleCellModel *topItem = [MyOnlyTitleCellModel itemWithTitle:nil];
    topItem.contentView = topView;
    topItem.cellHeight = topViewHeight;
    [topGroup.items addObject:topItem];
    [self.dataList addObject:topGroup];
    
    MyTableViewGroupModel *listGroup = [[MyTableViewGroupModel alloc] init];
    listGroup.header = @"我们的这一天";
    
    int yearLabelWidth = 100;
    
    if(festivalArr.count > 0){
        for(int i = 0; i < festivalArr.count; i++){
            DiaryModel* model = [festivalArr objectAtIndex:i];
            UIFont* msgFont = [UIFont systemFontOfSize:14.0];
            
            NSDictionary *attribute = @{NSFontAttributeName: msgFont};
            CGSize msgSize = [model.msg boundingRectWithSize:CGSizeMake(DEVICE_WIDTH - yearLabelWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
            int height = msgSize.height + 40;
            
            UIView* listView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, height)];
            
            UILabel* yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, yearLabelWidth, height)];
            yearLabel.textAlignment = NSTextAlignmentCenter;
            yearLabel.font = [UIFont boldSystemFontOfSize:17.0];
            yearLabel.text = model.year;
            [listView addSubview:yearLabel];
            
            UILabel* msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabelWidth, 0, DEVICE_WIDTH - yearLabelWidth, height)];
            msgLabel.font = msgFont;
            msgLabel.text = model.msg;
            msgLabel.numberOfLines = 0;
            [listView addSubview:msgLabel];
            
            MyOnlyTitleCellModel *listItem = [MyOnlyTitleCellModel itemWithTitle:nil];
            listItem.contentView = listView;
            listItem.cellHeight = listView.height;
            [listGroup.items addObject:listItem];
        }
    }
    else{
        MyOnlyTitleCellModel *listItem = [MyOnlyTitleCellModel itemWithTitle:@"敬请期待这一天的到来吧"];
        [listGroup.items addObject:listItem];
    }
    
    
    [self.dataList addObject:listGroup];
}

- (void)showFoodList{
    self.title = @"爱吃的";
    self.dataArray = @[
                       @{@"type":@"最重要的", @"content":@[@"测试"]},
                       @{@"type":@"素菜", @"content":@[@"土豆", @"藕片", @"花菜", @"西红柿蛋汤", @"小青菜", @"豆腐"]},
                       @{@"type":@"晕菜", @"content":@[@"鸡翅", @"鸡胗", @"三文鱼"]},
                       @{@"type":@"水果", @"content":@[@"草莓", @"小番茄", @"车厘子"]},
                       @{@"type":@"关东煮", @"content":@[@"北极翅", @"海带结"]},
                       ];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSDictionary* dict = self.dataArray[i];
        MyTableViewGroupModel *group = [[MyTableViewGroupModel alloc] init];
        group.header = [dict objectForKey:@"type"];
        
        NSArray* arr = [dict objectForKey:@"content"];
        for (int j = 0; j < arr.count; j++) {
            MyOnlyTitleCellModel *item = [MyOnlyTitleCellModel itemWithTitle:arr[j]];
            [group.items addObject:item];
        }
        [self.dataList addObject:group];
    }
}

- (void)showToiletryList{
    self.title = @"化妆品";
    self.dataArray = @[
                       @{@"index": @"0", @"type":@"YSL", @"content":@[@{@"index": @"0", @"name": @"纯色唇釉", @"other": @"12# 红绯"}]},
                       ];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSDictionary* dict = self.dataArray[i];
        MyTableViewGroupModel *group = [[MyTableViewGroupModel alloc] init];
        group.header = [dict objectForKey:@"type"];
        group.index = [dict objectForKey:@"index"];
        
        NSArray* arr = [dict objectForKey:@"content"];
        for (int j = 0; j < arr.count; j++) {
            NSDictionary* toiletryDict = arr[j];
            MyDefaultCellModel *item = [MyDefaultCellModel itemWithTitle:[NSString stringWithFormat:@"%@", [toiletryDict objectForKey:@"name"]]];
            item.subTitle = [NSString stringWithFormat:@"%@", [toiletryDict objectForKey:@"other"]];
            item.index = [toiletryDict objectForKey:@"index"];
            [group.items addObject:item];
        }
        
        [self.dataList addObject:group];
    }
}

- (void)clickCell:(MyTableViewGroupModel*)group model:(MyDefaultCellModel *)model{
    if (self.msgType == MsgTypeToiletry) {
        MyOnlyImgPopupViewController* popupVc = [[MyOnlyImgPopupViewController alloc] init];
        popupVc.btnType = BtnCountTypeOne;
        popupVc.widthScale = 0.8;
        popupVc.heightScale = 0.6;
        if ([group.index isEqualToString:@"0"]) {//YSL
            if([model.index isEqualToString:@"0"]){//纯色唇釉
                popupVc.title = model.title;
                popupVc.img = [UIImage imageNamed:[NSString stringWithFormat:@"ysl_%@", model.index]];
            }
        }
        UIViewController* Vc = [[UIApplication sharedApplication].keyWindow rootViewController];
        [Vc addChildViewController:popupVc];
        [Vc.view addSubview:popupVc.view];
    }
    
//    MyTableViewGroupModel *group1 = self.dataList[1];
//    for(int i = 0; i < 5; i++){
//        MyOnlyTitleCellModel *listItem = [MyOnlyTitleCellModel itemWithTitle:@"a"];
//        
//        [group1.items addObject:listItem];
//        
//    }
//    [self.tableView reloadData];
}

- (void)topClick:(UIButton*)sender{
    sender.backgroundColor = MyGrayColor;
    if (sender.tag == 0) {
    }
    else if (sender.tag == 1) {
        
    }
    else{
    }
}

- (void)topBtnTouchUpInside:(UIButton*)sender{
    sender.backgroundColor = [UIColor whiteColor];
}

- (void)setLineLong{
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
