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

    self.saveImage = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 40, 30)];
    [self.saveImage setTitle:@"保存" forState:UIControlStateNormal];
    
    self.saveImage = [[UIButton alloc] initWithFrame:CGRectMake(220, 25, 40, 30)];
    [self.saveImage setTitle:@"分享" forState:UIControlStateNormal];

    [self.view addSubview:self.shareView];



 
    [self.frontImage setImage:[UIImage imageNamed:self.frontImageName]];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //拍摄完后的界面
    if (self.backImage.image) {
        
        
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
    
    
    self.SharePhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 430)];
    [self.SharePhotoView setBackgroundColor:[UIColor clearColor]];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 430)];
    [backImage setImage:[UIImage imageNamed:@"flowerPhoto"]];
    
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [aBtn setTitle:@"start" forState:UIControlStateNormal];
    [aBtn setFrame:CGRectMake(0, 0, 100, 80)];
    
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
    [self presentViewController:picker animated:YES completion:Nil];
    

    
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    

    self.backImage.image = image;
    
    
}
@end
