//
//  rewardViewController.m
//  completeImage
//
//  Created by 张力 on 14-8-8.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "rewardViewController.h"


@interface rewardViewController ()
@property (nonatomic ,strong) UIView *shareView ;
@property (nonatomic ,strong) UIView *bottomBar ;
@property (nonatomic ,strong) UIButton *aBtn;
@property (nonatomic ,strong) UIButton *cancelCamera;
@property (nonatomic ,strong) UIButton *cameraDevice;
@property (nonatomic ,strong) UIButton *shutter;
@property (nonatomic ,strong) UIButton *retakeButton;
@end


@implementation rewardViewController


-(int)countBabyLevel
{
    int timeUsed = seconds;
    
    [self.willStopDelegate willStopTimer];
    
    int scoreTemp = [[scores objectAtIndex:[self.levelReward intValue]] intValue];
    
    if (scoreTemp > 9) {
        return 4;
    }else
    {
        if (scoreTemp == 0) {
            if (timeUsed  < 70) {
                return 9;
            }else
            {
            return 0;
            }
        }else
            return (1+(scoreTemp-1)/3);
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        if ([[UIScreen mainScreen] bounds].size.height == 480) {
//
//            [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage480"]];
//            
//        }else
//        {
//
//            [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage"]];
//            
//        }
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        
        
    }else
    {
        [self.view setFrame:CGRectMake(0, 0, 320, 568)];
    }
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, IPhoneHeight*60/568, 320, IPhoneHeight - IPhoneHeight*73/568 - IPhoneHeight*60/568)];
    self.shareView.backgroundColor = [UIColor clearColor];
    
    self.frontImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, 320, self.shareView.frame.size.height)];
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -IPhoneHeight*60/568, 320, 426)];
    self.rewardImage = [[UIImageView alloc] initWithFrame:CGRectMake(-300,-300,300 ,300)];//frame for animation.
    
    [self.frontImage setClipsToBounds:YES];
    [self.backImage setClipsToBounds:YES];
    
    self.frontImage.backgroundColor = [UIColor clearColor];
    self.backImage.backgroundColor = [UIColor clearColor];
    
    //    [self.shareView addSubview:self.backImage];
    [self.shareView addSubview:self.backImage];
    [self.shareView sendSubviewToBack:self.backImage];
    [self.shareView addSubview:self.frontImage];
    [self.shareView addSubview:self.rewardImage];
    [self.shareView bringSubviewToFront:self.rewardImage];
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        self.share = [[UIButton alloc] initWithFrame:CGRectMake(125, 395, 70, 70)];
        self.retakeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 395, 70, 70)];
        self.savePic = [[UIButton alloc] initWithFrame:CGRectMake(243, 408, 50, 50)];
        self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
        [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage460"]];
        
        self.babyTextImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 169, 220, 125)];
        self.goCamera = [[UIButton alloc] initWithFrame:CGRectMake(110, 298, 125, 87)];
        
    }else
    {
        self.share = [[UIButton alloc] initWithFrame:CGRectMake(125, 490, 80, 80)];
        self.retakeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 490, 80, 80)];
        self.savePic = [[UIButton alloc] initWithFrame:CGRectMake(243, 498, 60, 60)];
        self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage"]];
        self.babyTextImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 209, 240, 134)];
        self.goCamera = [[UIButton alloc] initWithFrame:CGRectMake(92, 380, 139, 96)];


    }
    [self.view addSubview:self.backgroundImg];
    self.babyTextImg.alpha = 0;
    [self.view addSubview:self.babyTextImg];
    [self.goCamera setImage:[UIImage imageNamed:@"goPhoto"] forState:UIControlStateNormal];
    self.goCamera.alpha = 0;
    [self.goCamera addTarget:self action:@selector(goPhotograph) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.goCamera];


    [self.share setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"分享" ofType:@"png"]] forState:UIControlStateNormal];
    [self.share addTarget:self action:@selector(shareFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.retakeButton setImage:[UIImage imageNamed:@"重拍"] forState:UIControlStateNormal];
    [self.retakeButton addTarget:self action:@selector(goPhotograph) forControlEvents:UIControlEventTouchUpInside];
    
    [self.savePic setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.savePic addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.shareView];
    [self.view sendSubviewToBack:self.shareView];
    
    [self.view addSubview:self.share];
    [self.share setHidden:YES];
    [self.view addSubview:self.retakeButton];
    [self.view addSubview:self.savePic];
    
    [self.retakeButton setHidden:YES];
    [self.savePic setHidden:YES];
    

    
    [self.view bringSubviewToFront: self.backgroundImg];
    [self.view bringSubviewToFront: self.topBar];
    [self.view bringSubviewToFront: self.babyRewordImg];
    [self.view bringSubviewToFront: self.goCamera];
    [self.view bringSubviewToFront:self.babyTextImg];
    
//    [self performSelector:@selector(animationStart) onThread:[[NSThread alloc] init] withObject:nil waitUntilDone:NO];
    
    
        _afterShutter = NO;

}

