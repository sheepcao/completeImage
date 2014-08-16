//
//  sharePhotoViewController.m
//  completeImage
//
//  Created by 张力 on 14-6-23.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "sharePhotoViewController.h"

@interface sharePhotoViewController ()

@property (nonatomic ,strong) UIView *shareView ;
@property (nonatomic ,strong) UIView *bottomBar ;
@property (nonatomic ,strong) UIButton *aBtn;
@property (nonatomic ,strong) UIButton *cancelCamera;
@property (nonatomic ,strong) UIButton *cameraDevice;
@property (nonatomic ,strong) UIButton *shutter;
@property (nonatomic ,strong) UIButton *retakeButton;

@end

@implementation sharePhotoViewController

//double takePhotoX[6] = {80,213,103,227,70,220};
//double takePhotoY[6] = {220,213,103,227,70,220};



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [self.frontImage setClipsToBounds:YES];
    [self.backImage setClipsToBounds:YES];

    self.frontImage.backgroundColor = [UIColor clearColor];
    self.backImage.backgroundColor = [UIColor clearColor];
    
//    [self.shareView addSubview:self.backImage];
    [self.shareView addSubview:self.backImage];
    [self.shareView sendSubviewToBack:self.backImage];
    [self.shareView addSubview:self.frontImage];

/*
    self.saveImage = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 40, 30)];
    [self.saveImage setTitle:@"保存" forState:UIControlStateNormal];
    self.saveImage.backgroundColor = [UIColor lightGrayColor];
    [self.saveImage addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
*/
    
    self.share = [[UIButton alloc] initWithFrame:CGRectMake(125, 490, 80, 80)];
    [self.share setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    
    self.retakeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 490, 80, 80)];
    [self.retakeButton setImage:[UIImage imageNamed:@"重拍"] forState:UIControlStateNormal];
    [self.retakeButton addTarget:self action:@selector(photograph:) forControlEvents:UIControlEventTouchUpInside];
    
    self.savePic = [[UIButton alloc] initWithFrame:CGRectMake(243, 498, 60, 60)];
    [self.savePic setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.savePic addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
    
    

    self.photograph = [[UIButton alloc] initWithFrame:CGRectMake(100, 390, 120, 55)];
//    [self.photograph setTitle:@"我也要拍" forState:UIControlStateNormal];
//    self.photograph.backgroundColor = [UIColor lightGrayColor];
//    self.photograph.alpha = 0.6f;
/*

    }else if(level %11 ==0)
    {
        self.photograph = [[UIButton alloc] initWithFrame:CGRectMake(110, 515, 100, 30)];
        [self.photograph setTitle:@"我也要拍" forState:UIControlStateNormal];
        self.photograph.backgroundColor = [UIColor lightGrayColor];
    }
 */
    [self.photograph addTarget:self action:@selector(photograph:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.shareView];
    [self.view sendSubviewToBack:self.shareView];
    
    [self.view addSubview:self.photograph];
    [self.photograph setHidden:NO];

    [self.view addSubview:self.share];
    [self.share setHidden:YES];
    
    [self.view addSubview:self.retakeButton];
    [self.view addSubview:self.savePic];

    [self.retakeButton setHidden:YES];
    [self.savePic setHidden:YES];
    
    _afterShutter = NO;

    
}

- (void)viewWillAppear:(BOOL)animated
{

    //拍摄完后的界面
//    if (self.backImage.image) {
    if (_afterShutter){
        [self.photograph setHidden:YES];
        [self.share setHidden:NO];
        [self.retakeButton setHidden:NO];
        [self.savePic setHidden:NO];
        
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图480" ofType:@"png"]]];
        }else
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图" ofType:@"png"]]];
        }

//        self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图" ofType:@"png"]]];
        [self.frontImage setImage:[UIImage imageNamed:self.frontImageName]];
       // [self.saveImage setHidden:NO];

        
    }else//未拍摄时的界面
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notFinish" ofType:@"png"]]];
        [self.frontImage setImage:nil];
        [self.photograph setHidden:NO];
        [self.share setHidden:YES];
        [self.retakeButton setHidden:YES];
        [self.savePic setHidden:YES];
     //   [self.saveImage setHidden:YES];

    }
}

-(void)viewDidDisappear:(BOOL)animated
{
//    self.backImage.image = nil;
//    afterShutter = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 保存图片至沙盒 和 系统相册
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    
    
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

- (IBAction)photograph:(id)sender {
    
  //  [UIApplication sharedApplication].statusBarHidden = YES;
    self.SharePhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, IPhoneHeight)];
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {

        [self.SharePhotoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"拍照底图480"]]];
    }else
    {
        [self.SharePhotoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"拍照底图"]]];
    }

    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, IPhoneHeight*60/568)];
