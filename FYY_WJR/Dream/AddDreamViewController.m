//
//  AddDreamViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "AddDreamViewController.h"
#import "MyTools.h"
#import "DataUITextField.h"
#import "DreamModel.h"
#import "ModelTool.h"
#import "UIView+SDExtension.h"
#import "MyDatePickerView.h"

static int addBtnDefaultHeight = 300;
static int addBtnFinishHeight = 400;

@interface AddDreamViewController ()

@property (retain, nonatomic) UIView *finishView;
@property (retain, nonatomic) UITextField *dreamNameTextField;
@property (retain, nonatomic) UISwitch *dreamIsfinishSwitch;
@property (retain, nonatomic) UITextField *dreamDetailTextField;
@property (retain, nonatomic) DataUITextField *dreamDataTextField;
@property (retain, nonatomic) UIScrollView *addDreamScrollView;
@property (retain, nonatomic) UIImageView *dreamImageView;
@property (retain, nonatomic) UIButton *selectPicBtn;
@property (retain, nonatomic) UIButton *addBtn;

@property(strong, nonatomic) ModelTool* dreamTool;
@property(assign, nonatomic) BOOL isSelectImg;

@end

@implementation AddDreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editViews];
    self.dreamTool = [[ModelTool alloc]initByType:ModelTypeDream];
}

-(void)showDatePickerView{
    MyDatePickerView* datePicker = [[MyDatePickerView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT - DatePickerHeight - NavHeight - LineHegiht, DEVICE_WIDTH, DatePickerHeight + NavHeight + LineHegiht)];
    datePicker.dateDelegate = self.dreamDataTextField;
    datePicker.viewDelegate = self;
    if ([datePicker.dateDelegate respondsToSelector:@selector(setDateValue:)]) {
        NSString* date = [MyTools convertStringFromDate:[datePicker.datePicker date]];
        [datePicker.dateDelegate setDateValue:date];
    }
    
    [self.view addSubview:datePicker];
    self.addDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 600);
}

- (void)hidePickerViewSuc{
    self.addDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT);
}

