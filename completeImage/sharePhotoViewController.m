//
//  sharePhotoViewController.m
//  completeImage
//
//  Created by 张力 on 14-6-23.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "sharePhotoViewController.h"

@interface sharePhotoViewController ()

@property (nonatomic ,strong)UIView *shareView ;

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
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 430)];
    self.shareView.backgroundColor = [UIColor clearColor];
    
    self.frontImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, 320, 430)];
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 430)];
    [self.frontImage setClipsToBounds:YES];
    [self.backImage setClipsToBounds:YES];

    self.frontImage.backgroundColor = [UIColor clearColor];
    self.backImage.backgroundColor = [UIColor clearColor];
    
    [self.shareView addSubview:self.backImage];
    [self.shareView addSubview:self.frontImage];

/*
    self.saveImage = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 40, 30)];
    [self.saveImage setTitle:@"保存" forState:UIControlStateNormal];
    self.saveImage.backgroundColor = [UIColor lightGrayColor];
    [self.saveImage addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
*/
    
    self.share = [[UIButton alloc] initWithFrame:CGRectMake(110, 515, 100, 30)];
    [self.share setTitle:@"分享并保存" forState:UIControlStateNormal];
    self.share.backgroundColor = [UIColor lightGrayColor];

    self.photograph = [[UIButton alloc] initWithFrame:CGRectMake(110, 515, 100, 30)];
    [self.photograph setTitle:@"我也要拍" forState:UIControlStateNormal];
    self.photograph.backgroundColor = [UIColor lightGrayColor];
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
    
    [self.view addSubview:self.photograph];
    [self.photograph setHidden:NO];
   // [self.view addSubview:self.saveImage];
   // [self.saveImage setHidden:YES];
    [self.view addSubview:self.share];
    [self.share setHidden:YES];



 
    [self.frontImage setImage:[UIImage imageNamed:self.frontImageName]];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //拍摄完后的界面
    if (self.backImage.image) {
        [self.photograph setHidden:YES];
        [self.share setHidden:NO];
       // [self.saveImage setHidden:NO];

        
    }else//未拍摄时的界面
    {
        [self.photograph setHidden:NO];
        [self.share setHidden:YES];
     //   [self.saveImage setHidden:YES];

    }
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

    
    self.SharePhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 430)];
    [self.SharePhotoView setBackgroundColor:[UIColor clearColor]];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 430)];
    [backImage setImage:[UIImage imageNamed:@"flowerPhoto"]];
    /*
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [aBtn setTitle:@"start" forState:UIControlStateNormal];
    [aBtn setFrame:CGRectMake(0, 0, 100, 80)];
    */
   // [self.SharePhotoView addSubview:aBtn];
    [self.SharePhotoView addSubview:backImage];
    
    
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    picker.cameraOverlayView = self.SharePhotoView;
   // picker.view.frame = CGRectMake(0,20, 320, 348);
    
    [self presentViewController:picker animated:YES completion:Nil];
    

    
}

- (IBAction)returnToGame:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];

}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    


    self.backImage.image = image;
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    
}

@end