//    topBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:167/255.0f blue:22/255.0f alpha:1.0f];
    topBar.backgroundColor = [UIColor clearColor];
    self.cancelCamera = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 53, 38)];
    [self.cancelCamera setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
    [self.cancelCamera setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    [self.cancelCamera addTarget:self action:@selector(returnToShare) forControlEvents:UIControlEventTouchUpInside];
    
    self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 50, 36)];
    [self.cameraDevice setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [self.cameraDevice addTarget:self action:@selector(exchangeDevice) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:self.cameraDevice];
    [topBar addSubview:self.cancelCamera];
    
    
    self.bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, IPhoneHeight-(IPhoneHeight*73/568), 320, IPhoneHeight*73/568)];
//    self.bottomBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:167/255.0f blue:22/255.0f alpha:1.0f];
    self.bottomBar.backgroundColor = [UIColor clearColor];

    self.shutter = [[UIButton alloc] initWithFrame:CGRectMake(130, 5, 70, 50)];
    [self.shutter setImage:[UIImage imageNamed:@"shutter"] forState:UIControlStateNormal];
    [self.shutter addTarget:self action:@selector(takeMyPic) forControlEvents:UIControlEventTouchUpInside];
    
//    NSLog(@"action:%@",[self.shutter actionsForTarget:self forControlEvent:UIControlEventTouchUpInside]);

    [self.bottomBar addSubview:self.shutter];
    

    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, topBar.frame.size.height, 320, (IPhoneHeight - topBar.frame.size.height - self.bottomBar.frame.size.height))];
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        [backImage setImage:[UIImage imageNamed:@"animalShare480"]];
        
    }else
    {
        [backImage setImage:[UIImage imageNamed:@"animalShare"]];
        
    }
//    [backImage setImage:[UIImage imageNamed:@"animalShare"]];
    
    
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

-(UIView *)findView:(UIView *)aView withName:(NSString *)name{
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc])
        return aView;
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++)
    {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findView:subView withName:name];
        if (subView)
            return subView;
    }
    return nil;
}
-(UIView *)findView2:(UIView *)aView {
//    Class cl = [aView class];

    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++)
    {
        UIView *subView = [aView.subviews objectAtIndex:i];
   
        if ((subView.frame.size.height>160 && subView.frame.size.height<500)) {
            NSLog(@"subs:%@",subView);

        }
        subView = [self findView2:subView];
        if (subView)
            return subView;
    }
    return nil;
}

-(void)setupCamera:(UIView *)cameraView
{
    
    UIView *ttt = [self findView2:cameraView ];
    if (ttt.frame.size.height>160 && ttt.frame.size.height<500) {
        NSLog(@"%@",ttt);

    }
//
    
//    NSArray *plcameraview = [cameraView subviews];
//    NSLog(@"subviews:%@",plcameraview);
//    
//    NSArray *views = [plcameraview[0] subviews];
//    NSLog(@"camera views:%@",views);
//    NSArray *view2 = [views[0] subviews];
//    NSLog(@"view2:%@",view2);
//    
//    NSArray *CMRsubview = [view2[0] subviews];
//    NSLog(@"camera subviews:%@",CMRsubview);
//    
//   
//    CGRect bottomFrame;
//    
//    for (UIView *subs in CMRsubview) {
//        if (subs.frame.origin.y>100) {
//            
//            bottomFrame = subs.frame;
//    
//            [subs setHidden:YES];
//        }
//    }
//    
//    //add custom bottom view.
//    
//    UIView *customBottom = [[UIView alloc] initWithFrame:bottomFrame];
//    customBottom.backgroundColor = [UIColor whiteColor];
//    
//    [view2[0] addSubview:customBottom];
//
    
//    
//    UIView *PLCameraView=[self findView:cameraView withName:@"PLCropOverlayBottomBar"];
//  //  UIView *bottomBar=[self findView:PLCameraView withName:@"PLCropOverlayBottomBar"];
//    UIView *bottomBarImageForSave = [PLCameraView.subviews objectAtIndex:0];
//    self.retakeButton=[bottomBarImageForSave.subviews objectAtIndex:0];
//    [self.retakeButton setTitle:@"重拍" forState:UIControlStateNormal];  //左下角按钮


    
    
//    UIButton *useButton=[bottomBarImageForSave.subviews objectAtIndex:1];
//    [useButton setTitle:@"上传" forState:UIControlStateNormal];  //右下角按钮
}


- (IBAction)returnToGame:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];

}
-(void)returnToShare
{
    [self dismissViewControllerAnimated:YES completion:Nil];

}



#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
 // /* change to custom VC.
   
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    


    self.backImage.image = image;
    
//    [self performSelector:@selector(wait) withObject:nil afterDelay:0.25f];
   
   
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

   // [self presentViewController:picker animated:YES completion:Nil];
//
//    AfterTakePicViewController *myAfterPicVC = [[AfterTakePicViewController alloc] initWithNibName:@"AfterTakePicViewController" bundle:nil];
//    
//    [self.picker presentViewController:myAfterPicVC animated:NO completion:nil];

    
}
-(void)wait
{
    return;
}

@end
