//
//  AddDreamViewController.h
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamModel.h"
#import "DataUITextField.h"

@protocol AddDreamDelegate <NSObject>

@optional

- (void)addDreamFinish;

@end

@protocol EditDreamDelegate <NSObject>

@optional

- (void)editDreamFinish:(DreamModel*) newDream;

@end

@interface AddDreamViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate,DataUITextFieldDelegate, MyDatePickerViewDelegate>

@property (nonatomic, assign) id<AddDreamDelegate> addDelegate;
@property (nonatomic, assign) id<EditDreamDelegate> editDelegate;

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)DreamModel *dreamModel;

@end
