//
//  sharePhotoViewController.h
//  completeImage
//
//  Created by 张力 on 14-6-23.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharePhotoViewController.h"

@interface sharePhotoViewController : UIViewController< UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic)  NSString *frontImageName;


@property (nonatomic ,strong)UIView *SharePhotoView;

- (IBAction)saveImage:(id)sender;
- (IBAction)photograph:(id)sender;

@end