-(void)animationStart
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(goBigSmall) object:nil];
    
    [thread start];

    

}
-(void)goBigSmall
{
    self.babyRewordImg.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"bigsmall"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.5];
    self.babyRewordImg.frame=CGRectMake(-10 , 160, 340, 340);
    [UIView setAnimationDidStopSelector:@selector(gosmall)];
    [UIView commitAnimations];
}
-(void)gosmall
{
    
    self.babyRewordImg.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"small"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        self.babyRewordImg.frame=CGRectMake(90 , 54, 140, 140);

    }else
    {
        self.babyRewordImg.frame=CGRectMake(75 , 62, 170, 170);

    }
    [UIView setAnimationDidStopSelector:@selector(fadeIn)];
    [UIView commitAnimations];
    
}

-(void)fadeIn
{
    self.babyTextImg.transform = CGAffineTransformIdentity;
    self.goCamera.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"fadeIn"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.5];
    self.goCamera.alpha = 1.0;
    self.babyTextImg.alpha = 1.0;
    [UIView commitAnimations];

    
}

//- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView {
//    CABasicAnimation *animation = [ CABasicAnimation
//                                   animationWithKeyPath: @"transform" ];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    //围绕Z轴旋转，垂直与屏幕
//    animation.toValue = [ NSValue valueWithCATransform3D:
//                         CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.4;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 16;
////    animation.removedOnCompletion = YES;
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [imageView.layer addAnimation:animation forKey:nil ];
//    return imageView;
//}
//
//- (UIImageView *)bigWithImageView:(UIImageView *)imageView {
//    CABasicAnimation *animation = [ CABasicAnimation
//                                   animationWithKeyPath: @"transform" ];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    //围绕Z轴旋转，垂直与屏幕
//    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5,1.5 )
//                         ];
//
//    animation.duration = 0.5;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 2;
////    animation.removedOnCompletion = YES;
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [imageView.layer addAnimation:animation forKey:nil ];
//    return imageView;
//}
//
//- (UIImageView *)smallWithImageView:(UIImageView *)imageView {
//    CABasicAnimation *animation = [ CABasicAnimation
//                                   animationWithKeyPath: @"transform" ];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5,0.5 )
//                         ];
//    animation.duration = 0.4;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 1;
////    animation.removedOnCompletion = YES;
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [imageView.layer addAnimation:animation forKey:nil ];
//    return imageView;
//}

-(void)viewWillAppear:(BOOL)animated
{

    [MobClick beginLogPageView:@"rewardPage"];

    
    [self.babyRewordImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"baby%d",[self countBabyLevel]]]];
    [self.rewardImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"baby%d",[self countBabyLevel]]]];
    [self.babyTextImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"babyText%d",[self countBabyLevel]]]];


    
    if (_afterShutter){
        [self.goCamera setHidden:YES];
        [self.backgroundImg setHidden:YES];
        [self.babyRewordImg setHidden:YES];
        [self.babyTextImg setHidden:YES];
        [self.share setHidden:NO];
        [self.retakeButton setHidden:NO];
        [self.savePic setHidden:NO];


        
        if ([[UIScreen mainScreen] bounds].size.height == 480) {

            UIImageView *bottombar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-IPhoneHeight*73/568-20, 320, IPhoneHeight*73/568)];
            [bottombar setImage:[UIImage imageNamed:@"bottomImage"]];
            [self.view addSubview:bottombar];