- (void) editViews{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addDreamScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    //隐藏滚动条设置（水平、跟垂直方向）
    self.addDreamScrollView.alwaysBounceVertical = NO;
    self.addDreamScrollView.showsVerticalScrollIndicator = NO;
    self.addDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT);
    [self.view addSubview:self.addDreamScrollView];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 2 - 100, 40, 200, VIEWBOX_DEFAULT_HEIGHT)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.addDreamScrollView addSubview:titleLabel];
    
    [self addRowView:@"愿望：" index:0];
    [self addRowView:@"完成：" index:1];
    [self addRowView:@"详情：" index:2];
    [self addRowView:@"时间：" index:3];
    [self addRowView:@"图片：" index:4];
    
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 2 - 50, 340, 100, VIEWBOX_DEFAULT_HEIGHT)];
    [self.addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addNewDream:) forControlEvents:UIControlEventTouchDown];
    [self.addDreamScrollView addSubview:self.addBtn];
    
    if (self.dreamModel == nil) {
        self.title = @"添加新愿望";
        titleLabel.text = @"添加一个新愿望呗";
        self.finishView.hidden = YES;
        self.dreamIsfinishSwitch.on = NO;
        [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    }
    else{
        self.title = @"编辑愿望";
        titleLabel.text = @"修改我们的愿望";
        self.dreamNameTextField.text = self.dreamModel.name;
        [self.addBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        if ([self.dreamModel.isFinish isEqualToString:@"1"]) {
            self.dreamIsfinishSwitch.on = YES;
            self.finishView.hidden = NO;
            
            self.dreamDetailTextField.text = self.dreamModel.detail;
            self.dreamDataTextField.text = self.dreamModel.date;
            
            self.addDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, self.addBtn.y + 50);
            
            if (![self.dreamModel.imgPath isEqualToString:@""]) {
                UIImage* image = [UIImage imageWithContentsOfFile:[DREAM_IMG_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", self.dreamModel.imgPath]]];
                self.isSelectImg = YES;
                [self selectedPicChangeView:image];
            }
        }
        else{
            self.finishView.hidden = YES;
            self.dreamIsfinishSwitch.on = NO;
        }
        [self isFinish];
    }
}

-(void) addRowView:(NSString*)text index:(int)index{
    int rowWidth = HINTLABEL_WIDTH + TEXTFIELD_WIDTH;
    int textfieldMarginCenter = rowWidth / 2 - HINTLABEL_WIDTH;
    int marginTop = 100;
    int finishViewHeight = 300;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((index < 2 ? (DEVICE_WIDTH - rowWidth) / 2 : 0), (index < 2 ? VIEWBOX_DEFAULT_HEIGHT * index + marginTop : VIEWBOX_DEFAULT_HEIGHT * (index - 2)), HINTLABEL_WIDTH, VIEW_DEFAULT_HEIGHT)];
    label.text = text;
    label.textAlignment = NSTextAlignmentRight;
    
    if (index < 2) {
        [self.addDreamScrollView addSubview:label];
        if (index == 0) {
            self.dreamNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * index + marginTop, TEXTFIELD_WIDTH, VIEW_DEFAULT_HEIGHT)];
            [self.dreamNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
            [self.dreamNameTextField addTarget:self action:@selector(TextFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
            [self.addDreamScrollView addSubview:self.dreamNameTextField];
        }
        else{
            self.dreamIsfinishSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(DEVICE_WIDTH / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * index + marginTop, TEXTFIELD_WIDTH, VIEW_DEFAULT_HEIGHT)];
            [self.dreamIsfinishSwitch addTarget:self action:@selector(isFinish) forControlEvents:UIControlEventValueChanged];
            [self.addDreamScrollView addSubview:self.dreamIsfinishSwitch];
        }
    }
    else{
        if (index == 2) {
            self.finishView = [[UIView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH - rowWidth) / 2, VIEWBOX_DEFAULT_HEIGHT * index + marginTop, rowWidth, finishViewHeight)];
            [self.addDreamScrollView addSubview:self.finishView];
            
            self.dreamDetailTextField = [[UITextField alloc] initWithFrame:CGRectMake(rowWidth / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * (index - 2), TEXTFIELD_WIDTH, VIEW_DEFAULT_HEIGHT)];
            [self.dreamDetailTextField setBorderStyle:UITextBorderStyleRoundedRect];
            [self.dreamDetailTextField addTarget:self action:@selector(TextFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
            [self.finishView addSubview:self.dreamDetailTextField];
        }
        else if (index == 3){
            self.dreamDataTextField = [[DataUITextField alloc] initWithFrame:CGRectMake(rowWidth / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * (index - 2), TEXTFIELD_WIDTH, VIEW_DEFAULT_HEIGHT)];
            [self.dreamDataTextField setBorderStyle:UITextBorderStyleRoundedRect];
            self.dreamDataTextField.dateTextViewDelegate = self;
            [self.finishView addSubview:self.dreamDataTextField];
        }
        else if (index == 4){
            self.selectPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(rowWidth / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * (index - 2), 100, 30)];
            [self.selectPicBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.selectPicBtn addTarget:self action:@selector(showSelectPic:) forControlEvents:UIControlEventTouchDown];
            [self.selectPicBtn setTitle:@"点击添加图片" forState:UIControlStateNormal];
            self.selectPicBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            [self.finishView addSubview:self.selectPicBtn];
            
            self.dreamImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rowWidth / 2 - textfieldMarginCenter, VIEWBOX_DEFAULT_HEIGHT * (index - 2), TEXTFIELD_WIDTH, TEXTFIELD_WIDTH / DEVICE_WIDTH * DEVICE_HEIGHT)];
            self.dreamImageView.layer.cornerRadius = DEFAULT_RADIUS;
            self.dreamImageView.layer.masksToBounds = YES;
            self.dreamImageView.hidden = YES;
            self.isSelectImg = NO;
            self.dreamImageView.contentMode = UIViewContentModeCenter;
            [self.finishView addSubview:self.dreamImageView];
        }
        [self.finishView addSubview:label];
    }
}

//autolayout下，修改控件位置在该方法下进行，写在主线程中为了确保代码在auto layout后才执行
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏键盘
- (void)TextFieldDidEndOnExit:(id)sender{
    [sender resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)isFinish {
    if(self.dreamIsfinishSwitch.on){
        if (self.isSelectImg) {
            self.addBtn.y = addBtnDefaultHeight + self.dreamImageView.height + 80;
        }
        else{
            self.addBtn.y = addBtnFinishHeight;
        }
        self.addDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, self.addBtn.y + 100);
        self.finishView.hidden = NO;
    }
    else{
        self.addDreamScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT);
        self.addBtn.y = addBtnDefaultHeight;
        self.finishView.hidden = YES;
    }
}

