//
//  XYZViewController.m
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "XYZViewController.h"
#import "XYZPhoto.h"

#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface XYZViewController ()
@property(nonatomic, strong) NSMutableArray * photos;
@end

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"照片墙";
    self.photos = [[NSMutableArray alloc]init];
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames ) {
        if ([fileName hasPrefix:@"IMG_"]) {
            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
            [photoPaths addObject:photoPath];
        }
    }
    
    if (photoPaths) {
        for (NSInteger i = 0; i < photoPaths.count; i++) {
            CGFloat X = arc4random()%((NSInteger)self.view.bounds.size.width - IMAGEWIDTH);
            CGFloat Y = arc4random()%((NSInteger)self.view.bounds.size.height - IMAGEHEIGHT);
            CGFloat W = IMAGEWIDTH;
            CGFloat H = IMAGEHEIGHT;
                        
            XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
            [photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
            [self.view addSubview:photo];
            
            CGFloat alpha = i*1.0/photoPaths.count + 0.4;
            [photo setImageAlphaAndSpeedAndSize:alpha];
            
            [self.photos addObject:photo];
        }
    }
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
}

- (void)doubleTap {
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            return;
        }
    }
    
    CGFloat W = self.view.bounds.size.width / 3;
    CGFloat H = self.view.bounds.size.height / 3;
    
    [UIView animateWithDuration:1 animations:^{
        for (NSInteger i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateNormal) {
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W, i/3*H, W, H);
                photo.imageView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = XYZPhotoStateTogether;
            } else if (photo.state == XYZPhotoStateTogether) {
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }

    }];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