//            [self.view bringSubviewToFront:bottombar];
            
//            self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图480" ofType:@"png"]]];
            [self.view bringSubviewToFront:self.share];
            [self.view bringSubviewToFront:self.savePic];
            [self.view bringSubviewToFront:self.retakeButton];
            
            [self.frontImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@480",self.frontImageName]]];
        }else
        {
           self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图" ofType:@"png"]]];
            
            [self.frontImage setImage:[UIImage imageNamed:self.frontImageName]];
        }
        
        
    }else//未拍摄时的界面
    {
        [self.frontImage setImage:nil];
        [self.view bringSubviewToFront: self.topBar];
        [self.share setHidden:YES];
        [self.retakeButton setHidden:YES];
        [self.savePic setHidden:YES];
        [self.goCamera setHidden:NO];
        [self.backgroundImg setHidden:NO];
        [self.babyRewordImg setHidden:NO];
        
        self.goCamera.alpha = 0.0f;
        self.babyTextImg.alpha = 0.0f;
        
        [self performSelector:@selector(animationStart) withObject:nil afterDelay:0.15f];
        
        //   [self.saveImage setHidden:YES];
        
    }

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"rewardPage"];
}

-(void)viewDidDisappear:(BOOL)animated
{
//    self.backImage.image = nil;
//    _afterShutter = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveImage:(id)sender {
    
    
    
    
    [self.shareView sendSubviewToBack:self.backImage];
    
    UIGraphicsBeginImageContext(self.shareView.frame.size);
    
    
    //获取图像
    [self.shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageShare = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(imageShare, nil, nil,nil);
    
    
    
}

- (IBAction)goPhotograph {
    
    
    //  [UIApplication sharedApplication].statusBarHidden = YES;
    self.SharePhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
    [self.SharePhotoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"拍照底图480"]]];
        self.cancelCamera = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 45, 32)];
        self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 40, 32)];
    }else
    {
        [self.SharePhotoView setFrame:CGRectMake(0, 0, 320, 568)];
        [self.SharePhotoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"拍照底图"]]];
        self.cancelCamera = [[UIButton alloc] initWithFrame:CGRectMake(5, 18, 50, 36)];
        self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 50, 36)];
        
    }
    

    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, IPhoneHeight*60/568)];
    //    topBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:167/255.0f blue:22/255.0f alpha:1.0f];
    topBar.backgroundColor = [UIColor clearColor];

    [self.cancelCamera setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
    [self.cancelCamera setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    [self.cancelCamera addTarget:self action:@selector(returnToShare) forControlEvents:UIControlEventTouchUpInside];
    
//    self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 50, 36)];
    [self.cameraDevice setImage:[UIImage imageNamed:@"前后摄像头"] forState:UIControlStateNormal];
    [self.cameraDevice addTarget:self action:@selector(exchangeDevice) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:self.cameraDevice];
    [topBar addSubview:self.cancelCamera];
    
    
    self.bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, IPhoneHeight-(IPhoneHeight*73/568), 320, IPhoneHeight*73/568)];
    //    self.bottomBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:167/255.0f blue:22/255.0f alpha:1.0f];
    
    self.bottomBar.backgroundColor = [UIColor clearColor];
    
    self.shutter = [[UIButton alloc] initWithFrame:CGRectMake(130, 15, 70, 50)];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [self.shutter setImage:[UIImage imageNamed:@"shutter"] forState:UIControlStateNormal];

    }else
    {
        [self.shutter setImage:[UIImage imageNamed:@"shutterEN"] forState:UIControlStateNormal];
    }
    [self.shutter addTarget:self action:@selector(takeMyPic) forControlEvents:UIControlEventTouchUpInside];
    
    //    NSLog(@"action:%@",[self.shutter actionsForTarget:self forControlEvent:UIControlEventTouchUpInside]);
    
    [self.bottomBar addSubview:self.shutter];
    UIImageView *backImage = [[UIImageView alloc] init];

    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [backImage setFrame:CGRectMake(0, topBar.frame.size.height+8, 320, (IPhoneHeight - topBar.frame.size.height - self.bottomBar.frame.size.height))];
        [backImage setImage:[UIImage imageNamed:@"animalShare480"]];

    }else
    {
        [backImage setFrame:CGRectMake(0, topBar.frame.size.height, 320, (IPhoneHeight - topBar.frame.size.height - self.bottomBar.frame.size.height))];
        [backImage setImage:[UIImage imageNamed:@"animalShare"]];
   
    }

    
    
    //    self.aBtn = [[UIButton alloc] init] ;
    //    [self.aBtn setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    //    [self.aBtn setTitle:@"start" forState:UIControlStateNormal];
    //    [self.aBtn setFrame:CGRectMake(0, 430, 100, 50)];
    //
    //    [self.aBtn addTarget:self action:@selector(takeMyPic) forControlEvents:UIControlEventTouchUpInside];
    
    //    [self.SharePhotoView addSubview:self.aBtn];
    
    [self.SharePhotoView addSubview:backImage];
    [self.SharePhotoView addSubview:topBar];
    [self.SharePhotoView addSubview:self.bottomBar];
    
    
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    self.picker.sourceType = sourceType;
    self.picker.cameraOverlayView = self.SharePhotoView;
    self.picker.showsCameraControls = NO;
    // picker.view.frame = CGRectMake(0,20, 320, 348);
    
    [self presentViewController:self.picker animated:YES completion:Nil];
    //   [self performSelector:@selector(setupCamera:) withObject:self.picker.view afterDelay:0.35f];
    

}