- (void)addNewDream:(id)sender {
    if([self.dreamNameTextField.text isEqualToString:@""]){
        [self showOneBtnAlertView:@"提示" msg:@"愿望名称不能为空" btnText:@"确定" tag:ALERTVIEW_TAG_HIDEALERT];
        return;
    }
    
    if (self.dreamIsfinishSwitch.on && [self.dreamDataTextField.text isEqualToString:@""]) {
        [self showOneBtnAlertView:@"提示" msg:@"完成的愿望一定要记得时间啊" btnText:@"确定" tag:ALERTVIEW_TAG_HIDEALERT];
        return;
    }
    
    for (int i = 0; i < [self.dreamTool getModelArr].count; i++) {
        DreamModel* model = [self.dreamTool getModelArr][i];
        if ([self.dreamNameTextField.text isEqualToString:model.name]) {
            if (self.dreamModel != nil && i == self.index) {
                break;
            }
            [self showOneBtnAlertView:@"提示" msg:@"愿望名称已存在" btnText:@"确定" tag:ALERTVIEW_TAG_HIDEALERT];
            return;
        }
    }
    
    DreamModel* newDream = [[DreamModel alloc] init];
    newDream.name = self.dreamNameTextField.text;
    newDream.isFinish = [NSString stringWithFormat:@"%d", self.dreamIsfinishSwitch.on];
    if(self.dreamIsfinishSwitch.on){
        newDream.detail = self.dreamDetailTextField.text;
        newDream.date = self.dreamDataTextField.text;
        if (self.isSelectImg) {
            NSString* imgName = [NSString stringWithFormat:@"%@.png",self.dreamNameTextField.text];
            NSString* imgPath = [DREAM_IMG_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imgName]];
            [UIImagePNGRepresentation(self.dreamImageView.image) writeToFile:imgPath atomically:YES];
            newDream.imgPath = imgName;
        }
        else{
            newDream.imgPath = @"";
        }
    }
    if (self.dreamModel != nil) {
        if ([self.dreamTool editModel:self.index model:newDream]) {
            [self.navigationController popViewControllerAnimated:YES];
            if ([self.editDelegate respondsToSelector:@selector(editDreamFinish:)]) {
                [self.editDelegate editDreamFinish:newDream];
            }
        }
        else{
            [self showOneBtnAlertView:@"提示" msg:@"愿望修改失败，请重试" btnText:@"确定" tag:ALERTVIEW_TAG_HIDEALERT];
        }
    }
    else{
        if ([self.dreamTool addNewModel:newDream]) {
            [self.navigationController popViewControllerAnimated:YES];
            if ([self.addDelegate respondsToSelector:@selector(addDreamFinish)]) {
                [self.addDelegate addDreamFinish];
            }
        }
        else{
            [self showOneBtnAlertView:@"提示" msg:@"新愿望添加失败，请重试" btnText:@"确定" tag:ALERTVIEW_TAG_HIDEALERT];
        }
    }
}

- (void)showSelectPic:(id)sender {
    [self.view endEditing:YES];
    [self callActionSheetFunc];
}

#pragma mark - 图片相关
/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else{
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    actionSheet.tag = 1000;
    [actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
//        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
}

//选择图片后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.isSelectImg = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image.size.width / image.size.height > self.dreamImageView.width / self.dreamImageView.height) {
        if (image.size.width > self.dreamImageView.width) {
            image = [MyTools scaleImage:image toScale:self.dreamImageView.width / image.size.width];
        }
    }
    else{
        if (image.size.height > self.dreamImageView.height) {
            image = [MyTools scaleImage:image toScale:self.dreamImageView.height / image.size.height];
        }
    }
    
    [self selectedPicChangeView:image];
    [self isFinish];
}

- (void)selectedPicChangeView:(UIImage*)image{
    self.dreamImageView.height = image.size.height;
    self.dreamImageView.image = image;
    self.dreamImageView.hidden = NO;
    
    [self.selectPicBtn setTitle:@"点击更换图片" forState:UIControlStateNormal];
    
    self.selectPicBtn.y = self.selectPicBtn.y + image.size.height;
    self.addBtn.y = self.addBtn.y + image.size.height;
}

#pragma mark - 弹出框相关
-(void)showOneBtnAlertView:(NSString*)title msg:(NSString*)msg btnText:(NSString*)text tag:(int)tag {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:text otherButtonTitles:nil];
    alertView.tag = tag;
    [alertView show];
}

//Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    if (alertView.tag == ALERTVIEW_TAG_HIDEALERT) {
        return;
    }
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel button clicked");
            break;
        case 1:
            NSLog(@"OK button clicked");
            break;
            
        default:
            break;
    }
}
@end
