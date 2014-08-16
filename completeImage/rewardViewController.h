//
//  rewardViewController.h
//  completeImage
//
//  Created by 张力 on 14-8-8.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalVar.h"

@interface rewardViewController : UIViewController< UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *goCamera;
@property (strong, nonatomic)  UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *babyRewordImg;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (strong, nonatomic) IBOutlet UIImageView *babyTextImg;
@property (strong, nonatomic) NSNumber *levelReward;


@property (strong, nonatomic)  UIImageView *frontImage;
@property (strong, nonatomic)  UIImageView *backImage;
@property (strong, nonatomic)  UIImageView *rewardImage;

@property (weak, nonatomic)  NSString *frontImageName;
@property (nonatomic ,strong)UIView *SharePhotoView;
//@property (nonatomic ,strong) UIButton *saveImage;
@property (nonatomic ,strong) UIButton *photograph;
@property (nonatomic ,strong) UIButton *share;
@property (nonatomic ,strong) UIButton *retakePic;
@property (nonatomic ,strong) UIButton *savePic;

@property (nonatomic ,strong) UILabel *welcome;
@property (nonatomic ,strong) UIImagePickerController *picker;
@property BOOL afterShutter;


- (IBAction)saveImage:(id)sender;


- (IBAction)goPhotograph;
- (IBAction)backButton;

@end