-(void)exchangeDevice
{
    if (self.picker.cameraDevice ==UIImagePickerControllerCameraDeviceFront) {
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }else
        self.picker.cameraDevice =UIImagePickerControllerCameraDeviceFront;
}

-(void)takeMyPic
{
    //    [self.cancelCamera setHidden:YES];
    //    [self.cameraDevice setHidden:YES];
    //    [self.shutter setHidden:YES];
    //    [self.retakeButton setHidden:NO];
    
    [self.picker takePicture];
    _afterShutter = YES;
    //[self.picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)returnToShare
{
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // /* change to custom VC.
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    self.backImage.image = image;
    [self performSelector:@selector(goAttachThread) withObject:nil afterDelay:0.5f];
    

    
    
}

-(void)goAttachThread
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(goAttach) object:nil];
    
    [thread start];
}

-(void)goAttach
{
    self.rewardImage.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"goAttach"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.0];
    self.rewardImage.frame=CGRectMake(self.shareView.frame.size.width-170, self.shareView.frame.size.height-140,170 ,170);
    [UIView commitAnimations];
}

- (IBAction)backButton {
    
//    self.isBackFromReward = YES;
    
    [self.delegate isFromReward:YES];

    [self dismissViewControllerAnimated:NO completion:nil];



}


-(void)shareFunc
{
      [MobClick event:@"4"];
    
    [self.shareView sendSubviewToBack:self.backImage];
    UIGraphicsBeginImageContext(self.shareView.frame.size);
    //获取图像
    [self.shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageShare = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(imageShare, nil, nil,nil);
    
    //    [ShareSDK pngImageWithImage:imageShare];
    
    
    //    [self saveToPath:imageShare];
    //
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"smartbabyImg%ld",(ImgIndex-1)]  ofType:@"png"];
    
    
    
    //
    //
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"Smart Baby"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK pngImageWithImage:imageShare]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeImage];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}



@end
